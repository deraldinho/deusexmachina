# Projeto DeusExMachina 🤖

## Descrição Breve

DeusExMachina é uma plataforma de automação inteligente e autoexpansível. Utilizando n8n como orquestrador, Ollama para inteligência local e PostgreSQL para persistência, o sistema é projetado para executar, planejar, corrigir a si mesmo e otimizar fluxos de trabalho complexos de forma modular e escalável.

## Visão Geral da Arquitetura

A plataforma opera com uma arquitetura de microsserviços containerizada com Docker. Os principais componentes são:

* **n8n:** O cérebro dos workflows, responsável pela execução da lógica de negócios e integração entre serviços.
* **PostgreSQL (`db`):** A base de dados principal, armazenando os dados dos workflows e outros dados estruturados.
* **Ollama:** Fornece um LLM local para tarefas de inteligência, como análise, planejamento e geração de código.
* **Open WebUI:** Uma interface de usuário para interagir com o Ollama.
* **Redis:** Um armazenamento de dados em memória, usado para filas e cache pelo n8n.
* **MinIO:** Um serviço de armazenamento de objetos compatível com S3.
* **Adminer:** Uma interface web leve para visualização e gerenciamento do banco de dados PostgreSQL.
* **cAdvisor:** Coleta e processa métricas de desempenho e uso de recursos de containers.
* **Prometheus:** Um sistema de monitoramento e alerta de código aberto, coleta métricas do cAdvisor.
* **Grafana:** Uma plataforma de análise e visualização de dados, usada para criar dashboards com as métricas do Prometheus.
* **Alertmanager:** Gerencia e envia alertas gerados pelo Prometheus.
* **Portainer:** Uma ferramenta de gerenciamento de interface gráfica para ambientes Docker.

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
    * **Open WebUI:** [http://localhost:8080](http://localhost:8080)
    * **Adminer (DB UI):** [http://localhost:8081](http://localhost:8081)
    * **MinIO Console:** [http://localhost:9001](http://localhost:9001)
    * **cAdvisor UI:** [http://localhost:8082](http://localhost:8082)
    * **Prometheus UI:** [http://localhost:9090](http://localhost:9090)
    * **Grafana UI:** [http://localhost:3001](http://localhost:3001)
    * **Alertmanager UI:** [http://localhost:9093](http://localhost:9093)
    * **Portainer UI:** [https://localhost:9443](https://localhost:9443)

## Comandos Disponíveis (`Makefile`)

* `make help`: Mostra esta mensagem de ajuda com todos os comandos disponíveis.
* `make up`: Inicia todos os serviços em segundo plano.
* `make down`: Para e remove os containers.
* `make build`: Força a reconstrução das imagens Docker sem usar cache.
* `make restart`: Reinicia todos os serviços (executa 'down' e 'up').
* `make status`: Mostra o status atual de todos os containers.
* `make restart-<service>`: Reinicia um serviço específico (ex: `make restart-n8n`, `make restart-db`, `make restart-ollama`, `make restart-webui`, `make restart-redis`, `make restart-minio`, `make restart-adminer`, `make restart-cadvisor`, `make restart-prometheus`, `make restart-grafana`, `make restart-alertmanager`).
* `make logs`: Exibe os logs de TODOS os serviços.
* `make logs-<service>`: Exibe os logs de um serviço específico (ex: `make logs-n8n`, `make logs-db`, `make logs-ollama`, `make logs-webui`, `make logs-redis`, `make logs-minio`, `make logs-adminer`, `make logs-cadvisor`, `make logs-prometheus`, `make logs-grafana`, `make logs-alertmanager`).
* `make access-<service>`: Acessa um shell interativo no container de um serviço (ex: `make access-n8n`, `make access-db`, `make access-ollama`, `make access-webui`, `make access-redis`, `make access-minio`, `make access-adminer`, `make access-cadvisor`, `make access-prometheus`, `make access-grafana`, `make access-alertmanager`).
* `make open-<service>`: Abre a interface web de um serviço no navegador (ex: `make open-n8n`, `make open-webui`, `make open-minio-console`, `make open-adminer`, `make open-prometheus`, `make open-grafana`, `make open-alertmanager`).
* `make add-model MODEL=<nome>`: Baixa um novo modelo de IA para o Ollama.
* `make validate`: Valida a sintaxe e a configuração do docker compose.
* `make prune`: Limpa recursos Docker não utilizados (containers parados, redes órfãs, volumes não associados).
* `make psql`: Abre um shell interativo no banco de dados PostgreSQL.
* `make reset`: **(CUIDADO)** Para os containers e apaga TODOS os volumes de dados locais do projeto.
* `make scan-images`: Escaneia todas as imagens Docker usadas no projeto em busca de vulnerabilidades.
* `make backup-volumes`: Cria um backup compactado de todos os volumes persistentes.
* `make n8n-import-workflow FILE=<path/to/workflow.json>`: Importa um workflow n8n de um arquivo JSON.
* `make n8n-test-workflow WEBHOOK_ID=<id> [INPUT=<data>]`: Testa um workflow n8n específico via webhook.
* `make portainer-setup`: Abre o Portainer UI para configuração inicial.
