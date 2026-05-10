#!/data/data/com.termux/files/usr/bin/bash

echo "🚀 بدء تثبيت المشروع..."

pkg update -y && pkg upgrade -y

pkg install python git -y

if [ -f requirements.txt ]; then
    pip install -r requirements.txt
fi

echo "✅ التثبيت اكتمل بنجاح"
echo "▶️ لتشغيل المشروع:"
echo "python main.py"
