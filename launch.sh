#!/bin/bash

# Prompt for API key if not set
if [ -z "$OPENAI_API_KEY" ]; then
    echo "OPENAI_API_KEY not found in environment variables."
    read -p "Enter your OpenAI API key: " OPENAI_API_KEY
    export OPENAI_API_KEY
fi

# Set environment variables
export DATA_DIR=~/.open-webui
export OPENAI_API_BASE_URLS="https://api.openai.com/v1;http://localhost:8000/v1"

# Create tmux session and panes
tmux new-session -d -s open-webui
tmux split-window -v

# Top pane: Install and run OpenWebUI
tmux send-keys -t open-webui:0.0 "export OPENAI_API_KEY='$OPENAI_API_KEY' DATA_DIR='$DATA_DIR' OPENAI_API_BASE_URLS='$OPENAI_API_BASE_URLS'" Enter
tmux send-keys -t open-webui:0.0 "uvx --python 3.11 open-webui@latest serve" Enter

# Bottom pane: Install vLLM and run model server
tmux send-keys -t open-webui:0.1 "export OPENAI_API_KEY='$OPENAI_API_KEY' DATA_DIR='$DATA_DIR' OPENAI_API_BASE_URLS='$OPENAI_API_BASE_URLS'" Enter
tmux send-keys -t open-webui:0.1 "uv pip install vllm --torch-backend=auto" Enter
tmux send-keys -t open-webui:0.1 "vllm serve zai-org/GLM-4.5-Air-FP8 --tensor-parallel-size 2" Enter

# Attach to tmux session
tmux attach -t open-webui