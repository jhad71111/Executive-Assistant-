import os
import subprocess
import json
from datetime import datetime

REPO_URL = "https://github.com/jhad71111/Executive-Assistant-.git"
BRANCH = "main"
VERSION_FILE = "version.json"

def run(cmd):
    return subprocess.call(cmd, shell=True)

def get_output(cmd):
    return subprocess.getoutput(cmd)

def load_version():
    if os.path.exists(VERSION_FILE):
        with open(VERSION_FILE, "r") as f:
            return json.load(f)
    return {"version": "0.0.0"}

def save_version(version):
    with open(VERSION_FILE, "w") as f:
        json.dump(version, f)

def log_update(msg):
    with open("update.log", "a") as f:
        f.write(f"[{datetime.now()}] {msg}\n")

def update():
    print("🔄 فحص التحديثات من GitHub...")

    if not os.path.exists(".git"):
        print("📦 تهيئة Git...")
        run("git init")
        run("git branch -M main")
        run(f"git remote add origin {REPO_URL}")

    run("git fetch origin")

    local = get_output("git rev-parse HEAD")
    remote = get_output(f"git rev-parse origin/{BRANCH}")

    if local != remote:
        print("🚀 يوجد تحديث جديد...")
        run(f"git reset --hard origin/{BRANCH}")

        version = load_version()
        old = version.get("version", "0.0.0")

        parts = old.split(".")
        parts[-1] = str(int(parts[-1]) + 1)
        new = ".".join(parts)

        save_version({"version": new})
        log_update(f"{old} → {new}")

        print("✅ تم التحديث إلى:", new)
    else:
        print("✔ المشروع محدث بالفعل")

if __name__ == "__main__":
    update()
