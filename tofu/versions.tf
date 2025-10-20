terraform {
  # Versão mínima do OpenTofu necessária
  required_version = ">= 1.6.0"

  # Providers necessários
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.34.0"
    }
  }

  # Backend para armazenar o estado (comentado por enquanto)
  # Descomente quando quiser usar remote state
  # backend "s3" {
  #   bucket = "infra-pipeline-poa-tfstate"
  #   key    = "terraform.tfstate"
  #   region = "us-east-1"
  # }
}