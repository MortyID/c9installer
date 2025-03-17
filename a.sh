#!/bin/bash

# Hentikan skrip jika terjadi error
set -e

# Periksa apakah NVM sudah terpasang
if command -v nvm &> /dev/null
then
    echo "NVM sudah terinstal. Versi: $(nvm --version)"
    exit 0
fi

echo "Menginstal NVM..."

# Unduh dan jalankan skrip instalasi NVM
curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash

# Tambahkan NVM ke dalam environment
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

source ~/.bashrc

# Cek apakah NVM berhasil diinstal
if command -v nvm &> /dev/null
then
    echo "NVM berhasil diinstal. Versi: $(nvm --version)"
else
    echo "Gagal menginstal NVM."
    exit 1
fi

# Install Node.js versi terbaru (opsional)
echo "Menginstal Node.js versi terbaru..."
nvm install 20.11.0

nvm use 20.11.0
nvm alias default 20.11.0

# Verifikasi instalasi Node.js
echo "Node.js versi: $(node -v)"
echo "npm versi: $(npm -v)"


apt install zip -y

echo "Instalasi NVM dan Node.js selesai! 🎉"
