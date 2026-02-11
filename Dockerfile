# Base oficial que funcionou no seu Imagen-Z
FROM runpod/worker-comfyui:5.7.1-base

# 1. Instalar os nós de vídeo (Para não dar erro de VideoCombine)
RUN comfy node install ComfyUI-VideoHelperSuite || true
RUN comfy node install comfyui-ltx2-wrapper || true

# 2. Criar pastas
RUN mkdir -p /comfyui/models/checkpoints /comfyui/models/vae

# 3. Download do Modelo (Link estável do Comfy-Org)
RUN wget -O /comfyui/models/checkpoints/ltx-2-19b-dev-fp8.safetensors \
    "https://huggingface.co/Comfy-Org/ltx-2/resolve/main/ltx-2-19b-dev-fp8.safetensors"

# 4. Download do VAE (Link que NÃO dá erro 404)
RUN wget -O /comfyui/models/vae/ltx-2-vae.safetensors \
    "https://huggingface.co/Comfy-Org/ltx-2/resolve/main/ltx-2-vae.safetensors"

ENV COMFYUI_MODEL_PATH=/comfyui/models
