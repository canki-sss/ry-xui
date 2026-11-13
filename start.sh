#!/bin/bash

# 如果在 Railway 环境变量里设置了 CF_TOKEN，则在后台启动 Cloudflare 隧道
if [ -n "$CF_TOKEN" ]; then
    echo "🌐 Starting Cloudflare Tunnel..."
    cloudflared tunnel --no-autoupdate run --token "$CF_TOKEN" &
fi

echo "🚀 Starting X-UI on port ${PORT}..."
# تنظیم پورت در فایل کانفیگ
mkdir -p /etc/x-ui
cat > /etc/x-ui/config.json << EOF
{
  "webPort": ${PORT},
  "webBasePath": "/",
  "webListen": "0.0.0.0",
  "logLevel": "info"
}
EOF
# اجرای X-UI
cd /usr/local/x-ui
./x-ui
