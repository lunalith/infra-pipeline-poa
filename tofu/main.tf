# ========================================
# VPC - Rede Privada Virtual
# ========================================
resource "digitalocean_vpc" "main" {
  name        = "${var.project_name}-${var.environment}-vpc"
  region      = var.region
  description = "VPC privada para ${var.project_name} (${var.environment})"
}

# ========================================
# Firewall - Regras de Segurança
# ========================================
resource "digitalocean_firewall" "web" {
  name = "${var.project_name}-${var.environment}-firewall"

  # Aplicar firewall nos droplets com essa tag
  tags = ["${var.project_name}-${var.environment}"]

  # Regras de ENTRADA (Inbound)
  # SSH - Acesso remoto
  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  # HTTP - Web
  inbound_rule {
    protocol         = "tcp"
    port_range       = "80"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  # HTTPS - Web Seguro
  inbound_rule {
    protocol         = "tcp"
    port_range       = "443"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  # Flask App - Porta customizada
  inbound_rule {
    protocol         = "tcp"
    port_range       = tostring(var.app_port)
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  # Regras de SAÍDA (Outbound)
  # Permitir todo tráfego de saída
  outbound_rule {
    protocol              = "tcp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "udp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "icmp"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}

# ========================================
# Droplet - Servidor Virtual
# ========================================
resource "digitalocean_droplet" "app" {
  name   = "${var.project_name}-${var.environment}-server"
  image  = var.droplet_image
  size   = var.droplet_size
  region = var.region

  # Conectar à VPC
  vpc_uuid = digitalocean_vpc.main.id

  # SSH Keys (se você tiver configurado)
  ssh_keys = var.ssh_keys

  # Tags para organização e firewall
  tags = concat(
    var.tags,
    ["${var.project_name}-${var.environment}"]
  )

  # Backups e Monitoring
  backups    = var.enable_backups
  monitoring = var.enable_monitoring

  # Script de inicialização (user_data)
  user_data = templatefile("${path.module}/scripts/cloud-init.yaml", {
    app_port         = var.app_port
    project_name     = var.project_name
    environment      = var.environment
    doppler_token    = var.do_token
    new_relic_key    = ""
  })

  # Proteção contra destruição acidental em produção
  lifecycle {
    prevent_destroy = false
  }
}
