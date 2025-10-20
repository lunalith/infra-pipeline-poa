output "droplet_id" {
  description = "ID do Droplet criado"
  value       = digitalocean_droplet.app.id
}

output "droplet_name" {
  description = "Nome do Droplet"
  value       = digitalocean_droplet.app.name
}

output "droplet_ipv4" {
  description = "Endereço IPv4 público do Droplet"
  value       = digitalocean_droplet.app.ipv4_address
}

output "droplet_ipv4_private" {
  description = "Endereço IPv4 privado do Droplet"
  value       = digitalocean_droplet.app.ipv4_address_private
}

output "droplet_region" {
  description = "Região onde o Droplet foi criado"
  value       = digitalocean_droplet.app.region
}

output "droplet_size" {
  description = "Tamanho do Droplet"
  value       = digitalocean_droplet.app.size
}

output "vpc_id" {
  description = "ID da VPC criada"
  value       = digitalocean_vpc.main.id
}

output "vpc_name" {
  description = "Nome da VPC"
  value       = digitalocean_vpc.main.name
}

output "firewall_id" {
  description = "ID do Firewall"
  value       = digitalocean_firewall.web.id
}

output "ssh_connection" {
  description = "Comando SSH para conectar ao servidor"
  value       = "ssh root@${digitalocean_droplet.app.ipv4_address}"
}

output "app_url" {
  description = "URL da aplicação"
  value       = "http://${digitalocean_droplet.app.ipv4_address}:${var.app_port}"
}

output "deployment_info" {
  description = "Informações do deployment"
  value = {
    project     = var.project_name
    environment = var.environment
    region      = var.region
    created_at  = digitalocean_droplet.app.created_at
  }
}