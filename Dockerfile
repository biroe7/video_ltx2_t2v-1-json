# Base oficial do RunPod
FROM runpod/worker-comfyui:5.7.1-base

# 1. Instalar Custom Nodes necessários
RUN comfy node install comfyui-ltx2-wrapper || true

# 2. Download do Modelo Principal (LTX-2 19B)
# Usamos o wget com parâmetros de retry para ser mais estável
RUN mkdir -p /comfyui/models/checkpoints && \
    wget --continue --tries=10 --waitretry=5 \
    https://huggingface.co/Lightricks/LTX-2/resolve/main/ltx-2-19b-dev-fp8.safetensors \
    -O /comfyui/models/checkpoints/ltx-2-19b-dev-fp8.safetensors

# 3. Download do VAE (O que deu erro antes)
RUN mkdir -p /comfyui/models/vae && \
    wget --continue --tries=10 --waitretry=5 \
    https://huggingface.co/Lightricks/LTX-2/resolve/main/ltx-2-vae.safetensors \
    -O /comfyui/models/vae/ltx-2-vae.safetensors

# 4. Configuração de ambiente
ENV COMFYUI_MODEL_PATH=/comfyui/models
