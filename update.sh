#!/bin/bash
set -e

# === STEP 0: Update System Packages ===
echo "[+] Updating system packages (apt)..."
sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y

# === STEP 1: Aktifkan Python Virtual Environment ===
echo "[+] Activating Python virtual environment..."
source ~/myenv/bin/activate

# === STEP 2: Update Python Packages dalam myenv ===
echo "[+] Updating Python packages (pip-based)..."
pip list --outdated | awk 'NR>2 {print $1}' | while read pkg; do
  echo "  → Upgrading $pkg"
  pip install -U "$pkg" || echo "    ⚠️ Failed to upgrade $pkg"
done

# === STEP 3: Update Python Tools dari Git ===
declare -a python_tools=(
  "paramspider"
  "Arjun"
  "dirhunt"
  "crtsh.py"
  "urldedupe"
  "LUcek"
  "ghauri"
  "jsfinder"
  "JSS-Finder"
  "shcheck"
)

echo "[+] Updating Python tools (git-based)..."
for tool in "${python_tools[@]}"; do
  repo_path=~/BUG_BOUNTY_TOOLS/$tool
  echo "  → $tool"
  if [ -d "$repo_path/.git" ]; then
    cd "$repo_path" || continue
    git pull || echo "    ⚠️ Gagal git pull untuk $tool"
    if [ -f setup.py ] || [ -f pyproject.toml ]; then
      python -m pip install -U . --break-system-packages || echo "    ⚠️ Gagal install ulang $tool"
    else
      echo "    ℹ️ Skip pip install (no setup.py)"
    fi
  else
    echo "    ⚠️ Bukan repo Git atau folder tidak ditemukan"
  fi
done

deactivate

# === STEP 4: Update Go Tools ===
echo "[+] Updating Go tools..."
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
go install -v github.com/tomnomnom/assetfinder@latest
go install -v github.com/incogbyte/shosubgo@latest
go install -v github.com/gwen001/github-subdomains@latest
go install -v github.com/projectdiscovery/chaos-client/cmd/chaos@latest
go install -v github.com/ffuf/ffuf/v2@latest
go install -v github.com/OJ/gobuster/v3@latest
go install -v github.com/projectdiscovery/naabu/v2/cmd/naabu@latest
go install -v github.com/lc/gau/v2/cmd/gau@latest
go install -v github.com/tomnomnom/waybackurls@latest
go install -v github.com/projectdiscovery/katana/cmd/katana@latest
go install -v github.com/hakluke/hakrawler@latest
go install -v github.com/tomnomnom/gf@latest
go install -v github.com/tomnomnom/qsreplace@latest
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
go install -v github.com/tomnomnom/httprobe@latest
go install -v github.com/tomnomnom/anew@latest
go install -v github.com/tomnomnom/unfurl@latest
go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest
go install -v github.com/PentestPad/subzy@latest
go install -v github.com/takshal/freq@latest
go install -v github.com/Emoe/kxss@latest
go install -v github.com/rix4uni/xsschecker@latest

echo "[✓] Done Update!"
