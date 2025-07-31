/bin/ollama serve &
pid=$!

MODEL="hf.co/unsloth/DeepSeek-R1-Distill-Llama-70B-GGUF:Q4_K_M"

# Wait for ollama to start
sleep 10

# Model pulls here
ollama pull $MODEL

wait $pid