terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}


provider "yandex" {
  service_account_key_file = "./keys/authorized_key.json"
  cloud_id                 = "b1g7if7q606ukcppqe4k"
  folder_id                = "b1gcn3gn3kvb5s3gupc6"
  zone                     = "ru-central1-b"
}