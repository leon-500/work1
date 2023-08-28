# Ubuntu 20.04 LTS
#
#
#
# Kubernetes cluster
#
# master nodes
#
resource "null_resource" "kubernetes-master" {
  count = var.masters
  depends_on = [yandex_compute_instance.master]
  connection {
    user        = var.ssh_credentials.user
    private_key = file(var.ssh_credentials.private_key)
    host        = yandex_compute_instance.master[count.index].network_interface.0.nat_ip_address
  }

  provisioner "remote-exec" {
    inline = [
    "sudo apt-get update -y",
	  "wget -O - https://gitlab.com/edu5920529/script/-/raw/main/40_ubuntu2004_kubeadm.sh | bash"
	]
  }
}

#
# worker nodes
#
resource "null_resource" "kubernetes-worker" {
  count = var.workers
  depends_on = [yandex_compute_instance.worker]
  connection {
    user        = var.ssh_credentials.user
    private_key = file(var.ssh_credentials.private_key)
    host        = yandex_compute_instance.worker[count.index].network_interface.0.nat_ip_address
  }

  provisioner "remote-exec" {
    inline = [
    "sudo apt-get update -y",
	  "wget -O - https://gitlab.com/edu5920529/script/-/raw/main/40_ubuntu2004_kubeadm.sh | bash"
	]
  }
}

#
# kubernetes cluster init
#
resource "null_resource" "kubernetes-cluster-init" {
  depends_on = [null_resource.kubernetes-master]
  connection {
    user        = var.ssh_credentials.user
    private_key = file(var.ssh_credentials.private_key)
    host        = yandex_compute_instance.master[0].network_interface.0.nat_ip_address
  }

  provisioner "remote-exec" {
    inline = [
    "sudo apt-get install -y kubectl",
    "sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --control-plane-endpoint \"master0:6443\" --upload-certs | tee /tmp/kubeadm-init.out",
    "sleep 30",
    "tail -n 2 /tmp/kubeadm-init.out > /tmp/worker.sh",
    "mkdir -p $HOME/.kube",
    "sudo cp -i  /etc/kubernetes/admin.conf $HOME/.kube/config",
    "sudo chown $(id -u):$(id -g) $HOME/.kube/config",
    "kubectl apply -f https://github.com/flannel-io/flannel/releases/latest/download/kube-flannel.yml",
    "wget -O - https://gitlab.com/edu5920529/script/-/raw/main/50_helm3_install.sh | bash"
	]
  }

  provisioner "local-exec" {
    command = "scp -i ${var.ssh_credentials.private_key} -o StrictHostKeyChecking=no ${var.ssh_credentials.user}@${yandex_compute_instance.master[0].network_interface.0.nat_ip_address}:/tmp/kubeadm-init.out /tmp/kubeadm-init.out"
  }
  
  provisioner "local-exec" {
    command = "scp -i ${var.ssh_credentials.private_key} -o StrictHostKeyChecking=no ${var.ssh_credentials.user}@${yandex_compute_instance.master[0].network_interface.0.nat_ip_address}:/tmp/worker.sh /tmp/worker.sh"
  }
}

#
# kubernetes worker join
#
resource "null_resource" "kubernetes-worker-join" {
  count = var.workers
  depends_on = [null_resource.kubernetes-worker, null_resource.kubernetes-cluster-init]
  connection {
    user        = var.ssh_credentials.user
    private_key = file(var.ssh_credentials.private_key)
    host        = yandex_compute_instance.worker[count.index].network_interface.0.nat_ip_address
  }

  provisioner "file" {
    source      = "/tmp/worker.sh"
    destination = "/tmp/worker.sh"
  }

  provisioner "remote-exec" {
    inline = [
    "sudo chmod +x /tmp/worker.sh",
    "sudo /tmp/worker.sh",
    "sleep 30"
	]
  }
}

#
# test
#
resource "null_resource" "kubernetes-test" {
  depends_on = [null_resource.kubernetes-worker-join, null_resource.k8s-gitlab-runner]
  connection {
    user        = var.ssh_credentials.user
    private_key = file(var.ssh_credentials.private_key)
    host        = yandex_compute_instance.master[0].network_interface.0.nat_ip_address
  }

  provisioner "remote-exec" {
    inline = [
    "kubectl get nodes > /tmp/k8s_nodes",
    "kubectl get all -A > /tmp/k8s_get_all",
    "helm version > /tmp/k8s_helm_version"
  ]
  }
  
  provisioner "local-exec" {
    command = "scp -i ${var.ssh_credentials.private_key} -o StrictHostKeyChecking=no ${var.ssh_credentials.user}@${yandex_compute_instance.master[0].network_interface.0.nat_ip_address}:/tmp/k8s_nodes /tmp/k8s_nodes"
  }

  provisioner "local-exec" {
    command = "scp -i ${var.ssh_credentials.private_key} -o StrictHostKeyChecking=no ${var.ssh_credentials.user}@${yandex_compute_instance.master[0].network_interface.0.nat_ip_address}:/tmp/k8s_get_all /tmp/k8s_get_all"
  }

  provisioner "local-exec" {
    command = "scp -i ${var.ssh_credentials.private_key} -o StrictHostKeyChecking=no ${var.ssh_credentials.user}@${yandex_compute_instance.master[0].network_interface.0.nat_ip_address}:/tmp/k8s_helm_version /tmp/k8s_helm_version"
  }
}