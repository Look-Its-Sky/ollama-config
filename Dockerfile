FROM ollama/ollama

COPY ./Modelfiles /Modelfiles 

ARG BASE_MODEL_STRATEGIST
ARG BASE_MODEL_DEV

RUN ollama pull ${BASE_MODEL_STRATEGIST} || true 
RUN ollama pull ${BASE_MODEL_DEV} || true

RUN ollama create quant_dev --model ${BASE_MODEL_DEV} -f /Modelfiles/Modelfile.quant_dev_template
RUN ollama create quant_strategist --model ${BASE_MODEL_STRATEGIST} -f /Modelfiles/Modelfile.quant_strategist_template