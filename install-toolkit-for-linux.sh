#!/bin/bash

# ─────────────────────────────────────────────────────────────────────────────
# Color definitions — ANSI escape codes
# ─────────────────────────────────────────────────────────────────────────────
BLK='\033[0;30m'   WHT='\033[1;37m'   RED='\033[1;31m'   GRN='\033[1;32m'
YLW='\033[1;33m'   BLU='\033[1;34m'   MAG='\033[1;35m'   CYN='\033[1;36m'
REDBG='\033[41m'   BLKBG='\033[40m'   DRK='\033[0;31m'   DIM='\033[2;33m'
RST='\033[0m'

# ─────────────────────────────────────────────────────────────────────────────
# BBS Artcard Banner — inspired by mist0426 ANSI art pack
# ─────────────────────────────────────────────────────────────────────────────
clear
printf '\033[40m'

# RED TOP BAR
echo -e "${REDBG}${YLW}$(printf ' %.0s' {1..72})${RST}"
echo -e "${REDBG}${YLW}                  B U G B O U N T Y   T O O L K I T   v1.0              ${RST}"
echo -e "${REDBG}${YLW}$(printf ' %.0s' {1..72})${RST}"
echo ""

# ── Anime art — heredoc avoids wide-char / ANSI mixing issues ─
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

# ── Tool panel: printed BESIDE the art using cursor repositioning ──
# Art block = 17 art lines + echo "${YLW}" + echo "${RST}" = 19 rows total
printf '\033[19A'   # jump back to top of art block
TCOL=44             # column where tool panel starts (clear of art)

_tp() { printf "\033[${TCOL}G"; echo -e "$1"; }

_tp "${YLW}  ══════════════════════════════════${RST}"
_tp "${GRN}  ▸ GO — 29 tools${RST}"
_tp "${WHT}  subfinder  assetfinder  shosubgo${RST}"
_tp "${WHT}  github-subdomains  chaos  ffuf${RST}"
_tp "${WHT}  gobuster  naabu  gau  waybackurls${RST}"
_tp "${WHT}  katana  hakrawler  gf  qsreplace${RST}"
_tp "${WHT}  httpx  httprobe  anew  unfurl${RST}"
_tp "${WHT}  subzy  freq  kxss  xsschecker${RST}"
_tp "${WHT}  dalfox  crlfuzz  nomore403  dnsx${RST}"
_tp "${WHT}  tlsx  cdncheck  puredns${RST}"
_tp "${MAG}  ▸ PYTHON — 14 tools${RST}"
_tp "${WHT}  crtsh  dirsearch  arjun  dirhunt${RST}"
_tp "${WHT}  bhedak  xsstrike  shcheck${RST}"
_tp "${WHT}  secretfinder  paramspider  waymore${RST}"
_tp "${WHT}  cmseek  lucek  wafw00f  ghauri${RST}"
_tp "${CYN}  ▸ BINARY/APT — 8 tools${RST}"
_tp "${WHT}  rustscan  nuclei  urldedupe  brutespray${RST}"

printf '\033[2B'    # advance past the 2 remaining rows of the art block
echo -e "${WHT}  sqlmap  commix  medusa  testssl.sh${RST}"
echo -e "${YLW}  ══════════════════════════════════════════════════════════════════${RST}"
echo ""

# RED BOTTOM BAR
echo -e "${REDBG}${YLW}$(printf ' %.0s' {1..72})${RST}"
echo -e "${REDBG}${DRK}  [!]  Est. time: 15-30 min   |   Do NOT close the terminal           ${RST}"
echo -e "${REDBG}${YLW}$(printf ' %.0s' {1..72})${RST}"
echo -e "${DIM}  Developed by iMoon · linkedin.com/in/imoon07   |   Inspired by Rootbakar · progress28.com${RST}"
echo ""
sleep 2

function is_installed { command -v "$1" >/dev/null 2>&1; }

# ─────────────────────────────────────────────────────────────────────────────
# Progress bar infrastructure
# ─────────────────────────────────────────────────────────────────────────────
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_FILE="${SCRIPT_DIR}/install.log"

# Start fresh log with timestamp
echo "" > "$LOG_FILE"
echo "══════════════════════════════════════════════" >> "$LOG_FILE"
echo "  INSTALL LOG — $(date '+%Y-%m-%d %H:%M:%S')" >> "$LOG_FILE"
echo "══════════════════════════════════════════════" >> "$LOG_FILE"
echo "" >> "$LOG_FILE"

PASS=0; FAIL=0
W=50   # bar width

_hdr() {
    echo -e "\n${DIM}  ┄┄ $1 ┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄${RST}"
}

_run() {
    local label="$1"; shift
    local t=0 rc
    printf "  ${DIM}[%-${W}s] %-35s${RST}" "" "$label"
    {
        eval "$@"
    } >> "$LOG_FILE" 2>&1 &
    local pid=$!
    while kill -0 "$pid" 2>/dev/null; do
        local f=$(( t % W ))
        local bar; bar=$(printf '%0.s█' $(seq 1 "$((f + 1))") 2>/dev/null)
        printf "\r  ${YLW}[%-${W}s]${RST} ${WHT}%-35s${RST}" "$bar" "$label"
        t=$(( t + 1 )); sleep 0.06
    done
    wait "$pid"; rc=$?
    { local full; full=$(printf '%0.s█' $(seq 1 "$W")); } 2>/dev/null
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

_skip() {
    local dots; dots=$(printf '%0.s·' $(seq 1 "$W"))
    printf "  ${DIM}[%-${W}s] ↷ %-33s${RST}\n" "$dots" "$1 (already installed)"
}

# Linux only check
if [[ "$OSTYPE" != "linux-gnu"* ]]; then
    echo "This script is for Linux only."
    exit 1
fi

# ─────────────────────────────────────────────────────────────────────────────
_hdr "SYSTEM SETUP"
cd ~/
_run "apt update"   "sudo apt update -y"

# ─────────────────────────────────────────────────────────────────────────────
_hdr "DEPENDENCIES"
is_installed cmake  && _skip "cmake"      || _run "cmake"      "sudo apt install cmake -y"
dpkg -l libpcap-dev &>/dev/null           && _skip "libpcap-dev" || _run "libpcap-dev" "sudo apt install libpcap-dev -y"
is_installed python3 && _skip "python3"   || _run "python3"    "sudo apt install python3 python3-pip -y"

mkdir -p ~/BUG_BOUNTY_TOOLS
cd ~/BUG_BOUNTY_TOOLS

# ─────────────────────────────────────────────────────────────────────────────
_hdr "GOLANG"
if ! is_installed go; then
    _run "golang" "wget -q https://go.dev/dl/go1.22.4.linux-amd64.tar.gz -O /tmp/go.tar.gz && sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf /tmp/go.tar.gz && rm /tmp/go.tar.gz"
else
    _skip "golang"
fi

export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
if [ ! -d "/usr/local/go" ]; then
    for dir in /usr/lib/go-1.26 /usr/lib/go-1.23 /usr/lib/go; do
        [ -d "$dir/bin" ] && { export GOROOT=$dir; export PATH=$PATH:$dir/bin:$GOPATH/bin; break; }
    done
fi
grep -q "GOROOT" ~/.bashrc || {
    echo "export GOROOT=$GOROOT" >> ~/.bashrc
    echo "export GOPATH=$HOME/go" >> ~/.bashrc
    echo "export PATH=\$PATH:\$GOROOT/bin:\$GOPATH/bin" >> ~/.bashrc
}

# ─────────────────────────────────────────────────────────────────────────────
_hdr "GO TOOLS"
is_installed subfinder         && _skip "subfinder"         || _run "subfinder"         "go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest"
is_installed assetfinder       && _skip "assetfinder"       || _run "assetfinder"       "go install -v github.com/tomnomnom/assetfinder@latest"
is_installed shosubgo          && _skip "shosubgo"          || _run "shosubgo"          "go install -v github.com/incogbyte/shosubgo@latest"
is_installed github-subdomains && _skip "github-subdomains" || _run "github-subdomains" "go install -v github.com/gwen001/github-subdomains@latest"
is_installed chaos             && _skip "chaos"             || _run "chaos"             "go install -v github.com/projectdiscovery/chaos-client/cmd/chaos@latest"
is_installed ffuf              && _skip "ffuf"              || _run "ffuf"              "go install -v github.com/ffuf/ffuf/v2@latest"
is_installed gobuster          && _skip "gobuster"          || _run "gobuster"          "go install -v github.com/OJ/gobuster/v3@latest"
is_installed naabu             && _skip "naabu"             || _run "naabu"             "go install -v github.com/projectdiscovery/naabu/v2/cmd/naabu@latest"
is_installed gau               && _skip "gau"               || _run "gau"               "go install -v github.com/lc/gau/v2/cmd/gau@latest"
is_installed waybackurls       && _skip "waybackurls"       || _run "waybackurls"       "go install -v github.com/tomnomnom/waybackurls@latest"
is_installed katana            && _skip "katana"            || _run "katana"            "go install -v github.com/projectdiscovery/katana/cmd/katana@latest"
is_installed hakrawler         && _skip "hakrawler"         || _run "hakrawler"         "go install -v github.com/hakluke/hakrawler@latest"
is_installed gf                && _skip "gf"                || _run "gf"                "go install -v github.com/tomnomnom/gf@latest"
is_installed qsreplace         && _skip "qsreplace"         || _run "qsreplace"         "go install -v github.com/tomnomnom/qsreplace@latest"
is_installed anew              && _skip "anew"              || _run "anew"              "go install -v github.com/tomnomnom/anew@latest"
is_installed unfurl            && _skip "unfurl"            || _run "unfurl"            "go install -v github.com/tomnomnom/unfurl@latest"
is_installed httpx             && _skip "httpx"             || _run "httpx"             "go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest"
is_installed httprobe          && _skip "httprobe"          || _run "httprobe"          "go install -v github.com/tomnomnom/httprobe@latest"
is_installed subzy             && _skip "subzy"             || _run "subzy"             "go install -v github.com/PentestPad/subzy@latest"
is_installed freq              && _skip "freq"              || _run "freq"              "go install -v github.com/takshal/freq@latest"
is_installed kxss              && _skip "kxss"              || _run "kxss"              "go install -v github.com/Emoe/kxss@latest"
is_installed xsschecker        && _skip "xsschecker"        || _run "xsschecker"        "go install -v github.com/rix4uni/xsschecker@latest"
is_installed dalfox            && _skip "dalfox"            || _run "dalfox"            "go install -v github.com/hahwul/dalfox/v2@latest"
is_installed crlfuzz           && _skip "crlfuzz"           || _run "crlfuzz"           "go install -v github.com/dwisiswant0/crlfuzz/cmd/crlfuzz@latest"
is_installed nomore403         && _skip "nomore403"         || _run "nomore403"         "go install -v github.com/devploit/nomore403@latest"
is_installed dnsx              && _skip "dnsx"              || _run "dnsx"              "go install -v github.com/projectdiscovery/dnsx/cmd/dnsx@latest"
is_installed tlsx              && _skip "tlsx"              || _run "tlsx"              "go install -v github.com/projectdiscovery/tlsx/cmd/tlsx@latest"
is_installed cdncheck          && _skip "cdncheck"          || _run "cdncheck"          "go install -v github.com/projectdiscovery/cdncheck/cmd/cdncheck@latest"
is_installed puredns           && _skip "puredns"           || _run "puredns"           "go install -v github.com/d3mondev/puredns/v2@latest"
_run "sync go→/usr/local/bin" "sudo cp ~/go/bin/* /usr/local/bin/ 2>/dev/null || true"

cd ~/BUG_BOUNTY_TOOLS

# ─────────────────────────────────────────────────────────────────────────────
_hdr "PYTHON TOOLS"

is_installed crtsh && _skip "crtsh" || \
    _run "crtsh" "rm -rf crtsh.py && git clone https://github.com/YashGoti/crtsh.py.git && cd crtsh.py && mv crtsh.py crtsh && chmod +x crtsh && sudo cp crtsh /usr/local/bin/"
cd ~/BUG_BOUNTY_TOOLS

is_installed dirsearch && _skip "dirsearch" || _run "dirsearch" "pip3 install -U dirsearch --break-system-packages"
cd ~/BUG_BOUNTY_TOOLS

is_installed arjun && _skip "arjun" || \
    _run "arjun" "rm -rf Arjun && git clone https://github.com/s0md3v/Arjun.git && cd Arjun && python3 -m pip install . --break-system-packages"
cd ~/BUG_BOUNTY_TOOLS

is_installed dirhunt  && _skip "dirhunt"  || _run "dirhunt"  "python3 -m pip install dirhunt --break-system-packages --ignore-installed click"
is_installed bhedak   && _skip "bhedak"   || _run "bhedak"   "python3 -m pip install bhedak --break-system-packages"
is_installed wafw00f  && _skip "wafw00f"  || _run "wafw00f"  "pip3 install wafw00f --break-system-packages"

is_installed xsstrike && _skip "xsstrike" || \
    _run "xsstrike" "rm -rf XSStrike && git clone https://github.com/s0md3v/XSStrike.git && cd XSStrike && pip3 install -r requirements.txt --break-system-packages && echo '#!/usr/bin/env python3' | cat - xsstrike.py > /tmp/xsstrike_tmp && sudo cp /tmp/xsstrike_tmp /usr/local/bin/xsstrike && sudo chmod +x /usr/local/bin/xsstrike && rm /tmp/xsstrike_tmp"
cd ~/BUG_BOUNTY_TOOLS

is_installed shcheck && _skip "shcheck" || \
    _run "shcheck" "rm -rf shcheck && git clone https://github.com/santoru/shcheck.git && cd shcheck && pip3 install -r requirements.txt --break-system-packages 2>/dev/null || true && printf '#!/usr/bin/env bash\nexport PYTHONPATH=\"$HOME/BUG_BOUNTY_TOOLS/shcheck:\$PYTHONPATH\"\nexec python3 \"$HOME/BUG_BOUNTY_TOOLS/shcheck/shcheck.py\" \"\$@\"\n' | sudo tee /usr/local/bin/shcheck > /dev/null && sudo chmod +x /usr/local/bin/shcheck"
cd ~/BUG_BOUNTY_TOOLS

is_installed secretfinder && _skip "secretfinder" || \
    _run "secretfinder" "rm -rf SecretFinder && git clone https://github.com/m4ll0k/SecretFinder.git && cd SecretFinder && pip3 install -r requirements.txt --break-system-packages 2>/dev/null || true && echo '#!/usr/bin/env python3' | cat - SecretFinder.py > /tmp/sf_tmp && sudo cp /tmp/sf_tmp /usr/local/bin/secretfinder && sudo chmod +x /usr/local/bin/secretfinder && rm /tmp/sf_tmp"
cd ~/BUG_BOUNTY_TOOLS

_run "gau.toml config" "wget -q https://raw.githubusercontent.com/lc/gau/refs/heads/master/.gau.toml && mv .gau.toml ~/"
cd ~/BUG_BOUNTY_TOOLS

is_installed paramspider && _skip "paramspider" || \
    _run "paramspider" "rm -rf paramspider && git clone https://github.com/devanshbatham/paramspider && cd paramspider && python3 -m pip install . --break-system-packages"
cd ~/BUG_BOUNTY_TOOLS

is_installed waymore && _skip "waymore" || \
    _run "waymore" "rm -rf waymore && git clone https://github.com/xnl-h4ck3r/waymore.git && cd waymore && pip3 install -r requirements.txt --break-system-packages && echo '#!/usr/bin/env python3' | cat - waymore.py > /tmp/waymore_tmp && sudo cp /tmp/waymore_tmp /usr/local/bin/waymore && sudo chmod +x /usr/local/bin/waymore && rm /tmp/waymore_tmp"
cd ~/BUG_BOUNTY_TOOLS

is_installed cmseek && _skip "cmseek" || \
    _run "cmseek" "rm -rf CMSeeK && git clone https://github.com/Tuhinshubhra/CMSeeK.git && cd CMSeeK && pip3 install -r requirements.txt --break-system-packages 2>/dev/null || true && printf '#!/usr/bin/env bash\nexport PYTHONPATH=\"$HOME/BUG_BOUNTY_TOOLS/CMSeeK:\$PYTHONPATH\"\nexec python3 \"$HOME/BUG_BOUNTY_TOOLS/CMSeeK/cmseek.py\" \"\$@\"\n' | sudo tee /usr/local/bin/cmseek > /dev/null && sudo chmod +x /usr/local/bin/cmseek"
cd ~/BUG_BOUNTY_TOOLS

is_installed lucek && _skip "lucek" || \
    _run "lucek" "rm -rf LUcek && git clone https://github.com/rootbakar/LUcek.git && cd LUcek && pip3 install -r requirements.txt --break-system-packages 2>/dev/null || true && echo '#!/usr/bin/env python3' | cat - lucek.py > /tmp/lucek_tmp && sudo cp /tmp/lucek_tmp /usr/local/bin/lucek && sudo chmod +x /usr/local/bin/lucek && rm /tmp/lucek_tmp"
cd ~/BUG_BOUNTY_TOOLS

# ─────────────────────────────────────────────────────────────────────────────
_hdr "BINARY / APT TOOLS"

is_installed sqlmap    && _skip "sqlmap"    || _run "sqlmap"    "sudo apt install sqlmap -y"
is_installed commix    && _skip "commix"    || _run "commix"    "sudo apt install commix -y"
is_installed medusa    && _skip "medusa"    || _run "medusa"    "sudo apt install medusa -y"
is_installed brutespray && _skip "brutespray" || _run "brutespray" "sudo apt install brutespray -y"

is_installed ghauri && _skip "ghauri" || \
    _run "ghauri" "rm -rf ghauri && git clone https://github.com/r0oth3x49/ghauri.git && cd ghauri && pip3 install -r requirements.txt --break-system-packages && echo '#!/usr/bin/env python3' | cat - ghauri.py > /tmp/ghauri_tmp && sudo cp /tmp/ghauri_tmp /usr/local/bin/ghauri && sudo chmod +x /usr/local/bin/ghauri && rm /tmp/ghauri_tmp"
cd ~/BUG_BOUNTY_TOOLS

is_installed urldedupe && _skip "urldedupe" || \
    _run "urldedupe" "rm -rf urldedupe && git clone https://github.com/ameenmaali/urldedupe.git && cd urldedupe && cmake CMakeLists.txt && make && sudo cp urldedupe /usr/local/bin"
cd ~/BUG_BOUNTY_TOOLS

is_installed rustscan && _skip "rustscan" || \
    _run "rustscan" "
        RS_VER=\$(curl -s https://api.github.com/repos/bee-san/RustScan/releases/latest | grep '\"tag_name\"' | cut -d'\"' -f4) &&
        cd /tmp &&
        wget -q \"https://github.com/bee-san/RustScan/releases/download/\${RS_VER}/rustscan.deb.zip\" &&
        unzip -q -o rustscan.deb.zip &&
        sudo dpkg -i rustscan*.deb &&
        rm -f rustscan.deb.zip rustscan*.deb
    "
cd ~/BUG_BOUNTY_TOOLS

is_installed nuclei && _skip "nuclei" || \
    _run "nuclei" "
        NUC_VER=\$(curl -s https://api.github.com/repos/projectdiscovery/nuclei/releases/latest | grep '\"tag_name\"' | cut -d'\"' -f4) &&
        NUC_VER_CLEAN=\${NUC_VER#v} &&
        mkdir -p Nuclei && cd Nuclei &&
        wget -q \"https://github.com/projectdiscovery/nuclei/releases/download/\${NUC_VER}/nuclei_\${NUC_VER_CLEAN}_linux_amd64.zip\" &&
        unzip -q -o \"nuclei_\${NUC_VER_CLEAN}_linux_amd64.zip\" &&
        sudo mv nuclei /usr/local/bin/ &&
        rm -f \"nuclei_\${NUC_VER_CLEAN}_linux_amd64.zip\"
    "
cd ~/BUG_BOUNTY_TOOLS

is_installed testssl.sh && _skip "testssl.sh" || \
    _run "testssl.sh" "rm -rf testssl.sh && git clone --depth 1 https://github.com/drwetter/testssl.sh.git && sudo cp testssl.sh/testssl.sh /usr/local/bin/testssl.sh && sudo chmod +x /usr/local/bin/testssl.sh"
cd ~/BUG_BOUNTY_TOOLS

# ─────────────────────────────────────────────────────────────────────────────
# ── Summary ──────────────────────────────────────────────────────────────────
echo ""
echo -e "${YLW}  ══════════════════════════════════════════════════════════════════${RST}"
echo -e "${GRN}  ✓ INSTALLED : ${PASS} tools${RST}"
[ "$FAIL" -gt 0 ] && echo -e "${DRK}  ✗ FAILED    : ${FAIL} tools  —  check log: ${LOG_FILE}${RST}" || true
echo -e "${DIM}  LOG        : ${LOG_FILE}${RST}"
echo -e "${YLW}  ══════════════════════════════════════════════════════════════════${RST}"
echo ""

# Write summary to log
{
    echo ""
    echo "══════════════════════════════════════════════"
    echo "  ✓ INSTALLED : ${PASS} tools"
    [ "$FAIL" -gt 0 ] && echo "  ✗ FAILED    : ${FAIL} tools"
    echo "══════════════════════════════════════════════"
} >> "$LOG_FILE"
