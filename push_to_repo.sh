#!/data/data/com.termux/files/usr/bin/bash
set -e

REPO_URL="https://github.com/YOUR_USERNAME/Executive-Assistant.git"

echo "🔧 تجهيز المشروع للرفع..."

# تأكد إنك داخل مجلد المشروع
cd ~/Executive-Assistant-

# نسخ الـ APK إلى الجذر إذا موجود
if [ -f app/build/outputs/apk/debug/app-debug.apk ]; then
    cp app/build/outputs/apk/debug/app-debug.apk ./ExecutiveAssistant.apk
    echo "✅ APK جاهز للرفع."
fi

# إضافة كل الملفات
git add .
git commit -m "رفع المشروع كامل مع APK جاهز"
git push origin main

echo "🚀 تم رفع المشروع إلى المستودع بنجاح!"
echo "📥 الآن أي شخص يقدر يدخل المستودع ويحمل ملف ExecutiveAssistant.apk مباشرة."
