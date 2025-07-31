FROM ollama/ollama

RUN ollama pull hf.co/unsloth/DeepSeek-R1-Distill-Llama-70B-GGUF:Q4_K_M
COPY Modelfile /Modelfile 
RUN ollama create quant_strategist -f /Modelfile