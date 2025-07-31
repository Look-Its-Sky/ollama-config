/bin/ollama serve &
pid=$!

# Wait for ollama to start
sleep 10

# Model pulls here
ollama pull $MODEL

wait $pid
