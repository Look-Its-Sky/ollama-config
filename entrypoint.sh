#!/bin/bash
set -e

ollama serve &
pid=$!

echo "Waiting for Ollama server to start..."

while ! curl -s -f http://localhost:11434/ > /dev/null
do
  sleep 1
done

echo "✅ Ollama server is ready."

if ! ollama list | grep -q "^${MODEL}"; then
  echo "🚀 Model '${MODEL}' not found. Creating it for the first time..."

  echo "Pulling base model: ${BASE_MODEL}..."
  ollama pull "${BASE_MODEL}"

  echo "Creating custom model '${MODEL}'..."
  ollama create "${MODEL}" -f /Modelfile
  echo "✅ Model '${MODEL}' created successfully."
else
  echo "✅ Model '${MODEL}' already exists. Skipping creation."
fi

echo "🎉 Ollama is up and running with custom models"
wait $pid