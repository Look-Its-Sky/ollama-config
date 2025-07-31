#!/bin/sh
# Exit on any error AND print each command before executing it
set -ex

echo "--- SCRIPT START ---"
echo "--- Verifying Environment Variables ---"
echo "Custom Model Name (MODEL): ${MODEL}"
echo "Base Model to Pull (BASE_MODEL): ${BASE_MODEL}"
echo "-------------------------------------"

# Start Ollama serve in the background
ollama serve &
pid=$!

echo "Waiting for Ollama server to start..."

# Wait until the server is responsive
while ! curl -s -f http://localhost:11434/ > /dev/null
do
  echo "Ollama server not ready, waiting 1s..."
  sleep 1
done

echo "✅ Ollama server is ready."

# Check if the custom model already exists
echo "Checking for existing model: ${MODEL}"
if ! ollama list | grep -q "^${MODEL}"; then
  echo "🚀 Model '${MODEL}' not found. Proceeding to create it."

  # Pull the base model
  echo "Executing: ollama pull ${BASE_MODEL}"
  ollama pull "${BASE_MODEL}"
  echo "Base model pull complete."

  # Create the custom model from the Modelfile
  echo "Executing: ollama create ${MODEL} -f /Modelfile"
  ollama create "${MODEL}" -f /Modelfile
  echo "✅ Model '${MODEL}' created successfully."
else
  echo "✅ Model '${MODEL}' already exists. Skipping creation."
fi

echo "🎉 Ollama is up and running with your custom model."

# Bring the server process to the foreground to keep the container alive
wait $pid