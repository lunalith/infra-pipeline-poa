# Provider da DigitalOcean
provider "digitalocean" {
  # Token de autenticação (vem do Doppler via variável de ambiente)
  token = var.do_token
}

# Configuração de variável para o token
variable "do_token" {
  description = "DigitalOcean API Token"
  type        = string
  sensitive   = true

  # O valor vem da variável de ambiente DIGITALOCEAN_TOKEN
  # Quando rodar com Doppler, ele injeta automaticamente
  default = null
}

# Data source para listar regiões disponíveis
data "digitalocean_regions" "available" {
  filter {
    key    = "available"
    values = ["true"]
  }
}