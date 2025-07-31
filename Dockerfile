FROM ollama/ollama

COPY Modelfile /Modelfile 
RUN ollama create quant_strategist -f /Modelfile