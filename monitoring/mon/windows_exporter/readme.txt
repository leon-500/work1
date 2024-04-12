Install WMI_exporter
https://github.com/prometheus-community/windows_exporter/releases

msiexec /i D:\windows_exporter\windows_exporter-0.25.1-amd64.msi ENABLED_COLLECTORS="os,cpu,cs,logical_disk,memory,net,system" EXTRA_FLAGS="--web.config.file=D:\windows_exporter\web-config.yml" LISTEN_PORT="9182"


user: user
pass: 123
hashed_pass: $2y$10$yi3hGB4Xa428MiA56dtLYOPH.ASNDsrIzWrZTI5FPXGiZciAMJYF6


Prometheus prometheus.yml
...
basic_auth:
      username: user
      password: 123
      static_configs:
      - targets: ['ip_address:9182']
...


WMI_exporter web-config.yml
...
basic_auth_users:
    user: $2y$10$yi3hGB4Xa428MiA56dtLYOPH.ASNDsrIzWrZTI5FPXGiZciAMJYF6
...


Collectors
ad				Active Directory Domain Services	 
cpu				CPU usage
cs				"Computer System" metrics (system properties, num cpus/total memory)
container		Container metrics	 
dns				DNS Server	 
hyperv			Hyper-V hosts	 
iis				IIS sites and applications	 
logical_disk	Logical disks, disk I/O
memory			Memory usage metrics	 
msmq			MSMQ queues	 
mssql			SQL Server Performance Objects metrics	 
net				Network interface I/O
os				OS metrics (memory, processes, users)
process			Per-process metrics
service			Service state metrics
system			System calls
tcp				TCP connections
thermalzone		Thermal information
textfile		Read prometheus metrics from a text file
vmware			Performance counters installed by the Vmware Guest agent
netframework_clrexceptions	.NET Framework CLR Exceptions	 
netframework_clrinterop		.NET Framework Interop Metrics	 
netframework_clrjit			.NET Framework JIT metrics	 
netframework_clrloading		.NET Framework CLR Loading metrics	 
netframework_clrlocksandthreads	.NET Framework locks and metrics threads	 
netframework_clrmemory		.NET Framework Memory metrics	 
netframework_clrremoting	.NET Framework Remoting metrics	 
netframework_clrsecurity	.NET Framework Security Check metrics




