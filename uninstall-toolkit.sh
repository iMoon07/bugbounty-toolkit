#!/usr/bin/env bash

# ─────────────────────────────────────────────────────────────────────────────
# Color definitions
# ─────────────────────────────────────────────────────────────────────────────
GRN='\033[38;5;82m'
CYN='\033[38;5;51m'
YLW='\033[38;5;220m'
DRK='\033[38;5;240m'
DIM='\033[2m'
RED='\033[38;5;196m'
RST='\033[0m'

# ─────────────────────────────────────────────────────────────────────────────
# Banner
# ─────────────────────────────────────────────────────────────────────────────
clear
echo ""
printf "${RED}"
cat << 'EOF'
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
EOF
printf "${RST}"
echo ""
printf "  ${YLW}B U G B O U N T Y   T O O L K I T  —  U N I N S T A L L E R${RST}\n"
echo ""
printf "  ${DIM}WARNING: This will remove ALL 51 tools, the ~/BUG_BOUNTY_TOOLS folder,${RST}\n"
printf "  ${DIM}and ALL GF Patterns from your system.${RST}\n"
# ─────────────────────────────────────────────────────────────────────────────
# Functions & Logging
# ─────────────────────────────────────────────────────────────────────────────
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_FILE="${SCRIPT_DIR}/uninstall.log"

W=50

if [ -n "$SUDO_USER" ]; then
    REAL_HOME=$(eval echo "~$SUDO_USER")
else
    REAL_HOME="$HOME"
fi

_run() {
    local label="$1"; shift
    local t=0 rc
    printf "  ${DIM}[%-${W}s] %-35s${RST}" "" "$label"
    echo "── $label ──" >> "$LOG_FILE"
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
        echo "✓ SUCCESS: $label" >> "$LOG_FILE"
    else
        local dash; dash=$(printf '%0.s─' $(seq 1 "$W"))
        printf "\r  ${DRK}[%-${W}s] ✗ %-33s${RST}\n" "$dash" "$label"
        echo "✗ FAILED: $label" >> "$LOG_FILE"
    fi
}

echo ""

read -p "  [?] Are you sure you want to completely remove the toolkit? (y/N): " confirm
if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
    printf "\n  ${GRN}Uninstallation aborted. Your tools are safe!${RST}\n\n"
    exit 0
fi

# Start fresh log with timestamp
if [ -n "$SUDO_USER" ]; then
    sudo bash -c "echo '' > \"$LOG_FILE\""
    sudo bash -c "echo '══════════════════════════════════════════════' >> \"$LOG_FILE\""
    sudo bash -c "echo '  UNINSTALL LOG — $(date '+%Y-%m-%d %H:%M:%S')' >> \"$LOG_FILE\""
    sudo bash -c "echo '══════════════════════════════════════════════' >> \"$LOG_FILE\""
    sudo chown "$SUDO_USER":"$SUDO_USER" "$LOG_FILE"
else
    echo "" > "$LOG_FILE"
    echo "══════════════════════════════════════════════" >> "$LOG_FILE"
    echo "  UNINSTALL LOG — $(date '+%Y-%m-%d %H:%M:%S')" >> "$LOG_FILE"
    echo "══════════════════════════════════════════════" >> "$LOG_FILE"
fi

echo ""
printf "  ${RED}Uninstalling Bug Bounty Toolkit...${RST}\n"
echo ""

# 1. Remove Git Cloned Tools directory & GF Patterns
printf "  ${DIM}┄┄ CLEANING REPOSITORIES & PATTERNS ┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄${RST}\n"
if [ -d "$REAL_HOME/BUG_BOUNTY_TOOLS" ] || [ -d "$REAL_HOME/.gf" ]; then
    _run "Removing ~/BUG_BOUNTY_TOOLS & ~/.gf" "rm -rf $REAL_HOME/BUG_BOUNTY_TOOLS $REAL_HOME/.gf"
else
    printf "  ${DRK}↷ ~/BUG_BOUNTY_TOOLS & ~/.gf already removed${RST}\n"
fi

# 2. Remove APT tools
printf "\n  ${DIM}┄┄ REMOVING APT TOOLS ┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄${RST}\n"
    _run "Uninstalling sqlmap, commix, medusa" "sudo killall -9 apt apt-get dpkg 2>/dev/null || true; sudo rm -f /var/lib/dpkg/lock /var/lib/dpkg/lock-frontend; sudo dpkg --configure -a 2>/dev/null; sudo apt remove -y sqlmap commix medusa brutespray && sudo apt autoremove -y"

# 3. Remove Binary tools from /usr/local/bin
printf "\n  ${DIM}┄┄ REMOVING BINARIES & WRAPPERS ┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄${RST}\n"
    # Dynamically extract tool list from check-toolkit.sh
    # This ensures the uninstaller automatically scales if more tools are added
    TOOLS=()
    if [ -f "$SCRIPT_DIR/check-toolkit.sh" ]; then
        while IFS= read -r line; do
            tool=$(echo "$line" | awk -F'"' '{print $2}')
            if [ -n "$tool" ]; then
                TOOLS+=("$tool")
            fi
        done < <(grep '^_check "' "$SCRIPT_DIR/check-toolkit.sh")
    fi

    # Fallback if check-toolkit.sh is missing or empty
    if [ ${#TOOLS[@]} -eq 0 ]; then
        TOOLS=(sqlmap commix medusa brutespray subfinder assetfinder shosubgo github-subdomains chaos ffuf gobuster naabu gau waybackurls katana hakrawler gf qsreplace anew unfurl httpx httprobe subzy freq kxss xsschecker dalfox crlfuzz nomore403 dnsx tlsx cdncheck puredns crtsh dirsearch arjun dirhunt bhedak xsstrike shcheck secretfinder paramspider waymore cmseek lucek wafw00f ghauri urldedupe rustscan nuclei testssl.sh)
    fi

    _run "Deleting ${#TOOLS[@]} tools from system bins" "
        for tool in ${TOOLS[*]}; do
            # Track exact binary location using command -v
            USER_TOOL_PATH=\$(sudo -u \"\$SUDO_USER\" bash -c \"command -v \$tool\" 2>/dev/null)
            ROOT_TOOL_PATH=\$(command -v \"\$tool\" 2>/dev/null)
            
            if [ -n \"\$USER_TOOL_PATH\" ]; then
                sudo rm -f \"\$USER_TOOL_PATH\"
            fi
            if [ -n \"\$ROOT_TOOL_PATH\" ]; then
                sudo rm -f \"\$ROOT_TOOL_PATH\"
            fi

            # Fallback: Forcefully clean the 4 main installation directories
            sudo rm -f \"/usr/local/bin/\$tool\" 2>/dev/null
            sudo rm -f \"/usr/bin/\$tool\" 2>/dev/null
            rm -f \"\$REAL_HOME/go/bin/\$tool\" 2>/dev/null
            rm -f \"\$REAL_HOME/.local/bin/\$tool\" 2>/dev/null
        done
    "

# Summary
echo ""
printf "  ${YLW}══════════════════════════════════════════════════════════════════${RST}\n"
printf "  ${GRN}✓ UNINSTALLATION COMPLETE${RST}\n"
printf "  ${DIM}Note: Base dependencies (go, python3, cmake) were kept intact.${RST}\n"
printf "  ${DIM}If you want to reinstall, just run: bash install-toolkit-for-linux-fixed.sh${RST}\n"
printf "  ${YLW}══════════════════════════════════════════════════════════════════${RST}\n"
echo ""
