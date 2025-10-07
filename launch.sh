#!/bin/bash
set -e

# Prompt for API key if not set
if [ -z "$OPENAI_API_KEY" ]; then
    echo "OPENAI_API_KEY not found in environment variables."
    read -p "Enter your OpenAI API key: " OPENAI_API_KEY
    export OPENAI_API_KEY
fi

# Set environment variables
export DATA_DIR="/mnt/LVMNVME/.open-webui"
# Use colon or comma separator instead of semicolon
export OPENAI_API_BASE_URLS="https://api.openai.com/v1,http://localhost:8000/v1"

# Create new tmux session
tmux new-session -d -s open-webui -n main

# Split into two horizontal panes
tmux split-window -h -t open-webui:0

# Left pane: OpenWebUI
tmux send-keys -t open-webui:0.0 "export OPENAI_API_KEY=\"$OPENAI_API_KEY\" DATA_DIR=\"$DATA_DIR\" OPENAI_API_BASE_URLS=\"$OPENAI_API_BASE_URLS\"" Enter
tmux send-keys -t open-webui:0.0 "uvx --python 3.11 open-webui@latest serve" Enter

# Right pane: vLLM model server
tmux send-keys -t open-webui:0.1 "export CUDA_VISIBLE_DEVICES=4,5,6,7" Enter
tmux send-keys -t open-webui:0.1 "source .venv/bin/activate" Enter
tmux send-keys -t open-webui:0.1 "uv pip install -U vllm --torch-backend=auto" Enter
tmux send-keys -t open-webui:0.1 "vllm serve zai-org/GLM-4.5-Air-FP8 --tensor-parallel-size 2" Enter

# Attach to the tmux session
tmux attach -t open-webui