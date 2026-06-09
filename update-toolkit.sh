#!/bin/bash

# ─────────────────────────────────────────────────────────────────────────────
# Color definitions — ANSI escape codes
# ─────────────────────────────────────────────────────────────────────────────
BLK='\033[0;30m'   WHT='\033[1;37m'   RED='\033[1;31m'   GRN='\033[1;32m'
YLW='\033[1;33m'   BLU='\033[1;34m'   MAG='\033[1;35m'   CYN='\033[1;36m'
REDBG='\033[41m'   BLKBG='\033[40m'   DRK='\033[0;31m'   DIM='\033[2;33m'
RST='\033[0m'

# ─────────────────────────────────────────────────────────────────────────────
# Banner
# ─────────────────────────────────────────────────────────────────────────────
clear
printf '\033[40m'

echo -e "${REDBG}${YLW}$(printf ' %.0s' {1..72})${RST}"
echo -e "${REDBG}${YLW}               B U G B O U N T Y   T O O L K I T   — UPDATE             ${RST}"
echo -e "${REDBG}${YLW}$(printf ' %.0s' {1..72})${RST}"
echo ""

echo -e "${YLW}"
cat << 'ART'
     く__,.ヘヽ.        /  ,ー､ 〉
          ＼ ', !-─‐-i  /  /´
          ／`ｰ'     L/／`ヽ､
        /   ／,  /|  ,  ,       ',
       ｲ   / /-‐/  ｉ  L_ ﾊ ヽ!   i
        ﾚ ﾍ 7ｲ`ﾄ  ﾚ'ｧ-ﾄ､!ハ|    |
         !,/7 '0'    ´0iソ|         |
         |.从"    _    ,,,, / |./    |
         ﾚ'| i＞.､,,__  _,.イ /   .i   |
          ﾚ'| | / k_７_/ﾚ'ヽ,  ﾊ.  |
            | |/i 〈|/  i  ,.ﾍ |  i  |
           .|/ /  ｉ：   ﾍ!    ＼  |
          kヽ>､ﾊ   _,.ﾍ､   /､!
           !'〈//`Ｔ´', ＼ `'7'ｰr'
           ﾚ'ヽL__|___i,___,ンﾚ|ノ
              ﾄ-,/  |___./
              'ｰ'    !_,.:
ART
echo -e "${RST}"

printf '\033[19A'
TCOL=44
_tp() { printf "\033[${TCOL}G"; echo -e "$1"; }

_tp "${YLW}  ══════════════════════════════════${RST}"
_tp "${GRN}  UPDATE strategy per tool type:${RST}"
_tp "${WHT}  go install @latest   → Go tools${RST}"
_tp "${WHT}  pip3 install -U      → Python pip${RST}"
_tp "${WHT}  git pull + reinstall → Git tools${RST}"
_tp "${WHT}  apt upgrade          → APT tools${RST}"
_tp "${WHT}  re-download binary   → RustScan / Nuclei${RST}"
_tp ""
_tp "${CYN}  All output → update.log${RST}"
_tp "${DIM}  Skip: tools not installed${RST}"
_tp "${YLW}  ══════════════════════════════════${RST}"

printf '\033[9B'
echo ""
echo -e "${REDBG}${DIM}  [↻]  Update mode — existing tools will be overwritten ${RST}"
echo -e "${REDBG}${YLW}$(printf ' %.0s' {1..72})${RST}"
echo -e "${DIM}  Developed by iMoon · linkedin.com/in/imoon07   |   Inspired by Rootbakar · progress28.com${RST}"
echo ""
sleep 1

# ─────────────────────────────────────────────────────────────────────────────
# Helpers
# ─────────────────────────────────────────────────────────────────────────────
function is_installed { command -v "$1" >/dev/null 2>&1; }

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_FILE="${SCRIPT_DIR}/update.log"

# Start fresh log with timestamp
echo "" > "$LOG_FILE"
echo "══════════════════════════════════════════════" >> "$LOG_FILE"
echo "  UPDATE LOG — $(date '+%Y-%m-%d %H:%M:%S')" >> "$LOG_FILE"
echo "══════════════════════════════════════════════" >> "$LOG_FILE"
echo "" >> "$LOG_FILE"

PASS=0; FAIL=0
W=50

_hdr() {
    echo -e "\n${DIM}  ┄┄ $1 ┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄${RST}"
}

_run() {
    local label="$1"; shift
    local t=0 rc
    printf "  ${DIM}[%-${W}s] %-35s${RST}" "" "$label"
    { eval "$@"; } >> "$LOG_FILE" 2>&1 &
    local pid=$!
    while kill -0 "$pid" 2>/dev/null; do
        local f=$(( t % W ))
        local bar; bar=$(printf '%0.s█' $(seq 1 "$((f + 1))") 2>/dev/null)
        printf "\r  ${YLW}[%-${W}s]${RST} ${WHT}%-35s${RST}" "$bar" "$label"
        t=$(( t + 1 )); sleep 0.06
    done
    wait "$pid"; rc=$?
    local full; full=$(printf '%0.s█' $(seq 1 "$W"))
    if [ "$rc" -eq 0 ]; then
        printf "\r  ${GRN}[%-${W}s] ✓ %-33s${RST}\n" "$full" "$label"
        PASS=$(( PASS + 1 ))
    else
        local dash; dash=$(printf '%0.s─' $(seq 1 "$W"))
        printf "\r  ${DRK}[%-${W}s] ✗ %-33s${RST}\n" "$dash" "$label"
        FAIL=$(( FAIL + 1 ))
        echo "=== FAILED: $label ===" >> "$LOG_FILE"
    fi
}

_skip_not_installed() {
    local dots; dots=$(printf '%0.s·' $(seq 1 "$W"))
    printf "  ${DIM}[%-${W}s] ⊘ %-33s${RST}\n" "$dots" "$1 (not installed — skipped)"
}

# ─────────────────────────────────────────────────────────────────────────────
# Linux only
# ─────────────────────────────────────────────────────────────────────────────
if [[ "$OSTYPE" != "linux-gnu"* ]]; then
    echo "This script is for Linux only."; exit 1
fi

# ─────────────────────────────────────────────────────────────────────────────
# Go env
# ─────────────────────────────────────────────────────────────────────────────
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
if [ ! -d "/usr/local/go" ]; then
    for dir in /usr/lib/go-1.26 /usr/lib/go-1.23 /usr/lib/go; do
        [ -d "$dir/bin" ] && { export GOROOT=$dir; export PATH=$PATH:$dir/bin:$GOPATH/bin; break; }
    done
fi

mkdir -p ~/BUG_BOUNTY_TOOLS
cd ~/BUG_BOUNTY_TOOLS

# ─────────────────────────────────────────────────────────────────────────────
_hdr "SYSTEM"
_run "apt update"   "sudo apt update -y"

# ─────────────────────────────────────────────────────────────────────────────
_hdr "GO TOOLS  (go install @latest)"
is_installed subfinder         && _run "subfinder"         "go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest"         || _skip_not_installed "subfinder"
is_installed assetfinder       && _run "assetfinder"       "go install -v github.com/tomnomnom/assetfinder@latest"                               || _skip_not_installed "assetfinder"
is_installed shosubgo          && _run "shosubgo"          "go install -v github.com/incogbyte/shosubgo@latest"                                   || _skip_not_installed "shosubgo"
is_installed github-subdomains && _run "github-subdomains" "go install -v github.com/gwen001/github-subdomains@latest"                            || _skip_not_installed "github-subdomains"
is_installed chaos             && _run "chaos"             "go install -v github.com/projectdiscovery/chaos-client/cmd/chaos@latest"              || _skip_not_installed "chaos"
is_installed ffuf              && _run "ffuf"              "go install -v github.com/ffuf/ffuf/v2@latest"                                          || _skip_not_installed "ffuf"
is_installed gobuster          && _run "gobuster"          "go install -v github.com/OJ/gobuster/v3@latest"                                        || _skip_not_installed "gobuster"
is_installed naabu             && _run "naabu"             "go install -v github.com/projectdiscovery/naabu/v2/cmd/naabu@latest"                   || _skip_not_installed "naabu"
is_installed gau               && _run "gau"               "go install -v github.com/lc/gau/v2/cmd/gau@latest"                                    || _skip_not_installed "gau"
is_installed waybackurls       && _run "waybackurls"       "go install -v github.com/tomnomnom/waybackurls@latest"                                || _skip_not_installed "waybackurls"
is_installed katana            && _run "katana"            "go install -v github.com/projectdiscovery/katana/cmd/katana@latest"                    || _skip_not_installed "katana"
is_installed hakrawler         && _run "hakrawler"         "go install -v github.com/hakluke/hakrawler@latest"                                    || _skip_not_installed "hakrawler"
is_installed gf                && _run "gf"                "go install -v github.com/tomnomnom/gf@latest"                                         || _skip_not_installed "gf"

# gf patterns — wipe old JSONs, re-pull all repos into ~/.gf/
if is_installed gf; then
    _run "gf patterns (refresh)" '
        GF_DIR="$HOME/.gf"
        mkdir -p "$GF_DIR"
        rm -f "$GF_DIR"/*.json
        repos=(
            "https://github.com/1ndianl33t/Gf-Patterns"
            "https://github.com/robre/gf-patterns"
            "https://github.com/mrofisr/gf-patterns"
            "https://github.com/NitinYadav00/gf-patterns"
            "https://github.com/Matir/gf-patterns"
            "https://github.com/bp0lr/myGF_patterns"
            "https://github.com/arthur4ires/gfPatterns"
            "https://github.com/r00tkie/grep-pattern"
            "https://github.com/dwisiswant0/gf-secrets"
            "https://github.com/Jude-Paul/GF-Patterns-For-Dangerous-PHP-Functions"
            "https://github.com/seqrity/Allin1gf"
            "https://github.com/scumdestroy/YouthCrew-GF-Patterns"
            "https://github.com/cypher3107/GF-Patterns"
            "https://github.com/R0X4R/Garud"
            "https://github.com/coffinxp/GFpattren"
            "https://github.com/rix4uni/gf-patterns"
        )
        for repo in "${repos[@]}"; do
            name=$(basename "$repo")
            git clone --depth=1 "$repo" "$GF_DIR/_tmp_$name" &>/dev/null && \
            find "$GF_DIR/_tmp_$name" -type f -name "*.json" -exec mv {} "$GF_DIR/" \; && \
            rm -rf "$GF_DIR/_tmp_$name"
        done
    '
fi
is_installed qsreplace         && _run "qsreplace"         "go install -v github.com/tomnomnom/qsreplace@latest"                                  || _skip_not_installed "qsreplace"
is_installed anew              && _run "anew"              "go install -v github.com/tomnomnom/anew@latest"                                        || _skip_not_installed "anew"
is_installed unfurl            && _run "unfurl"            "go install -v github.com/tomnomnom/unfurl@latest"                                      || _skip_not_installed "unfurl"
is_installed httpx             && _run "httpx"             "go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest"                     || _skip_not_installed "httpx"
is_installed httprobe          && _run "httprobe"          "go install -v github.com/tomnomnom/httprobe@latest"                                    || _skip_not_installed "httprobe"
is_installed subzy             && _run "subzy"             "go install -v github.com/PentestPad/subzy@latest"                                     || _skip_not_installed "subzy"
is_installed freq              && _run "freq"              "go install -v github.com/takshal/freq@latest"                                          || _skip_not_installed "freq"
is_installed kxss              && _run "kxss"              "go install -v github.com/Emoe/kxss@latest"                                            || _skip_not_installed "kxss"
is_installed xsschecker        && _run "xsschecker"        "go install -v github.com/rix4uni/xsschecker@latest"                                   || _skip_not_installed "xsschecker"
is_installed dalfox            && _run "dalfox"            "go install -v github.com/hahwul/dalfox/v2@latest"                                     || _skip_not_installed "dalfox"
is_installed crlfuzz           && _run "crlfuzz"           "go install -v github.com/dwisiswant0/crlfuzz/cmd/crlfuzz@latest"                      || _skip_not_installed "crlfuzz"
is_installed nomore403         && _run "nomore403"         "go install -v github.com/devploit/nomore403@latest"                                   || _skip_not_installed "nomore403"
is_installed dnsx              && _run "dnsx"              "go install -v github.com/projectdiscovery/dnsx/cmd/dnsx@latest"                       || _skip_not_installed "dnsx"
is_installed tlsx              && _run "tlsx"              "go install -v github.com/projectdiscovery/tlsx/cmd/tlsx@latest"                       || _skip_not_installed "tlsx"
is_installed cdncheck          && _run "cdncheck"          "go install -v github.com/projectdiscovery/cdncheck/cmd/cdncheck@latest"               || _skip_not_installed "cdncheck"
is_installed puredns           && _run "puredns"           "go install -v github.com/d3mondev/puredns/v2@latest"                                  || _skip_not_installed "puredns"
_run "sync go→/usr/local/bin" "sudo cp ~/go/bin/* /usr/local/bin/ 2>/dev/null || true"

# ─────────────────────────────────────────────────────────────────────────────
_hdr "PYTHON TOOLS  (git pull + reinstall)"

# pip-based tools — pip3 install -U handles it
is_installed dirsearch  && _run "dirsearch"  "pip3 install -U dirsearch --break-system-packages"  || _skip_not_installed "dirsearch"
is_installed dirhunt    && _run "dirhunt"    "python3 -m pip install -U dirhunt --break-system-packages --ignore-installed click" || _skip_not_installed "dirhunt"
is_installed bhedak     && _run "bhedak"     "python3 -m pip install -U bhedak --break-system-packages"  || _skip_not_installed "bhedak"
is_installed wafw00f    && _run "wafw00f"    "pip3 install -U wafw00f --break-system-packages"            || _skip_not_installed "wafw00f"

# git-based tools — pull if dir exists, re-clone if not
_git_update() {
    local label="$1" dir="$2" install_cmd="$3" clone_url="$4"
    if ! is_installed "$label"; then
        _skip_not_installed "$label"
    elif [ -d "$HOME/BUG_BOUNTY_TOOLS/$dir/.git" ]; then
        _run "$label" "cd ~/BUG_BOUNTY_TOOLS/$dir && git pull && $install_cmd"
    else
        # directory missing — re-clone from scratch
        _run "$label (re-clone)" "rm -rf ~/BUG_BOUNTY_TOOLS/$dir && git clone '$clone_url' ~/BUG_BOUNTY_TOOLS/$dir && cd ~/BUG_BOUNTY_TOOLS/$dir && $install_cmd"
    fi
    cd ~/BUG_BOUNTY_TOOLS
}

_git_update "arjun"        "Arjun"        "pip3 install -r requirements.txt --break-system-packages 2>/dev/null || true"    "https://github.com/s0md3v/Arjun.git"
_git_update "xsstrike"     "XSStrike"     "pip3 install -r requirements.txt --break-system-packages"               "https://github.com/s0md3v/XSStrike.git"

# shcheck — git pull + re-create bash wrapper with PYTHONPATH
if ! is_installed shcheck; then
    _skip_not_installed "shcheck"
elif [ -d "$HOME/BUG_BOUNTY_TOOLS/shcheck/.git" ]; then
    _run "shcheck" "cd ~/BUG_BOUNTY_TOOLS/shcheck && git pull && pip3 install -r requirements.txt --break-system-packages 2>/dev/null || true && printf '#!/usr/bin/env bash\nexport PYTHONPATH=\"\$HOME/BUG_BOUNTY_TOOLS/shcheck:\$PYTHONPATH\"\nexec python3 \"\$HOME/BUG_BOUNTY_TOOLS/shcheck/shcheck.py\" \"\$@\"\n' | sudo tee /usr/local/bin/shcheck > /dev/null && sudo chmod +x /usr/local/bin/shcheck"
else
    _run "shcheck (re-clone)" "rm -rf ~/BUG_BOUNTY_TOOLS/shcheck && git clone 'https://github.com/santoru/shcheck.git' ~/BUG_BOUNTY_TOOLS/shcheck && cd ~/BUG_BOUNTY_TOOLS/shcheck && pip3 install -r requirements.txt --break-system-packages 2>/dev/null || true && printf '#!/usr/bin/env bash\nexport PYTHONPATH=\"\$HOME/BUG_BOUNTY_TOOLS/shcheck:\$PYTHONPATH\"\nexec python3 \"\$HOME/BUG_BOUNTY_TOOLS/shcheck/shcheck.py\" \"\$@\"\n' | sudo tee /usr/local/bin/shcheck > /dev/null && sudo chmod +x /usr/local/bin/shcheck"
fi
cd ~/BUG_BOUNTY_TOOLS
_git_update "secretfinder" "SecretFinder" "pip3 install -r requirements.txt --break-system-packages 2>/dev/null || true" "https://github.com/m4ll0k/SecretFinder.git"
_git_update "paramspider"  "paramspider"  "pip3 install -r requirements.txt --break-system-packages 2>/dev/null || true" "https://github.com/devanshbatham/paramspider"
_git_update "waymore"      "waymore"      "pip3 install -r requirements.txt --break-system-packages"               "https://github.com/xnl-h4ck3r/waymore.git"

# cmseek — git pull + re-create bash wrapper with PYTHONPATH
if ! is_installed cmseek; then
    _skip_not_installed "cmseek"
elif [ -d "$HOME/BUG_BOUNTY_TOOLS/CMSeeK/.git" ]; then
    _run "cmseek" "cd ~/BUG_BOUNTY_TOOLS/CMSeeK && git pull && pip3 install -r requirements.txt --break-system-packages 2>/dev/null || true && printf '#!/usr/bin/env bash\nexport PYTHONPATH=\"\$HOME/BUG_BOUNTY_TOOLS/CMSeeK:\$PYTHONPATH\"\nexec python3 \"\$HOME/BUG_BOUNTY_TOOLS/CMSeeK/cmseek.py\" \"\$@\"\n' | sudo tee /usr/local/bin/cmseek > /dev/null && sudo chmod +x /usr/local/bin/cmseek"
else
    _run "cmseek (re-clone)" "rm -rf ~/BUG_BOUNTY_TOOLS/CMSeeK && git clone 'https://github.com/Tuhinshubhra/CMSeeK.git' ~/BUG_BOUNTY_TOOLS/CMSeeK && cd ~/BUG_BOUNTY_TOOLS/CMSeeK && pip3 install -r requirements.txt --break-system-packages 2>/dev/null || true && printf '#!/usr/bin/env bash\nexport PYTHONPATH=\"\$HOME/BUG_BOUNTY_TOOLS/CMSeeK:\$PYTHONPATH\"\nexec python3 \"\$HOME/BUG_BOUNTY_TOOLS/CMSeeK/cmseek.py\" \"\$@\"\n' | sudo tee /usr/local/bin/cmseek > /dev/null && sudo chmod +x /usr/local/bin/cmseek"
fi
cd ~/BUG_BOUNTY_TOOLS
_git_update "lucek"        "LUcek"        "pip3 install -r requirements.txt --break-system-packages 2>/dev/null || true" "https://github.com/rootbakar/LUcek.git"
_git_update "ghauri"       "ghauri"       "pip3 install -r requirements.txt --break-system-packages"               "https://github.com/r0oth3x49/ghauri.git"

# crtsh — git pull or re-clone if dir missing
if is_installed crtsh; then
    if [ -d "$HOME/BUG_BOUNTY_TOOLS/crtsh.py/.git" ]; then
        _run "crtsh" "cd ~/BUG_BOUNTY_TOOLS/crtsh.py && git pull && chmod +x crtsh && sudo cp crtsh /usr/local/bin/"
    else
        _run "crtsh (re-clone)" "rm -rf ~/BUG_BOUNTY_TOOLS/crtsh.py && git clone https://github.com/YashGoti/crtsh.py.git ~/BUG_BOUNTY_TOOLS/crtsh.py && cd ~/BUG_BOUNTY_TOOLS/crtsh.py && mv crtsh.py crtsh && chmod +x crtsh && sudo cp crtsh /usr/local/bin/"
    fi
    cd ~/BUG_BOUNTY_TOOLS
else
    _skip_not_installed "crtsh"
fi

# gau config (always refresh)
_run "gau.toml config" "wget -q https://raw.githubusercontent.com/lc/gau/refs/heads/master/.gau.toml && mv .gau.toml ~/"

# ─────────────────────────────────────────────────────────────────────────────
_hdr "APT / BINARY TOOLS"
is_installed sqlmap     && _run "sqlmap"     "sudo apt install --only-upgrade sqlmap -y"     || _skip_not_installed "sqlmap"
is_installed commix     && _run "commix"     "sudo apt install --only-upgrade commix -y"     || _skip_not_installed "commix"
is_installed medusa     && _run "medusa"     "sudo apt install --only-upgrade medusa -y"     || _skip_not_installed "medusa"
is_installed brutespray && _run "brutespray" "sudo apt install --only-upgrade brutespray -y" || _skip_not_installed "brutespray"

# urldedupe — rebuild from source
if is_installed urldedupe; then
    _run "urldedupe" "cd ~/BUG_BOUNTY_TOOLS/urldedupe && git pull && cmake CMakeLists.txt && make && sudo cp urldedupe /usr/local/bin"
    cd ~/BUG_BOUNTY_TOOLS
else
    _skip_not_installed "urldedupe"
fi

# rustscan — re-download LATEST binary dynamically (repo: bee-san/RustScan)
if is_installed rustscan; then
    _run "rustscan" "
        RS_VER=\$(curl -s https://api.github.com/repos/bee-san/RustScan/releases/latest | grep '\"tag_name\"' | cut -d'\"' -f4) &&
        cd /tmp &&
        wget -q \"https://github.com/bee-san/RustScan/releases/download/\${RS_VER}/rustscan.deb.zip\" &&
        unzip -q -o rustscan.deb.zip &&
        sudo dpkg -i rustscan*.deb &&
        rm -f rustscan.deb.zip rustscan*.deb
    "
    cd ~/BUG_BOUNTY_TOOLS
else
    _skip_not_installed "rustscan"
fi

# nuclei — re-download LATEST release dynamically
if is_installed nuclei; then
    _run "nuclei" "
        NUC_VER=\$(curl -s https://api.github.com/repos/projectdiscovery/nuclei/releases/latest | grep '\"tag_name\"' | cut -d'\"' -f4) &&
        NUC_VER_CLEAN=\${NUC_VER#v} &&
        cd ~/BUG_BOUNTY_TOOLS &&
        mkdir -p Nuclei && cd Nuclei &&
        wget -q \"https://github.com/projectdiscovery/nuclei/releases/download/\${NUC_VER}/nuclei_\${NUC_VER_CLEAN}_linux_amd64.zip\" &&
        unzip -q -o \"nuclei_\${NUC_VER_CLEAN}_linux_amd64.zip\" &&
        sudo mv nuclei /usr/local/bin/ &&
        rm -f \"nuclei_\${NUC_VER_CLEAN}_linux_amd64.zip\"
    "
    cd ~/BUG_BOUNTY_TOOLS
else
    _skip_not_installed "nuclei"
fi

# testssl.sh — git pull
if is_installed testssl.sh; then
    _run "testssl.sh" "cd ~/BUG_BOUNTY_TOOLS/testssl.sh && git pull && sudo cp testssl.sh /usr/local/bin/testssl.sh && sudo chmod +x /usr/local/bin/testssl.sh"
    cd ~/BUG_BOUNTY_TOOLS
else
    _skip_not_installed "testssl.sh"
fi

# ─────────────────────────────────────────────────────────────────────────────
# Summary
# ─────────────────────────────────────────────────────────────────────────────
echo ""
echo -e "${YLW}  ══════════════════════════════════════════════════════════════════${RST}"
echo -e "${GRN}  ✓ UPDATED  : ${PASS} tools${RST}"
[ "$FAIL" -gt 0 ] && echo -e "${DRK}  ✗ FAILED   : ${FAIL} tools  —  check log: ${LOG_FILE}${RST}" || true
echo -e "${DIM}  LOG        : ${LOG_FILE}${RST}"
echo -e "${YLW}  ══════════════════════════════════════════════════════════════════${RST}"
echo ""

# Write summary to log
{
    echo ""
    echo "══════════════════════════════════════════════"
    echo "  ✓ UPDATED  : ${PASS} tools"
    [ "$FAIL" -gt 0 ] && echo "  ✗ FAILED   : ${FAIL} tools"
    echo "══════════════════════════════════════════════"
} >> "$LOG_FILE"
