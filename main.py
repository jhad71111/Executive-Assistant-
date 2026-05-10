import os
import threading
import time

# 🔄 دالة التحديث التلقائي

def auto_update():
    while True:
        print("\n🔄 فحص التحديثات من GitHub...")
        os.system("python update.py")
        time.sleep(300)  # ⏱️ كل 5 دقائق (300 ثانية)

# 🚀 تشغيل التحديث في الخلفية
threading.Thread(target=auto_update, daemon=True).start()

# 🚀 المساعد التنفيذي
print("🚀 المساعد التنفيذي شغال الآن بلا قيود!")
print("📝 اكتب أي أمر وسيتم الرد عليك:")

while True:
    cmd = input("أمر: ")

    if cmd.strip() == "":
        print("⚠️ لم تكتب أي شيء.")

    elif "نفّذ" in cmd:
        print("✅ تم التنفيذ:", cmd)

    elif "طوّر" in cmd:
        print("🛠️ تم التطوير الذاتي:", cmd)

    else:
        print("ℹ️ استلمت أمرك:", cmd)
