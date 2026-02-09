# clean base image containing only comfyui, comfy-cli and comfyui-manager
FROM runpod/worker-comfyui:5.7.1-base

# install custom nodes into comfyui (first node with --mode remote to fetch updated cache)
# Could not resolve unknown_registry node: MarkdownNote (no aux_id provided) - skipped
# Could not resolve unknown_registry node: MarkdownNote (no aux_id provided) - skipped
# Could not resolve unknown_registry node: MarkdownNote (no aux_id provided) - skipped

# download models into comfyui
RUN comfy model download --url https://huggingface.co/Lightricks/LTX-2/resolve/main/ltx-2-19b-dev-fp8.safetensors --relative-path models/checkpoints --filename ltx-2-19b-dev-fp8.safetensors

# copy all input data (like images or videos) into comfyui (uncomment and adjust if needed)
# COPY input/ /comfyui/input/
