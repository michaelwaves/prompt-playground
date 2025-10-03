convert multiline strings to json string:
sed ':a;N;$!ba;s/\n/\\n/g' input_file.txt
echo -e "line1\nline2\nline3" | sed ':a;N;$!ba;s/\n/\\n/g'

https://docs.vllm.ai/en/stable/index.html
https://docs.openwebui.com/

