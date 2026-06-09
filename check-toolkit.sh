#!/usr/bin/env bash
# ══════════════════════════════════════════════════════════════════
#   B U G B O U N T Y   T O O L K I T  —  H E A L T H   C H E C K
#   Developed by iMoon · linkedin.com/in/imoon07
#   Inspired by Rootbakar · progress28.com
# ══════════════════════════════════════════════════════════════════

GRN='\033[38;5;82m'
CYN='\033[38;5;51m'
YLW='\033[38;5;220m'
DRK='\033[38;5;240m'
DIM='\033[2m'
RED='\033[38;5;196m'
RST='\033[0m'

PASS=0
FAIL=0
BROKEN=0
FAIL_LIST=()
BROKEN_LIST=()

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_FILE="${SCRIPT_DIR}/check.log"

# Start fresh log with timestamp
echo "" > "$LOG_FILE"
echo "══════════════════════════════════════════════" >> "$LOG_FILE"
echo "  HEALTH CHECK — $(date '+%Y-%m-%d %H:%M:%S')" >> "$LOG_FILE"
echo "══════════════════════════════════════════════" >> "$LOG_FILE"

# ── Banner ────────────────────────────────────────────────────────
clear
echo ""
printf "${CYN}"
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
printf "  ${YLW}B U G B O U N T Y   T O O L K I T  —  H E A L T H   C H E C K${RST}\n"
echo ""
printf "  ${DIM}Developed by iMoon · linkedin.com/in/imoon07   |   Inspired by Rootbakar · progress28.com${RST}\n"
echo ""

# ── Helper functions ──────────────────────────────────────────────
_hdr() {
    echo ""
    printf "  ${DIM}┄┄ ${1} ┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄${RST}\n"
    echo "" >> "$LOG_FILE"
    echo "── ${1} ──" >> "$LOG_FILE"
}

_check() {
    local name="$1"
    local cmd="$2"  # optional: command to detect broken install
    local col_w=46

    # 1. Binary in PATH?
    if ! command -v "$name" &>/dev/null; then
        printf "  ${DRK}[──────────────────────────────────────────────────]${RST} ${DRK}⊘ not installed  ${name}${RST}\n"
        echo "  ⊘ NOT INSTALLED : $name" >> "$LOG_FILE"
        FAIL=$((FAIL + 1))
        FAIL_LIST+=("$name")
        return
    fi

    # 2. If cmd given, check for runtime errors (e.g. ModuleNotFoundError)
    if [ -n "$cmd" ]; then
        local out
        out=$(eval "$cmd" 2>&1)
        if echo "$out" | grep -qi "ModuleNotFoundError\|ImportError\|No module named"; then
            printf "  ${RED}[██████████████████████████████████████████████████]${RST} ${RED}✗ broken (import error)  ${name}${RST}\n"
            echo "  ✗ BROKEN (import error) : $name" >> "$LOG_FILE"
            BROKEN=$((BROKEN + 1))
            BROKEN_LIST+=("$name")
            return
        fi
    fi

    # 3. All good
    printf "  ${GRN}[██████████████████████████████████████████████████]${RST} ${GRN}✓ ok  ${RST}${DIM}${name}${RST}\n"
    echo "  ✓ ok             : $name" >> "$LOG_FILE"
    PASS=$((PASS + 1))
}

# ── GO TOOLS ─────────────────────────────────────────────────────
_hdr "GO TOOLS"
_check "subfinder"
_check "assetfinder"
_check "shosubgo"
_check "github-subdomains"
_check "chaos"
_check "ffuf"
_check "gobuster"
_check "naabu"
_check "gau"
_check "waybackurls"
_check "katana"
_check "hakrawler"
_check "gf"
_check "qsreplace"
_check "anew"
_check "unfurl"
_check "httpx"
_check "httprobe"
_check "subzy"
_check "freq"
_check "kxss"
_check "xsschecker"
_check "dalfox"
_check "crlfuzz"
_check "nomore403"
_check "dnsx"
_check "tlsx"
_check "cdncheck"
_check "puredns"

# ── PYTHON TOOLS ─────────────────────────────────────────────────
_hdr "PYTHON TOOLS"
_check "crtsh"
_check "dirsearch"
_check "arjun"
_check "dirhunt"
_check "bhedak"
_check "xsstrike"
_check "shcheck"   "shcheck 2>&1 | head -5"
_check "secretfinder"
_check "paramspider"
_check "waymore"
_check "cmseek"    "cmseek 2>&1 | head -5"
_check "lucek"
_check "wafw00f"
_check "ghauri"

# ── BINARY / APT TOOLS ───────────────────────────────────────────
_hdr "BINARY / APT TOOLS"
_check "sqlmap"
_check "commix"
_check "medusa"
_check "brutespray"
_check "urldedupe"
_check "rustscan"
_check "nuclei"
_check "testssl.sh"

# ── SUMMARY ──────────────────────────────────────────────────────
echo ""
printf "  ${YLW}══════════════════════════════════════════════════════════════════${RST}\n"
printf "  ${GRN}✓ OK          : ${PASS} tools${RST}\n"
[ "$BROKEN" -gt 0 ] && printf "  ${RED}✗ BROKEN      : ${BROKEN} tools  — $(IFS=', '; echo "${BROKEN_LIST[*]}")${RST}\n"
[ "$FAIL"   -gt 0 ] && printf "  ${DRK}⊘ NOT INSTALLED: ${FAIL} tools  — $(IFS=', '; echo "${FAIL_LIST[*]}")${RST}\n"
printf "  ${YLW}══════════════════════════════════════════════════════════════════${RST}\n"
echo ""

# Write summary to log
{
    echo ""
    echo "══════════════════════════════════════════════"
    echo "  ✓ OK           : ${PASS} tools"
    [ "$BROKEN" -gt 0 ] && echo "  ✗ BROKEN       : ${BROKEN} tools  — $(IFS=', '; echo "${BROKEN_LIST[*]}")"
    [ "$FAIL"   -gt 0 ] && echo "  ⊘ NOT INSTALLED: ${FAIL} tools  — $(IFS=', '; echo "${FAIL_LIST[*]}")"
    echo "══════════════════════════════════════════════"
} >> "$LOG_FILE"

printf "  ${DIM}[*] Log saved: ${LOG_FILE}${RST}\n"
echo ""

# Quick fix hint for broken tools
if [ "$BROKEN" -gt 0 ]; then
    printf "  ${DIM}[*] Fix broken tools: sudo bash install-toolkit-for-linux-fixed.sh${RST}\n"
    echo ""
fi
