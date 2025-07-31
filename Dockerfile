FROM ollama/ollama

COPY Modelfile /Modelfile 

RUN ollama create quant_researcher