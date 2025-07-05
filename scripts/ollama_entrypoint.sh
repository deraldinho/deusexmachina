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

# Aguarda um momento para garantir que o servidor esteja pronto para receber conexões
sleep 3

# Puxa o modelo inicial, se ainda não existir
# Isso é mais eficiente do que puxar toda vez.
MODEL_TO_CHECK="deepseek-r1:1.5b"
if ! ollama list | grep -q "$MODEL_TO_CHECK"; then
  echo "Modelo '$MODEL_TO_CHECK' não encontrado. Baixando agora..."
  ollama pull "$MODEL_TO_CHECK"
  echo "✅ Modelo baixado com sucesso."
else
  echo "✅ Modelo '$MODEL_TO_CHECK' já existe. Pulando o download."
fi

# Puxa o modelo inicial, se ainda não existir
# Isso é mais eficiente do que puxar toda vez.
MODEL_TO_CHECK="qwen3:1.7b"
if ! ollama list | grep -q "$MODEL_TO_CHECK"; then
  echo "Modelo '$MODEL_TO_CHECK' não encontrado. Baixando agora..."
  ollama pull "$MODEL_TO_CHECK"
  echo "✅ Modelo baixado com sucesso."
else
  echo "✅ Modelo '$MODEL_TO_CHECK' já existe. Pulando o download."
fi

# Puxa o modelo inicial, se ainda não existir
# Isso é mais eficiente do que puxar toda vez.
MODEL_TO_CHECK="deepscaler:1.5b"
if ! ollama list | grep -q "$MODEL_TO_CHECK"; then
  echo "Modelo '$MODEL_TO_CHECK' não encontrado. Baixando agora..."
  ollama pull "$MODEL_TO_CHECK"
  echo "✅ Modelo baixado com sucesso."
else
  echo "✅ Modelo '$MODEL_TO_CHECK' já existe. Pulando o download."
fi

echo "✨ Configuração inicial concluída. O servidor continuará em execução."

# Aguarda o processo do servidor Ollama (que está em background) terminar.
# Se o servidor cair por algum motivo, o script irá terminar e o container irá parar.
wait $pid