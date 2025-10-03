convert multiline strings to json string:
sed ':a;N;$!ba;s/\n/\\n/g' input_file.txt
echo -e "line1\nline2\nline3" | sed ':a;N;$!ba;s/\n/\\n/g'

https://docs.vllm.ai/en/stable/index.html
https://docs.openwebui.com/

## Quickstart
```bash 
./launch.sh
```

# Manual

## Export environment variables
```bash
DATA_DIR=~/.open-webui OPENAI_API_KEY='your-key' OPENAI_API_BASE_URLS=https://api.openai.com/v1;http://localhost:8000/v1 
```

## Install Vllm

```bash
uv pip install vllm --torch-backend=auto
```
Serve a model
```bash
vllm serve zai-org/GLM-4.5-Air-FP8 --tensor-parallel-size 2
```

## Install OpenWebUI

```bash
uvx --python 3.11 open-webui@latest serve
```