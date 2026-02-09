# Usa a imagem base estável do RunPod
FROM runpod/worker-comfyui:5.7.1-base

# Instalar apenas os Custom Nodes necessários para o LTX-2
RUN comfy node install comfyui-ltx2-wrapper || true

# NÃO baixamos modelos aqui para evitar o erro de build que você teve
# Vamos usar o seu Network Volume para isso
ENV COMFYUI_MODEL_PATH=/workspace/models
