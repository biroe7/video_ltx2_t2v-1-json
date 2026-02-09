# Usa a imagem base estável do RunPod para ComfyUI
FROM runpod/worker-comfyui:5.7.1-base

# 1. Instalar os Custom Nodes necessários para o LTX-2 (essencial)
# O LTX-2 exige nós específicos que não vêm no ComfyUI padrão
RUN comfy node install comfyui-ltx2-wrapper || true

# 2. Baixar o modelo LTX-2 (19b dev fp8)
# O LTX-2 é muito pesado, então baixar direto no Dockerfile aumenta o tamanho da imagem.
# Recomendamos manter no seu Network Volume se quiser economizar, mas aqui está o comando:
RUN comfy model download --url https://huggingface.co/Lightricks/LTX-2/resolve/main/ltx-2-19b-dev-fp8.safetensors --relative-path models/checkpoints --filename ltx-2-19b-dev-fp8.safetensors

# 3. Baixar o VAE específico (O LTX-2 não funciona com VAE comum)
RUN comfy model download --url https://huggingface.co/Lightricks/LTX-2/resolve/main/ltx-2-vae.safetensors --relative-path models/vae --filename ltx-2-vae.safetensors

# 4. Configurações de Cache (para acelerar o boot do Serverless)
ENV COMFYUI_MODEL_PATH=/workspace/ComfyUI/models
