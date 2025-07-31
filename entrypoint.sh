# #!/bin/bash
# set -e

# ollama serve &
# pid=$!

# echo "Waiting for Ollama server to start..."

# while ! curl -s -f http://localhost:11434/ > /dev/null
# do
#   sleep 1
# done

# echo "✅ Ollama server is ready."

# if ! ollama list | grep -q "^${MODEL}"; then
#   echo "🚀 Model '${MODEL}' not found. Creating it for the first time..."

#   echo "Pulling base model: ${BASE_MODEL}..."
#   ollama pull "${BASE_MODEL}"

#   echo "Creating custom model '${MODEL}'..."
#   ollama create "${MODEL}" -f /Modelfile
#   echo "✅ Model '${MODEL}' created successfully."
# else
#   echo "✅ Model '${MODEL}' already exists. Skipping creation."
# fi

# echo "🎉 Ollama is up and running with custom models"
# wait $pid

#!/bin/sh
set -e

# 1. Start Ollama serve in the background
ollama serve &
pid=$!

echo "Waiting for Ollama server to start..."

# 2. Wait until the server is responsive
while ! curl -s -f http://localhost:11434/ > /dev/null
do
  sleep 1
done

echo "✅ Ollama server is ready."

# 3. Check if the custom model already exists
if ! ollama list | grep -q "^${MODEL}"; then
  echo "🚀 Model '${MODEL}' not found. Creating it..."

  # 4. Pull the base model
  echo "Pulling base model: ${BASE_MODEL}..."
  ollama pull "${BASE_MODEL}"

  # 5. Create the custom model from the Modelfile
  echo "Creating custom model '${MODEL}'..."
  ollama create "${MODEL}" -f /Modelfile
  echo "✅ Model '${MODEL}' created successfully."
else
  echo "✅ Model '${MODEL}' already exists. Skipping creation."
fi

echo "🎉 Ollama is up and running with your custom model."

# 6. Bring the server process to the foreground
wait $pid