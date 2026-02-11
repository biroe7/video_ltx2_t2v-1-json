# Usa a imagem base limpa do RunPod (a mesma que você confia)
FROM runpod/worker-comfyui:5.7.1-base

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# --- 1. INSTALAÇÃO DOS CUSTOM NODES (Obrigatório para o JSON funcionar) ---
# O Workflow usa nós como "LTXAVTextEncoderLoader" e "LTXVScheduler"
# Eles vêm do repositório oficial da Lightricks.
RUN git clone https://github.com/Lightricks/ComfyUI-LTXVideo.git /comfyui/custom_nodes/ComfyUI-LTXVideo \
    && pip install --no-cache-dir -r /comfyui/custom_nodes/ComfyUI-LTXVideo/requirements.txt

# --- 2. CRIAÇÃO DAS PASTAS ---
# Garante que as pastas onde o JSON busca os arquivos existam
RUN mkdir -p /comfyui/models/checkpoints
RUN mkdir -p /comfyui/models/text_encoders
RUN mkdir -p /comfyui/models/loras
RUN mkdir -p /comfyui/models/upscale_models

# --- 3. DOWNLOAD DOS MODELOS (Exatamente os nomes do seu JSON) ---

# A. Checkpoint Principal (LTX-2 19B FP8) - Nó 92:1
# ATENÇÃO: Arquivo grande (~20GB+)
RUN wget -O /comfyui/models/checkpoints/ltx-2-19b-dev-fp8.safetensors \
    "https://huggingface.co/Lightricks/LTX-2/resolve/main/ltx-2-19b-dev-fp8.safetensors"

# B. Text Encoder (Gemma 3 12B) - Nó 92:60
# O LTX-2 usa o Gemma como cérebro de texto. Sem isso, ele não entende o prompt.
RUN wget -O /comfyui/models/text_encoders/gemma_3_12B_it_fp4_mixed.safetensors \
    "https://huggingface.co/Lightricks/LTX-2/resolve/main/gemma_3_12B_it_fp4_mixed.safetensors"

# C. LoRA Distilled (Para qualidade/rapidez) - Nó 92:68
RUN wget -O /comfyui/models/loras/ltx-2-19b-distilled-lora-384.safetensors \
    "https://huggingface.co/Lightricks/LTX-2/resolve/main/ltx-2-19b-distilled-lora-384.safetensors"

# D. Spatial Upscaler (Para melhorar a resolução) - Nó 92:76
# Colocamos na pasta upscale_models, mas fazemos um link simbólico para checkpoints
# caso o nó seja exigente com a localização.
RUN wget -O /comfyui/models/upscale_models/ltx-2-spatial-upscaler-x2-1.0.safetensors \
    "https://huggingface.co/Lightricks/LTX-2/resolve/main/ltx-2-spatial-upscaler-x2-1.0.safetensors" \
    && ln -s /comfyui/models/upscale_models/ltx-2-spatial-upscaler-x2-1.0.safetensors /comfyui/models/checkpoints/ltx-2-spatial-upscaler-x2-1.0.safetensors

# --- 4. CONFIGURAÇÃO FINAL ---
# Não precisa de CMD, a imagem base do RunPod já gerencia o start.
