# Base oficial do RunPod para ComfyUI
FROM runpod/worker-comfyui:5.5.1-base

# 1. Instalar Custom Nodes (LTX-2 exige o wrapper)
RUN comfy node install comfyui-ltx2-wrapper || true

# 2. Download do Modelo Principal (LTX-2 19B)
# Usando o comando interno do comfy que é mais estável no Build
RUN comfy model download \
    --url https://huggingface.co/Lightricks/LTX-2/resolve/main/ltx-2-19b-dev-fp8.safetensors \
    --relative-path models/checkpoints \
    --filename ltx-2-19b-dev-fp8.safetensors

# 3. Download do VAE (Corrigindo o erro que travava o build)
RUN comfy model download \
    --url https://huggingface.co/Lightricks/LTX-2/resolve/main/ltx-2-vae.safetensors \
    --relative-path models/vae \
    --filename ltx-2-vae.safetensors

# 4. Ajuste de Permissões e Caminho
ENV COMFYUI_MODEL_PATH=/comfyui/models
