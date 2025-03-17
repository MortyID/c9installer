#!/bin/bash

ipvpsmu=$(curl -s ifconfig.me)  
echo "$ipvpsmu"

echo -e "\e[1;33m🚀 Mulai Instalasi C9 SDK...\e[0m"
echo -e "\n🛡️ Mengkonfigurasi Firewall..."
sudo ufw allow 8080 || error_exit "Gagal membuka port 8080"  
sudo ufw allow 22/tcp || error_exit "Gagal membuka port 22"
echo "🔄 Memperbarui sistem..." 
sudo apt update || error_exit "Gagal update sistem"
echo "📦 Menginstall dependensi..."
sudo apt-get install -y \
    git \
    python2 \
    nodejs \
    npm \
    build-essential \
    || error_exit "Gagal menginstall dependensi"

WORKSPACE_DIR="/home/c9user/a"
sudo mkdir -p "$WORKSPACE_DIR" || error_exit "Gagal membuat direktori workspace"
sudo chown -R $(whoami):$(whoami) "$WORKSPACE_DIR"
echo "📥 Mengunduh C9 SDK..."
git clone https://github.com/c9/core.git ~/c9sdk || error_exit "Gagal clone repository C9 SDK"
cd ~/c9sdk || error_exit "Gagal masuk direktori c9sdk"
echo "⚙️ Menginstall SDK..."
./scripts/install-sdk.sh || error_exit "Instalasi SDK gagal" 
echo "🌐 Menjalankan C9 Server..."
echo "Akses Cloud9 IDE di: http://$ipvpsmu:8181/ide.html?packed=1"
echo -e "\e[1;32m✅ Instalasi C9 SDK Selesai!\e[0m"
node server.js \
    -l "$ipvpsmu:8080" \
    -a "$username:$password" \
    --listen 0.0.0.0 \
    -w "$WORKSPACE_DIR" \
    || error_exit "Gagal menjalankan server C9" 