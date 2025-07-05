# Makefile

# Define o 'help' como o comando padrão a ser executado se 'make' for chamado sem um alvo.
.DEFAULT_GOAL := help

# Evita que o 'make' confunda os alvos com nomes de arquivos.
.PHONY: help up down build status validate restart         logs logs-n8n logs-db logs-ollama logs-webui logs-redis logs-minio logs-caddy logs-adminer         logs-cadvisor logs-prometheus logs-grafana logs-alertmanager         access-n8n access-db access-ollama access-webui access-redis access-minio access-caddy access-adminer         access-cadvisor access-prometheus access-grafana access-alertmanager         open-n8n open-webui open-minio-console open-adminer open-prometheus open-grafana open-alertmanager         add-model psql prune reset scan-images backup-volumes         n8n-import-workflow n8n-test-workflow         restart-n8n restart-db restart-ollama restart-webui restart-redis restart-minio restart-caddy restart-adminer         restart-cadvisor restart-prometheus restart-grafana restart-alertmanager         portainer-setup

# Define o shell padrão a ser usado para todos os comandos
SHELL := /bin/bash

# Carrega variáveis do .env para uso no Makefile
# Oculta a mensagem de erro se o .env não existir (para tornar o Makefile mais robusto)
ifneq (,$(wildcard ./.env))
    include .env
    export
endif

# Define o domínio base para URLs de acesso, padrão para localhost se não definido
# Útil para os comandos 'open-*'
DOMAIN ?= localhost

# --- Comandos de Ciclo de Vida do Projeto ---
up: ## Inicia todos os serviços em segundo plano.
	@echo "🔧 Garantindo permissão de execução para scripts..."
	@chmod +x ./scripts/*.sh
	@echo "🚀 Iniciando todos os serviços do DeusExMachina..."
	@docker compose up -d

down: ## Para e remove os containers.
	@echo "🛑 Parando e removendo containers..."
	@docker compose down

build: ## Força a reconstrução das imagens Docker sem usar cache.
	@echo "🏗️  Forçando a reconstrução das imagens..."
	@docker compose build --no-cache

restart: ## Reinicia todos os serviços (executa 'down' e 'up').
	@echo "🔄 Reiniciando todos os serviços..."
	@make down
	@make up

# --- Controle de Serviços e Status ---
status: ## Mostra o status atual de todos os containers.
	@echo "📊 Verificando status dos containers..."
	@docker compose ps

restart-n8n: ## Reinicia apenas o container do n8n.
	@echo "🔄 Reiniciando o serviço n8n..."
	@docker compose restart n8n

restart-db: ## Reinicia apenas o container do Banco de Dados.
	@echo "🔄 Reiniciando o serviço DB..."
	@docker compose restart db

restart-ollama: ## Reinicia apenas o container do Ollama.
	@echo "🔄 Reiniciando o serviço Ollama..."
	@docker compose restart ollama

restart-webui: ## Reinicia apenas o container do Open WebUI.
	@echo "🔄 Reiniciando o serviço Open WebUI..."
	@docker compose restart open-webui

restart-redis: ## Reinicia apenas o container do Redis.
	@echo "🔄 Reiniciando o serviço Redis..."
	@docker compose restart redis

restart-minio: ## Reinicia apenas o container do MinIO.
	@echo "🔄 Reiniciando o serviço MinIO..."
	@docker compose restart minio

restart-caddy: ## Reinicia apenas o container do Caddy.
	@echo "🔄 Reiniciando o serviço Caddy..."
	@docker compose restart caddy

restart-adminer: ## Reinicia apenas o container do Adminer.
	@echo "🔄 Reiniciando o serviço Adminer..."
	@docker compose restart adminer

restart-cadvisor: ## Reinicia apenas o container do cAdvisor.
	@echo "🔄 Reiniciando o serviço cAdvisor..."
	@docker compose restart cadvisor

restart-prometheus: ## Reinicia apenas o container do Prometheus.
	@echo "🔄 Reiniciando o serviço Prometheus..."
	@docker compose restart prometheus

restart-grafana: ## Reinicia apenas o container do Grafana.
	@echo "🔄 Reiniciando o serviço Grafana..."
	@docker compose restart grafana

restart-alertmanager: ## Reinicia apenas o container do Alertmanager.
	@echo "🔄 Reiniciando o serviço Alertmanager..."
	@docker compose restart alertmanager

# --- Visualização de Logs ---
logs: ## Exibe os logs de TODOS os serviços.
	@echo "📜 Exibindo logs de TODOS os serviços..."
	@docker compose logs -f

logs-n8n: ## Exibe os logs apenas do serviço n8n.
	@echo "📜 Exibindo logs do n8n..."
	@docker compose logs -f n8n

logs-db: ## Exibe os logs apenas do serviço DB.
	@echo "📜 Exibindo logs do DB..."
	@docker compose logs -f db

logs-ollama: ## Exibe os logs apenas do serviço Ollama.
	@echo "📜 Exibindo logs do Ollama..."
	@docker compose logs -f ollama

logs-webui: ## Exibe os logs apenas do serviço Open WebUI.
	@echo "📜 Exibindo logs do Open WebUI..."
	@docker compose logs -f open-webui

logs-redis: ## Exibe os logs apenas do serviço Redis.
	@echo "📜 Exibindo logs do Redis..."
	@docker compose logs -f redis

logs-minio: ## Exibe os logs apenas do serviço MinIO.
	@echo "📜 Exibindo logs do MinIO..."
	@docker compose logs -f minio

logs-caddy: ## Exibe os logs apenas do serviço Caddy.
	@echo "📜 Exibindo logs do Caddy..."
	@docker compose logs -f caddy

logs-adminer: ## Exibe os logs apenas do serviço Adminer.
	@echo "📜 Exibindo logs do Adminer..."
	@docker compose logs -f adminer

logs-cadvisor: ## Exibe os logs apenas do serviço cAdvisor.
	@echo "📜 Exibindo logs do cAdvisor..."
	@docker compose logs -f cadvisor

logs-prometheus: ## Exibe os logs apenas do serviço Prometheus.
	@echo "📜 Exibindo logs do Prometheus..."
	@docker compose logs -f prometheus

logs-grafana: ## Exibe os logs apenas do serviço Grafana.
	@echo "📜 Exibindo logs do Grafana..."
	@docker compose logs -f grafana

logs-alertmanager: ## Exibe os logs apenas do serviço Alertmanager.
	@echo "📜 Exibindo logs do Alertmanager..."
	@docker compose logs -f alertmanager

# --- Acesso a Containers (Shell Interativo) ---
access-n8n: ## Acessa um shell interativo no container do n8n.
	@echo "🚪 Acessando shell do n8n..."
	@docker compose exec n8n bash || docker compose exec n8n sh

access-db: ## Acessa um shell interativo no container do Banco de Dados.
	@echo "🚪 Acessando shell do DB..."
	@docker compose exec db bash || docker compose exec db sh

access-ollama: ## Acessa um shell interativo no container do Ollama.
	@echo "🚪 Acessando shell do Ollama..."
	@docker compose exec ollama bash || docker compose exec ollama sh

access-webui: ## Acessa um shell interativo no container do Open WebUI.
	@echo "🚪 Acessando shell do Open WebUI..."
	@docker compose exec open-webui bash || docker compose exec open-webui sh

access-redis: ## Acessa um shell interativo no container do Redis.
	@echo "🚪 Acessando shell do Redis."
	@docker compose exec redis bash || docker compose exec redis sh

access-minio: ## Acessa um shell interativo no container do MinIO.
	@echo "🚪 Acessando shell do MinIO."
	@docker compose exec minio bash || docker compose exec minio sh

access-caddy: ## Acessa um shell interativo no container do Caddy.
	@echo "🚪 Acessando shell do Caddy."
	@docker compose exec caddy bash || docker compose exec caddy sh

access-adminer: ## Acessa um shell interativo no container do Adminer.
	@echo "🚪 Acessando shell do Adminer."
	@docker compose exec adminer bash || docker compose exec adminer sh

access-cadvisor: ## Acessa um shell interativo no container do cAdvisor.
	@echo "🚪 Acessando shell do cAdvisor..."
	@docker compose exec cadvisor bash || docker compose exec cadvisor sh

access-prometheus: ## Acessa um shell interativo no container do Prometheus.
	@echo "🚪 Acessando shell do Prometheus..."
	@docker compose exec prometheus bash || docker compose exec prometheus sh

access-grafana: ## Acessa um shell interativo no container do Grafana.
	@echo "🚪 Acessando shell do Grafana..."
	@docker compose exec grafana bash || docker compose exec grafana sh

access-alertmanager: ## Acessa um shell interativo no container do Alertmanager.
	@echo "🚪 Acessando shell do Alertmanager..."
	@docker compose exec alertmanager bash || docker compose exec alertmanager sh

# --- Acesso a Serviços (Abre no Navegador) ---
open-n8n: ## Abre a interface web do n8n no navegador.
	@echo "🌐 Abrindo n8n em http://localhost:5678/"
	@open "http://localhost:5678/" || xdg-open "http://localhost:5678/" || start "http://localhost:5678/"

open-webui: ## Abre a interface web do Open WebUI no navegador.
	@echo "🌐 Abrindo Open WebUI em http://localhost:8080/"
	@open "http://localhost:8080/" || xdg-open "http://localhost:8080/" || start "http://localhost:8080/"

open-minio-console: ## Abre o console web do MinIO no navegador.
	@echo "🌐 Abrindo MinIO Console em http://localhost:9001/"
	@open "http://localhost:9001/" || xdg-open "http://localhost:9001/" || start "http://localhost:9001/"

open-adminer: ## Abre o Adminer no navegador.
	@echo "🌐 Abrindo Adminer em http://localhost:8080/"
	@open "http://localhost:8080/" || xdg-open "http://localhost:8080/" || start "http://localhost:8080/"

open-prometheus: ## Abre a interface web do Prometheus no navegador.
	@echo "🌐 Abrindo Prometheus em http://localhost:9090/"
	@open "http://localhost:9090/" || xdg-open "http://localhost:9090/" || start "http://localhost:9090/"

open-grafana: ## Abre a interface web do Grafana no navegador.
	@echo "🌐 Abrindo Grafana em http://localhost:3001/"
	@open "http://localhost:3001/" || xdg-open "http://localhost:3001/" || start "http://localhost:3001/"

open-alertmanager: ## Abre a interface web do Alertmanager no navegador.
	@echo "🌐 Abrindo Alertmanager em http://localhost:9093/"
	@open "http://localhost:9093/" || xdg-open "http://localhost:9093/" || start "http://localhost:9093/"

# --- Gerenciamento de Modelos de IA ---
add-model: ## Baixa um novo modelo de IA para o Ollama. Uso: make add-model MODEL=<nome>
ifeq ($(MODEL),)
	@echo "❌ Erro: Nome do modelo não especificado."
	@echo "👉 Uso: make add-model MODEL=<nome_do_modelo>"
	@echo "✨ Exemplo: make add-model MODEL=llama3:8b"
	@exit 1
endif
	@echo "🤖 Baixando o modelo '$(MODEL)' para o Ollama..."
	@docker compose exec ollama ollama pull $(MODEL)
	@echo "✅ Modelo '$(MODEL)' adicionado com sucesso."

# --- Manutenção e Utilitários ---
help: ## Mostra esta mensagem de ajuda com todos os comandos disponíveis.
	@echo "🤖 Comandos disponíveis para o Projeto DeusExMachina:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-25s\033[0m %s\n", $$1, $$2}'

validate: ## Valida a sintaxe e a configuração do docker compose.
	@echo "🔍 Validando a configuração do docker compose..."
	@docker compose config > /dev/null
	@echo "✅ Configuração válida."

prune: ## Limpa recursos Docker não utilizados (containers parados, redes órfãs, volumes não associados).
	@read -p "🧹 Você tem certeza que deseja remover todos os containers parados, redes não utilizadas e volumes não associados? [y/N] " -n 1 -r; \
	echo; \
	if [[ "$$REPLY" =~ ^[Yy]$$ ]]; then \
		echo "Executando a limpeza do sistema Docker..."; \
		docker system prune -a --volumes -f; \
		echo "✅ Limpeza concluída."; \
	else \
		echo "Limpeza cancelada."; \
	fi

psql: ## Abre um shell interativo no banco de dados PostgreSQL.
	@echo "🔍 Conectando ao banco de dados PostgreSQL: ${POSTGRES_DB}..."
	@docker compose exec db psql -U ${POSTGRES_USER} -d ${POSTGRES_DB}

reset: ## CUIDADO: Para os containers e apaga TODOS os volumes de dados locais do projeto.
	@read -p "🚨 ATENÇÃO: Este comando irá parar os containers e apagar TODOS os volumes de dados persistentes do projeto (n8n, db, ollama, webui, redis, minio, caddy, prometheus, grafana, alertmanager). Você tem certeza? [y/N] " -n 1 -r; \
	echo; \
	if [[ "$$REPLY" =~ ^[Yy]$$ ]]; then \
		echo "Iniciando reset completo (parando containers e removendo volumes)..."; \
		docker compose down -v; \
		echo "✅ Reset concluído."; \
	else \
		echo "Reset cancelado."; \
	fi

scan-images: ## Escaneia todas as imagens Docker usadas no projeto em busca de vulnerabilidades.
	@echo "🔎 Escaneando imagens Docker por vulnerabilidades com Trivy..."
	@docker run --rm -v /var/run/docker.sock:/var/run/docker.sock \
	    aquasec/trivy:latest image --exit-code 0 --severity HIGH --ignore-unfixed \
	    `docker compose config --images`
	@echo "✅ Varredura de imagens concluída. Verifique a saída para detalhes."
	@echo "💡 Para mais detalhes ou opções, veja: https://aquasec.com/cloud-native-security-resources/trivy/"

backup-volumes: ## Cria um backup compactado de todos os volumes persistentes.
	@echo "💾 Iniciando backup dos volumes persistentes..."
	@mkdir -p backups/$(shell date +%Y%m%d_%H%M%S)
	@BACKUP_DIR=backups/$(shell date +%Y%m%d_%H%M%S) ; \
	echo "  > Backup do n8n_data..."; \
	docker run --rm -v n8n_data:/data -v `pwd`/$$BACKUP_DIR:/backup alpine:latest tar czf /backup/n8n_data.tar.gz -C /data . ; \
	echo "  > Backup do db_data..."; \
	docker run --rm -v db_data:/data -v `pwd`/$$BACKUP_DIR:/backup alpine:latest tar czf /backup/db_data.tar.gz -C /data . ; \
	echo "  > Backup do ollama_data..."; \
	docker run --rm -v ollama_data:/data -v `pwd`/$$BACKUP_DIR:/backup alpine:latest tar czf /backup/ollama_data.tar.gz -C /data . ; \
	echo "  > Backup do minio_data..."; \
	docker run --rm -v minio_data:/data -v `pwd`/$$BACKUP_DIR:/backup alpine:latest tar czf /backup/minio_data.tar.gz -C /data . ; \
	echo "  > Backup do grafana_data..."; \
	docker run --rm -v grafana_data:/data -v `pwd`/$$BACKUP_DIR:/backup alpine:latest tar czf /backup/grafana_data.tar.gz -C /data . ; \
	echo "  > Backup do prometheus_data..."; \
	docker run --rm -v prometheus_data:/data -v `pwd`/$$BACKUP_DIR:/backup alpine:latest tar czf /backup/prometheus_data.tar.gz -C /data . ; \
	echo "  > Backup do alertmanager_data..."; \
	docker run --rm -v alertmanager_data:/data -v `pwd`/$$BACKUP_DIR:/backup alpine:latest tar czf /backup/alertmanager_data.tar.gz -C /data . ; \
	echo "✅ Backup concluído em $$BACKUP_DIR"; \
	echo "Lembre-se de transferir esses backups para um local seguro!"

n8n-import-workflow: ## Importa um workflow n8n de um arquivo JSON. Uso: make n8n-import-workflow FILE=<path/to/workflow.json>
ifeq ($(FILE),)
	@echo "❌ Erro: Arquivo JSON do workflow não especificado."
	@echo "👉 Uso: make n8n-import-workflow FILE=<caminho/do/arquivo.json>"
	@exit 1
endif
	@echo "📤 Importando workflow de $(FILE) para o n8n..."
	@curl -s -X POST "https://n8n.$(DOMAIN)/api/v1/workflows?import=true" \
	-H "Content-Type: application/json" \
	-H "X-N8N-API-KEY: $(N8N_USER_API_KEY)" \
	--data-binary "@$(FILE)" | python -m json.tool || echo "Erro ao importar workflow."
	@echo "✅ Workflow importado (ou atualizado) no n8n."
	@echo "Lembre-se de ativar o workflow no n8n se for a primeira importação."

n8n-test-workflow: ## Testa um workflow n8n específico via webhook. Uso: make n8n-test-workflow WEBHOOK_ID=<id> INPUT=<data>
ifeq ($(WEBHOOK_ID),)
	@echo "❌ Erro: ID do webhook não especificado."
	@echo "👉 Uso: make n8n-test-workflow WEBHOOK_ID=<id_do_webhook> [INPUT=<dados_json>]"
	@echo "✨ Exemplo: make n8n-test-workflow WEBHOOK_ID=my-test-webhook INPUT='{\"testInput\": \"Hello\"}'"
	@exit 1
endif
	@echo "🧪 Acionando webhook do n8n para o workflow ID: $(WEBHOOK_ID)..."
	@CURL_DATA=$(if $(INPUT),-H "Content-Type: application/json" --data '$(INPUT)',) ; \
	curl -s -X POST "https://n8n.$(DOMAIN)/webhook/$(WEBHOOK_ID)" \
	$$CURL_DATA | python -m json.tool || echo "Erro ao testar workflow."
	@echo "✅ Teste de workflow concluído."

portainer-setup: ## Abre o Portainer UI para configuração inicial (se ativo no docker-compose).
	@echo "🌐 Acesse o Portainer em https://localhost:9443 (ou a porta configurada) para configuração inicial."
	@echo "Certifique-se de que o serviço 'portainer' esteja descomentado e rodando em seu docker-compose.yml."