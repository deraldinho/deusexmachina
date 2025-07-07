# scripts/ollama_entrypoint.sh
# SPDX-License-Identifier: Apache-2.0
#!/bin/sh
set -e

echo "🚀 Iniciando o entrypoint customizado do Ollama..."

# Inicia o servidor Ollama em segundo plano
ollama serve &

# Captura o Process ID (PID) do servidor que foi para o background
pid=$!
echo "Servidor Ollama iniciado em segundo plano com PID: $pid"

# Aguarda o servidor Ollama iniciar e estar pronto para receber conexões
echo "⏳ Aguardando o servidor Ollama iniciar..."
until ollama list > /dev/null 2>&1; do
  sleep 1
done
echo "✅ Servidor Ollama está pronto."

# Lista de modelos a serem verificados e baixados
MODELS="deepseek-r1:1.5b qwen3:1.7b deepseek-coder:1.3b" # deepscaler corrigido para deepseek-coder

for MODEL_TO_CHECK in $MODELS; do
  if ! ollama list | grep -q "$MODEL_TO_CHECK"; then
    echo "Modelo '$MODEL_TO_CHECK' não encontrado. Baixando agora..."
    ollama pull "$MODEL_TO_CHECK"
    echo "✅ Modelo baixado com sucesso."
  else
    echo "✅ Modelo '$MODEL_TO_CHECK' já existe. Pulando o download."
  fi
done

echo "✨ Configuração inicial concluída. O servidor continuará em execução."

# Aguarda o processo do servidor Ollama (que está em background) terminar.
# Se o servidor cair por algum motivo, o script irá terminar e o container irá parar.
wait $pid