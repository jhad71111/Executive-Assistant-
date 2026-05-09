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
