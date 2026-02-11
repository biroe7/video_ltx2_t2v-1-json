# Base estável do RunPod
FROM runpod/worker-comfyui:5.7.1-base

# 1. Instalar Nódulos para Vídeo e Áudio (Essencial para o seu JSON)
RUN comfy node install comfyui-ltx2-wrapper || true
RUN comfy node install ComfyUI-VideoHelperSuite || true
RUN comfy node install ComfyUI-Custom-Nodes-AIGODLIKE || true

# 2. Downloads dos modelos com Links Diretos (Corrigindo o Erro 404)
RUN mkdir -p /comfyui/models/checkpoints /comfyui/models/vae /comfyui/models/text_encoders

# Modelo Principal
RUN wget -O /comfyui/models/checkpoints/ltx-2-19b-dev-fp8.safetensors \
    "https://huggingface.co/Lightricks/LTX-2/resolve/main/ltx-2-19b-dev-fp8.safetensors"

# VAE de Vídeo
RUN wget -O /comfyui/models/vae/ltx-2-vae.safetensors \
    "https://huggingface.co/Lightricks/LTX-2/resolve/main/ltx-2-vae.safetensors"

# Text Encoder Gemma (Exigido pelo seu novo JSON)
RUN wget -O /comfyui/models/text_encoders/gemma_3_12B_it_fp4_mixed.safetensors \
    "https://huggingface.co/Comfy-Org/ltx-2/resolve/main/split_files/text_encoders/gemma_3_12B_it_fp4_mixed.safetensors"

ENV COMFYUI_MODEL_PATH=/comfyui/models
