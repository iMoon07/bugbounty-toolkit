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
echo -e "${REDBG}${YLW}                  G F   P A T T E R N S   I N S T A L L E R              ${RST}"
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
_tp "${GRN}  ▸ GF PATTERNS — 16 repos${RST}"
_tp "${WHT}  1ndianl33t   robre   mrofisr${RST}"
_tp "${WHT}  NitinYadav00  Matir  bp0lr${RST}"
_tp "${WHT}  arthur4ires   r00tkie${RST}"
_tp "${CYN}  ▸ SECRETS & CREDENTIALS${RST}"
_tp "${WHT}  dwisiswant0/gf-secrets${RST}"
_tp "${CYN}  ▸ PHP DANGEROUS FUNCTIONS${RST}"
_tp "${WHT}  Jude-Paul  seqrity/Allin1gf${RST}"
_tp "${CYN}  ▸ EXTENDED COLLECTIONS${RST}"
_tp "${WHT}  YouthCrew  cypher3107  Garud${RST}"
_tp "${CYN}  ▸ NEW 2025/2026${RST}"
_tp "${WHT}  coffinxp  rix4uni${RST}"
_tp ""
_tp "${DIM}  Output → ~/.gf/*.json${RST}"
_tp "${YLW}  ══════════════════════════════════${RST}"

printf '\033[4B'
echo -e "${WHT}  cat urls.txt | gf xss | gf sqli | gf ssrf${RST}"
echo -e "${YLW}  ══════════════════════════════════════════════════════════════════${RST}"
echo ""

echo -e "${REDBG}${DIM}  [GF]  Cloning pattern repos → moving .json → ~/.gf/              ${RST}"
echo -e "${REDBG}${YLW}$(printf ' %.0s' {1..72})${RST}"
echo -e "${DIM}  Developed by iMoon · linkedin.com/in/imoon07   |   Inspired by Rootbakar · progress28.com${RST}"
echo ""
sleep 1

# ─────────────────────────────────────────────────────────────────────────────
# Infrastructure
# ─────────────────────────────────────────────────────────────────────────────
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_FILE="${SCRIPT_DIR}/gf-install.log"
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

# ─────────────────────────────────────────────────────────────────────────────
# Setup
# ─────────────────────────────────────────────────────────────────────────────
GF_DIR="$HOME/.gf"
mkdir -p "$GF_DIR"

# ─────────────────────────────────────────────────────────────────────────────
# Repo list
# ─────────────────────────────────────────────────────────────────────────────
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

# ─────────────────────────────────────────────────────────────────────────────
_hdr "GF PATTERNS  (${#repos[@]} repos → ~/.gf/)"

for repo in "${repos[@]}"; do
    name=$(basename "$repo")
    _run "$name" "
        git clone --depth=1 '$repo' '${GF_DIR}/_tmp_${name}' &&
        find '${GF_DIR}/_tmp_${name}' -type f -name '*.json' -exec mv {} '${GF_DIR}/' \\; &&
        rm -rf '${GF_DIR}/_tmp_${name}'
    "
done

# ─────────────────────────────────────────────────────────────────────────────
# Summary
# ─────────────────────────────────────────────────────────────────────────────
PATTERN_COUNT=$(ls "$GF_DIR"/*.json 2>/dev/null | wc -l)

echo ""
echo -e "${YLW}  ══════════════════════════════════════════════════════════════════${RST}"
echo -e "${GRN}  ✓ REPOS OK  : ${PASS}/${#repos[@]}${RST}"
[ "$FAIL" -gt 0 ] && echo -e "${DRK}  ✗ FAILED    : ${FAIL}  —  check log: ${LOG_FILE}${RST}" || true
echo -e "${CYN}  ◈ PATTERNS  : ${PATTERN_COUNT} .json files in ~/.gf/${RST}"
echo -e "${DIM}  LOG         : ${LOG_FILE}${RST}"
echo -e "${YLW}  ══════════════════════════════════════════════════════════════════${RST}"
echo ""
echo -e "${DIM}  Usage examples:${RST}"
echo -e "${WHT}    cat urls.txt | gf xss${RST}"
echo -e "${WHT}    cat urls.txt | gf sqli${RST}"
echo -e "${WHT}    cat urls.txt | gf ssrf${RST}"
echo -e "${WHT}    cat urls.txt | gf redirect${RST}"
echo -e "${WHT}    cat urls.txt | gf rce${RST}"
echo -e "${WHT}    cat urls.txt | gf secrets${RST}"
echo ""
