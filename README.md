# Infra Pipeline POA

![CI](https://github.com/lunalith/infra-pipeline-poa/actions/workflows/ci.yml/badge.svg) ![License](https://img.shields.io/badge/license-MIT-pink)

**Pipeline de DevOps ponta a ponta para uma aplicação Flask, construído por uma estudante de Ciência da Computação em Porto Alegre.**

Este projeto demonstra um fluxo de trabalho de DevOps completo para uma aplicação leve em Python (Flask), desde o desenvolvimento local até a implantação na nuvem, monitoramento e configuração segura. Ele foi projetado para ser **reprodutível, documentado e pronto para produção** - mesmo como um projeto de aprendizado.

---

## 🎯 Objetivo

O objetivo principal deste projeto é criar uma base prática e demonstrável para as seguintes competências de DevOps:

*   **Automação de CI/CD:** Automatizar testes e implantação com **GitHub Actions**.
*   **Infraestrutura como Código (IaC):** Provisionar infraestrutura na nuvem com **OpenTofu**(Terraform) e **DigitalOcean**.
*   **Observabilidade:** Monitorar o desempenho da aplicação e a saúde da infraestrutura com **New Relic**.
*   **Gerenciamento de Segredos:** Gerenciar chaves de API e outras informações sensíveis de forma segura com **Doppler**.
*   **Documentação:** Documentar decisões técnicas e arquitetura de forma clara e concisa.

> ✨ Este projeto faz parte do meu portfólio de DevOps enquanto estudante de Ciência da Computação na Unisinos (Porto Alegre).

---

## 🛠️ Stack Tecnológica

A seleção de ferramentas foi orientada para o uso de tecnologias modernas e populares no mercado, com um foco especial em aproveitar os benefícios do **GitHub Student Developer Pack**.

| Categoria          | Ferramenta                     | Benefício do GitHub Student Pack |
|--------------------|-------------------------------|----------------------------------|
| **Aplicação**      | Python + Flask                | —                                |
| **CI/CD**          | GitHub Actions                | ✅ GitHub Pro                    |
| **Infraestrutura** | Terraform + DigitalOcean      | ✅ $200 em créditos               |
| **Observabilidade**| New Relic                     | ✅ Conta Pro gratuita             |
| **Secrets**        | Doppler                       | ✅ Team Plan grátis               |
| **Desenvolvimento**| GitHub Codespaces | ✅ Acesso Pro                     |

---

## 🏗️ Arquitetura

A arquitetura do projeto é dividida em três componentes principais:

1.  **Aplicação (`/app`):** Uma aplicação web simples em Flask que serve como carga de trabalho para o pipeline.
2.  **Infraestrutura como Código (`/tofu`):** Código Terraform para provisionar os recursos necessários na DigitalOcean.
3.  **CI/CD (`/.github/workflows`):** Workflows do GitHub Actions que orquestram o build, teste e deploy da aplicação.

### Estrutura de Diretórios

```
infra-pipeline-poa/
├── .github/
│   └── workflows/
│       └── ci.yml
├── app/
│   ├── app.py
│   └── requirements.txt
├── tofu/
│   ├── environments/
│   │   ├── dev/
│   │   └── prod/
│   ├── modules/
│   │   ├── compute/
│   │   ├── database/
│   │   └── networking/
│   ├── scripts/
│   │   └── cloud-init.yaml
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── versions.tf
└── README.md
```

### Detalhes dos Componentes

*   **`/app`**: Contém a aplicação Flask. É uma aplicação "Hello, World!" que foi configurada para ser containerizada e implantada.
*   **`/tofu`**: Organizado com uma estrutura de módulos e ambientes para promover a reutilização e a separação de configurações. O diretório `modules` contém os componentes reutilizáveis da infraestrutura (computação, rede, banco de dados), enquanto `environments` define as configurações específicas para cada ambiente (desenvolvimento e produção).
*   **`/.github/workflows/ci.yml`**: Define o pipeline de CI/CD. Atualmente, ele está configurado para ser acionado em cada push para o branch `main`, executando as etapas de build, teste e implantação.

---

## 🚀 Como Executar

Para reproduzir este projeto, você precisará de contas nas seguintes plataformas:

*   GitHub
*   DigitalOcean
*   New Relic
*   Doppler

### Configuração

1.  **Fork este repositório:** Comece criando um fork deste repositório para a sua própria conta do GitHub.

2.  **Configure o Doppler:** Crie um projeto no Doppler e adicione os segredos necessários (chaves de API da DigitalOcean e New Relic). O arquivo `.doppler.yaml` no repositório já está configurado para usar o Doppler CLI para injetar os segredos no ambiente de CI/CD.

3.  **Configure os Segredos do GitHub:** Adicione o token de acesso do Doppler como um segredo no seu repositório GitHub (`DOPPLER_TOKEN`).

### Executando o Pipeline

Com a configuração concluída, qualquer push para o branch `main` irá acionar o workflow do GitHub Actions. O pipeline irá:

1.  Fazer o checkout do código.
2.  Configurar o ambiente com as ferramentas necessárias (Terraform, Python, etc.).
3.  Injetar os segredos do Doppler no ambiente.
4.  Executar o Terraform para provisionar ou atualizar a infraestrutura.
5.  Construir e testar a aplicação Flask.
6.  Implantar a aplicação na infraestrutura provisionada.

---
