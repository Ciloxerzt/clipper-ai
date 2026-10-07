#!/bin/bash
# Start AI Clipper Studio (API 8902 + tunnel). Pakai venv permanen (tahan reboot).
cd /home/hatch/workspace/clipper-ai
# App: skip kalau port 8902 sudah listen; GOOGLE_API_KEY dibaca dari .env di subshell (tidak muncul di ps)
ss -tln 2>/dev/null | grep -q ':8902 ' || (set -a; . ./.env 2>/dev/null; set +a; TMPDIR=/home/hatch/pip-tmp nohup ./venv/bin/python -m uvicorn web.api.app:app --host 127.0.0.1 --port 8902 >/tmp/clipper_ai.log 2>&1 &)
pgrep -f "R 80:localhost:8902" >/dev/null || (nohup ssh -T -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o ProxyCommand="/usr/bin/nc -X connect -x hatch-egress-proxy:3128 %h %p" -o ServerAliveInterval=30 -R 80:localhost:8902 nokey@localhost.run >/tmp/clipper_ai_tunnel.log 2>&1 &)
sleep 12
URL=$(grep -aoE 'https://[a-z0-9]+\.lhr\.life' /tmp/clipper_ai_tunnel.log | tail -1)
echo "$URL/studio" > /home/hatch/workspace/clipper-ai/studio_url.txt
echo "AI Studio: $URL/studio"
