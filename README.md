# Projeto DeusExMachina 🤖

## Descrição Breve

DeusExMachina é uma plataforma de automação inteligente e autoexpansível. Utilizando n8n como orquestrador, Ollama para inteligência local e PostgreSQL para persistência, o sistema é projetado para executar, planejar, corrigir a si mesmo e otimizar fluxos de trabalho complexos de forma modular e escalável.

## Visão Geral da Arquitetura

A plataforma opera com uma arquitetura de microsserviços containerizada com Docker. Os principais componentes são:

* **n8n:** O cérebro dos workflows, responsável pela execução da lógica de negócios e integração entre serviços.
* **PostgreSQL (`db`):** A base de dados principal, armazenando os dados dos workflows e outros dados estruturados.
* **Ollama:** Fornece um LLM local para tarefas de inteligência, como análise, planejamento e geração de código.
* **Adminer:** Uma interface web leve para visualização e gerenciamento do banco de dados.

Todos os serviços se comunicam em uma rede Docker interna e segura (`dem-network`), e os dados são persistidos usando volumes nomeados.

![Diagrama da Arquitetura](https://i.imgur.com/URL_PARA_UM_DIAGRAMA_SIMPLES.png)
*(Nota: Um diagrama visual pode ser adicionado aqui para ilustrar o fluxo.)*

## Pré-requisitos

* **Docker:** [Instruções de instalação](https://docs.docker.com/engine/install/)
* **Docker Compose:** (geralmente incluído com o Docker Desktop)
* **GNU Make:** (geralmente pré-instalado em Linux/macOS; para Windows, pode ser instalado com Chocolatey ou WSL)

## Como Iniciar

1. **Clone o repositório:**

    ```bash
    git clone [https://github.com/deraldinho/DeusExMachina.git](https://github.com/deraldinho/DeusExMachina.git)
    cd DeusExMachina
    ```

2. **Crie e configure o ambiente:**
    Copie o arquivo de exemplo `.env.example` para `.env` e edite as senhas.

    ```bash
    cp .env.example .env
    # Abra o arquivo .env e altere as senhas
    ```

3. **Inicie a plataforma:**
    Use o comando `make` para iniciar todos os serviços. O primeiro `up` pode demorar alguns minutos enquanto as imagens são baixadas.

    ```bash
    make up
    ```

4. **Acesse os serviços:**
    * **n8n UI:** [http://localhost:5678](http://localhost:5678)
    * **Adminer (DB UI):** [http://localhost:8080](http://localhost:8080)

## Comandos Disponíveis (`Makefile`)

* `make up`: Inicia todos os serviços em segundo plano.
* `make reset`: **(CUIDADO)** Para os containers e apaga permanentemente todos os dados dos volumes. Exige confirmação.
* `make build`: Força a reconstrução das imagens Docker.
* `make logs`: Exibe os logs de todos os serviços em tempo real.
* `make psql`: Abre um shell interativo no banco de dados PostgreSQL.
* `make reset`: **(CUIDADO)** Para os containers e apaga permanentemente todos os dados dos volumes. Exige confirmação.* `make reset`: **(CUIDADO)** Para os containers e apaga permanentemente todos os dados dos volumes. Exige confirmação.
