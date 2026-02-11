# Base oficial
FROM runpod/worker-comfyui:5.7.1-base

# 1. Instalar os Custom Nodes necessários para vídeo
RUN comfy node install comfyui-ltx2-wrapper || true
RUN comfy node install ComfyUI-VideoHelperSuite || true

# 2. Downloads dos modelos (Mantenha como você já tinha no Imagen-Z)
RUN comfy model download --url https://huggingface.co/Lightricks/LTX-2/resolve/main/ltx-2-19b-dev-fp8.safetensors --relative-path models/checkpoints --filename ltx-2-19b-dev-fp8.safetensors
RUN comfy model download --url https://huggingface.co/Lightricks/LTX-2/resolve/main/ltx-2-vae.safetensors --relative-path models/vae --filename ltx-2-vae.safetensors

ENV COMFYUI_MODEL_PATH=/comfyui/models
