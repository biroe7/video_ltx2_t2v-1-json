# Base oficial do RunPod para ComfyUI
FROM runpod/worker-comfyui:5.7.1-base

# 1. Instalar Custom Nodes (LTX-2 exige o wrapper)
RUN comfy node install comfyui-ltx2-wrapper || true

# 2. Download do Modelo Principal (LTX-2 19B)
RUN comfy model download \
    --url https://huggingface.co/Lightricks/LTX-2/resolve/main/ltx-2-19b-dev-fp8.safetensors \
    --relative-path models/checkpoints \
    --filename ltx-2-19b-dev-fp8.safetensors

# 3. Download do VAE (Corrigindo o erro do seu print)
# Adicionei o comando direto do terminal para ser mais resistente a falhas
RUN mkdir -p /comfyui/models/vae && \
    wget -c https://huggingface.co/Lightricks/LTX-2/resolve/main/ltx-2-vae.safetensors -O /comfyui/models/vae/ltx-2-vae.safetensors

# 4. Definir onde o ComfyUI deve procurar tudo
ENV COMFYUI_MODEL_PATH=/workspace/models
