#!/bin/bash
set -e

echo "🚀 Configurando ambiente de desenvolvimento..."

# Instalar dependências Python
echo "📦 Instalando dependências Python..."
pip install --upgrade pip
pip install -r app/requirements.txt

# Instalar OpenTofu
echo "🔧 Instalando OpenTofu..."
curl -fsSL https://get.opentofu.org/install-opentofu.sh -o /tmp/install-opentofu.sh
chmod +x /tmp/install-opentofu.sh
sudo /tmp/install-opentofu.sh --install-method standalone
rm /tmp/install-opentofu.sh

# Verificar instalação
echo "✅ Verificando instalações..."
python --version
tofu --version

# Instalar Doppler CLI
echo "🔐 Instalando Doppler CLI..."
curl -Ls --tlsv1.2 --proto "=https" https://cli.doppler.com/install.sh | sudo sh

echo "✨ Ambiente configurado com sucesso!"
echo ""
echo "📝 Próximos passos:"
echo "1. Configure suas secrets no GitHub Codespaces"
echo "2. Execute: doppler login"
echo "3. Navegue até a pasta tofu/: cd tofu"
echo "4. Inicie o OpenTofu: tofu init"