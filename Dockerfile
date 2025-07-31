FROM ollama/ollama

ARG BASE_MODEL
ENV BASE_MODEL=${BASE_MODEL}

RUN ollama pull ${BASE_MODEL}
COPY Modelfile /Modelfile 
RUN ollama create quant_strategist -f /Modelfile