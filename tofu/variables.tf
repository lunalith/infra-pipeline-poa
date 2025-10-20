# Nome do projeto
variable "project_name" {
  description = "Nome do projeto (usado como prefixo nos recursos)"
  type        = string
  default     = "infra-pipeline-poa"
}

# Ambiente (dev, staging, prod)
variable "environment" {
  description = "Ambiente de deployment"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Ambiente deve ser: dev, staging ou prod"
  }
}

# Região da DigitalOcean (Europa)
variable "region" {
  description = "Região da DigitalOcean para criar recursos"
  type        = string
  default     = "ams3" # Amsterdam, Holanda

  validation {
    condition = contains([
      "ams3",  # Amsterdam, Netherlands
      "lon1",  # London, UK
      "fra1",  # Frankfurt, Germany
    ], var.region)
    error_message = "Região deve ser uma das seguintes na Europa: ams3 (Amsterdam), lon1 (London), fra1 (Frankfurt)"
  }
}

# Tamanho do Droplet
variable "droplet_size" {
  description = "Tamanho do Droplet (CPU e RAM)"
  type        = string
  default     = "s-1vcpu-1gb" # 1 vCPU, 1GB RAM, 25GB SSD (~$6/mês)

  validation {
    condition = contains([
      "s-1vcpu-1gb",    # $6/mês  - 1 vCPU, 1GB RAM, 25GB SSD
      "s-1vcpu-2gb",    # $12/mês - 1 vCPU, 2GB RAM, 50GB SSD
      "s-2vcpu-2gb",    # $18/mês - 2 vCPU, 2GB RAM, 60GB SSD
      "s-2vcpu-4gb",    # $24/mês - 2 vCPU, 4GB RAM, 80GB SSD
    ], var.droplet_size)
    error_message = "Tamanho inválido. Escolha entre: s-1vcpu-1gb, s-1vcpu-2gb, s-2vcpu-2gb, s-2vcpu-4gb"
  }
}

# Imagem do sistema operacional
variable "droplet_image" {
  description = "Imagem do sistema operacional"
  type        = string
  default     = "ubuntu-22-04-x64"
}

# SSH Keys (IDs das suas chaves SSH cadastradas na DigitalOcean)
variable "ssh_keys" {
  description = "Lista de IDs de SSH keys para acesso ao droplet"
  type        = list(string)
  default     = [] # Vazio por padrão, você adiciona depois
}

# Habilitar backups automáticos?
variable "enable_backups" {
  description = "Habilitar backups automáticos semanais (+20% do custo)"
  type        = bool
  default     = false # Desabilitado pra economizar no dev
}

# Habilitar monitoring?
variable "enable_monitoring" {
  description = "Habilitar monitoring da DigitalOcean (grátis)"
  type        = bool
  default     = true
}

# Tags para organização
variable "tags" {
  description = "Tags para organizar recursos"
  type        = list(string)
  default     = ["infra-pipeline", "poa", "devops"]
}

# Porta da aplicação Flask
variable "app_port" {
  description = "Porta que a aplicação Flask vai rodar"
  type        = number
  default     = 5000
}