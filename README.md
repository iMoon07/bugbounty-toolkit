
<div align="center">

<table><tr>
<td align="center" valign="middle">
<pre>
  \__/         \__/         \__/
  (oo)         (o-)         (@@)
 //||\\       //||\\       //||\\
  bug          bug          bug
             winking      hangover

  \__/         \__/         \__/
  (xx)         (--)         (OO)
 //||\\       //||\\       //||\\
  dead         bug          bug
   bug        sleep        female
</pre>
</td>
<td align="center" valign="middle">
<pre>
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
</pre>
</td>
</tr></table>

</div>

# 🐛 BUG BOUNTY TOOLKIT v1.0

**A fully automated installer, updater, health checker, and GF pattern manager for bug bounty hunting on Kali Linux.**

[![Platform](https://img.shields.io/badge/platform-Kali%20Linux-557C94?style=for-the-badge&logo=linux&logoColor=white)](https://www.kali.org/)
[![Tools](https://img.shields.io/badge/tools-51%20total-brightgreen?style=for-the-badge)](https://github.com/iMoon07/bugbounty-toolkit)
[![Scripts](https://img.shields.io/badge/scripts-3-blue?style=for-the-badge)](https://github.com/iMoon07/bugbounty-toolkit)
[![License](https://img.shields.io/badge/license-MIT-orange?style=for-the-badge)](LICENSE)

> Developed by [iMoon](https://www.linkedin.com/in/imoon07/) · Inspired by [Rootbakar](https://progress28.com/)

</div>

---

## 📁 Scripts Overview

| Script | Description |
|--------|-------------|
| [`install-toolkit-for-linux-fixed.sh`](#-installation) | Full installer — installs all 51 tools from scratch |
| [`update-toolkit.sh`](#-updating) | Smart updater — updates only installed tools |
| [`gf-install-updated.sh`](#-gf-patterns) | GF pattern installer — 16 curated pattern repos |
| [`check-toolkit.sh`](#-health-check) | Health checker — verifies all tools are working |
| [`uninstall-toolkit.sh`](#-uninstallation) | Uninstaller — safely removes all tools and binaries |

> ⚠️ **Kali Linux only.** Tested on Kali Rolling. Other distros (Ubuntu, Debian, Parrot) are not officially supported — APT packages and Python flags may differ.

---

## 🛠️ Tool List — 51 Tools Total

### ⚡ Go Tools (29)

> Installed via `go install @latest` → synced to `/usr/local/bin/`

| Tool | Purpose |
|------|---------|
| [subfinder](https://github.com/projectdiscovery/subfinder) | Passive subdomain enumeration |
| [assetfinder](https://github.com/tomnomnom/assetfinder) | Find related domains & subdomains |
| [shosubgo](https://github.com/incogbyte/shosubgo) | Shodan subdomain grabber |
| [github-subdomains](https://github.com/gwen001/github-subdomains) | Find subdomains via GitHub |
| [chaos](https://github.com/projectdiscovery/chaos-client) | ProjectDiscovery subdomain dataset |
| [ffuf](https://github.com/ffuf/ffuf) | Fast web fuzzer |
| [gobuster](https://github.com/OJ/gobuster) | Directory/file/DNS/vhost brute force |
| [naabu](https://github.com/projectdiscovery/naabu) | Fast port scanner |
| [gau](https://github.com/lc/gau) | Get all URLs from Wayback/AlienVault |
| [waybackurls](https://github.com/tomnomnom/waybackurls) | Fetch URLs from Wayback Machine |
| [katana](https://github.com/projectdiscovery/katana) | Next-gen web crawler |
| [hakrawler](https://github.com/hakluke/hakrawler) | Fast web crawler for endpoints |
| [gf](https://github.com/tomnomnom/gf) | Pattern matching wrapper for grep |
| [qsreplace](https://github.com/tomnomnom/qsreplace) | Replace query string values |
| [httpx](https://github.com/projectdiscovery/httpx) | Fast HTTP probing |
| [httprobe](https://github.com/tomnomnom/httprobe) | Probe for working HTTP/HTTPS servers |
| [anew](https://github.com/tomnomnom/anew) | Append unique lines to file |
| [unfurl](https://github.com/tomnomnom/unfurl) | Pull URL components |
| [subzy](https://github.com/PentestPad/subzy) | Subdomain takeover tool |
| [freq](https://github.com/takshal/freq) | Send bulk GET requests |
| [kxss](https://github.com/Emoe/kxss) | Find XSS-injectable parameters |
| [xsschecker](https://github.com/rix4uni/xsschecker) | XSS parameter checker |
| [dalfox](https://github.com/hahwul/dalfox) | XSS scanning & parameter analysis |
| [crlfuzz](https://github.com/dwisiswant0/crlfuzz) | CRLF injection scanner |
| [nomore403](https://github.com/devploit/nomore403) | 403 bypass techniques |
| [dnsx](https://github.com/projectdiscovery/dnsx) | Fast DNS toolkit |
| [tlsx](https://github.com/projectdiscovery/tlsx) | TLS/SSL information gathering |
| [cdncheck](https://github.com/projectdiscovery/cdncheck) | Detect CDN-protected IPs |
| [puredns](https://github.com/d3mondev/puredns) | Reliable DNS brute force |

---

### 🐍 Python Tools (14)

> Mix of pip-installed and git-cloned → synced to `/usr/local/bin/`

| Tool | Type | Purpose |
|------|------|---------|
| [crtsh](https://github.com/YashGoti/crtsh.py) | git | Certificate transparency lookup |
| [dirsearch](https://github.com/maurosoria/dirsearch) | pip | Web path discovery |
| [arjun](https://github.com/s0md3v/Arjun) | git | HTTP parameter discovery |
| [dirhunt](https://github.com/Nekmo/dirhunt) | pip | Directory finder without brute force |
| [bhedak](https://github.com/R0X4R/Bhedak) | pip | Replace query string values (python) |
| [xsstrike](https://github.com/s0md3v/XSStrike) | git | XSS detection suite |
| [shcheck](https://github.com/santoru/shcheck) | git | HTTP security headers checker |
| [secretfinder](https://github.com/m4ll0k/SecretFinder) | git | Find API keys & secrets in JS |
| [paramspider](https://github.com/devanshbatham/paramspider) | git | Parameter mining from web archives |
| [waymore](https://github.com/xnl-h4ck3r/waymore) | git | More ways to get URLs |
| [cmseek](https://github.com/Tuhinshubhra/CMSeeK) | git | CMS detection & exploitation |
| [lucek](https://github.com/rootbakar/LUcek) | git | LFI/URL checker |
| [wafw00f](https://github.com/EnableSecurity/wafw00f) | pip | WAF fingerprinting |
| [ghauri](https://github.com/r0oth3x49/ghauri) | git | Advanced SQL injection detection |

---

### 🔧 Binary / APT Tools (8)

> Installed via apt or pre-compiled binary download

| Tool | Install Method | Purpose |
|------|---------------|---------|
| [sqlmap](https://github.com/sqlmapproject/sqlmap) | apt | Automatic SQL injection |
| [commix](https://github.com/commixproject/commix) | apt | Command injection exploitation |
| [medusa](https://github.com/jmk-foofus/medusa) | apt | Parallel brute force |
| [brutespray](https://github.com/x90skysn3k/brutespray) | apt | Brute force from nmap output |
| [urldedupe](https://github.com/ameenmaali/urldedupe) | source (cmake) | URL deduplication |
| [rustscan](https://github.com/RustScan/RustScan) | binary | Modern fast port scanner |
| [nuclei](https://github.com/projectdiscovery/nuclei) | binary | Template-based vulnerability scanner |
| [testssl.sh](https://github.com/drwetter/testssl.sh) | git | SSL/TLS testing tool |

---

## 🚀 Installation

### Prerequisites

```bash
sudo apt update
sudo apt install -y git curl wget golang python3 python3-pip cmake libpcap-dev
```

### Install All Tools

```bash
git clone https://github.com/iMoon07/bugbounty-toolkit.git
cd ~/bugbounty-toolkit
chmod +x install-toolkit-for-linux-fixed.sh
sudo bash install-toolkit-for-linux-fixed.sh
```

> ⏱️ **Estimated time:** 15–30 minutes depending on internet speed  
> 📄 **Log file:** `install.log` (in same directory as script)

**What the installer does:**
- Skips tools that are already installed (safe to re-run)
- Shows animated progress bar for each tool (no log spam)
- Clones git repos to `~/BUG_BOUNTY_TOOLS/`
- Syncs all Go binaries to `/usr/local/bin/`

---

## 🔄 Updating

```bash
cd ~/bugbounty-toolkit
sudo bash update-toolkit.sh
```

> 📄 **Log file:** `update.log` (in same directory as script)

### Update Strategy Per Tool Type

| Tool Type | Strategy |
|-----------|---------|
| Go tools | `go install @latest` → re-compiles to newest version |
| Python pip tools | `pip3 install -U` → upgrades to latest |
| Python git tools | `git pull` + `pip install -r requirements.txt` |
| APT tools | `apt install --only-upgrade` |
| RustScan | Re-download latest binary from GitHub releases |
| Nuclei | Re-download latest release from GitHub |

### Smart Skip Logic

- ✓ Tool installed + folder exists → **git pull + update**
- ✓ Tool installed + folder missing → **auto re-clone + reinstall**  
- ⊘ Tool not installed → **skip** (won't install new tools)

---

## 📂 GF Patterns

[gf](https://github.com/tomnomnom/gf) is a wrapper around grep that makes it easy to grep for common patterns in URLs and responses.

```bash
cd ~/bugbounty-toolkit
bash gf-install-updated.sh
```

### Installed Patterns (16 repos)

| Repo | Patterns included |
|------|-------------------|
| [tomnomnom/gf](https://github.com/tomnomnom/gf) | base patterns |
| [1ndianl33t/Gf-Patterns](https://github.com/1ndianl33t/Gf-Patterns) | sqli, xss, ssrf, redirect, rce, idor, debug_logic, img-traversal, interestingparams, interestingEXT, interestingsubs, s3-buckets |
| [dwisiswant0/gf-secrets](https://github.com/dwisiswant0/gf-secrets) | secrets |
| [emadshanab/Gf-Patterns-For-Nuclei](https://github.com/emadshanab/Gf-Patterns-For-Nuclei) | nuclei patterns |
| [coffinxp/gf-patterns](https://github.com/coffinxp/gf-patterns) | lfi, ssti |
| [rix4uni/gf-patterns](https://github.com/rix4uni/gf-patterns) | additional patterns |

Patterns are installed to `~/.gf/*.json`

### Basic Usage

```bash
# Filter URLs by vulnerability pattern
cat urls.txt | gf xss
cat urls.txt | gf sqli
cat urls.txt | gf ssrf
cat urls.txt | gf lfi
```

---

## 🩺 Health Check

Run after install or update to verify all tools are working:

```bash
bash ~/bugbounty-toolkit/check-toolkit.sh
```

Output example:
```
[██████████] ✓ ok   subfinder
[██████████] ✓ ok   dalfox
[██████████] ✗ broken (import error)   cmseek
[──────────] ⊘ not installed   rustscan

══════════════════════════════════
✓ OK           : 49 tools
✗ BROKEN       : 1 tools  — cmseek
⊘ NOT INSTALLED: 1 tools  — rustscan
══════════════════════════════════
```

- **✓ ok** — binary found and no import errors
- **✗ broken** — binary exists but crashes on load (e.g. Python module error)
- **⊘ not installed** — binary not found in PATH

---

## 🗑️ Uninstallation

If you want to completely remove the toolkit and its tools, run the smart uninstaller:

```bash
cd ~/bugbounty-toolkit
sudo bash uninstall-toolkit.sh
```

> 📄 **Log file:** `uninstall.log` (in same directory as script)

**What the uninstaller does:**
- Automatically clears any stuck `apt` or `dpkg` locks
- Removes the `~/BUG_BOUNTY_TOOLS/` and `~/.gf/` directories
- **Smart Tracking:** Dynamically reads the tool list from `check-toolkit.sh` and tracks down their exact binary locations across your entire system (`$PATH`) to ensure 100% complete removal
- Leaves base dependencies (`go`, `python3`, `cmake`) intact so you can easily reinstall later

---

## 📂 Directory Structure

```
~/bugbounty-toolkit/               ← scripts live here (clone this repo)
├── install-toolkit-for-linux-fixed.sh ← install tools
├── update-toolkit.sh              ← update tools
├── gf-install-updated.sh          ← install gf patterns
├── check-toolkit.sh               ← check health of tools
├── install.log                    ← install log (auto-created)
├── update.log                     ← update log (auto-created)
└── README.md                      ← Guide

~/BUG_BOUNTY_TOOLS/                ← git-based Python/C tools cloned here
├── Arjun/                         ← HTTP parameter discovery
├── CMSeeK/                        ← CMS detection
├── crtsh.py/                      ← certificate transparency
├── ghauri/                        ← SQL injection
├── LUcek/                         ← LFI/URL checker
├── Nuclei/                        ← vulnerability scanner binary
├── paramspider/                   ← parameter mining
├── SecretFinder/                  ← JS secrets finder
├── shcheck/                       ← HTTP security headers
├── testssl.sh/                    ← SSL/TLS testing
├── urldedupe/                     ← URL deduplication
├── waymore/                       ← URL discovery
├── wafw00f/                       ← WAF fingerprinting
└── XSStrike/                      ← XSS detection suite

/usr/local/bin/                   ← ALL binaries/wrappers → run from anywhere
├── subfinder, assetfinder, shosubgo, github-subdomains, chaos
├── ffuf, gobuster, naabu, gau, waybackurls, katana, hakrawler
├── gf, qsreplace, anew, unfurl, httpx, httprobe
├── subzy, freq, kxss, xsschecker, dalfox, crlfuzz, nomore403
├── dnsx, tlsx, cdncheck, puredns
├── dirsearch, arjun, dirhunt, bhedak, wafw00f
├── crtsh, xsstrike, shcheck, secretfinder, paramspider
├── waymore, cmseek, lucek, ghauri
├── sqlmap, commix, medusa, brutespray
└── rustscan, nuclei, testssl.sh, urldedupe

~/.gf/                            ← GF pattern files (JSON)
└── xss.json, sqli.json, ssrf.json, lfi.json, ssti.json,
    rce.json, idor.json, redirect.json, secrets.json, ...
```


---

## 💡 Tips


**Check logs for troubleshooting:**

All scripts automatically generate logs in the `~/bugbounty-toolkit/` directory. If you encounter issues, these logs contain the exact errors (like missing dependencies or network timeouts):

```bash
# Check what failed during installation
grep "FAILED" ~/bugbounty-toolkit/install.log

# Check what failed during update
grep "FAILED" ~/bugbounty-toolkit/update.log

# Check errors during uninstallation
cat ~/bugbounty-toolkit/uninstall.log

# View full health check history
cat ~/bugbounty-toolkit/check.log

# View GF patterns installation log
cat ~/bugbounty-toolkit/gf-install.log
```

---

## 🧪 Practice Labs

Before hunting in the wild for VDP or Bug Bounty, test your weapons here first. No need to test on random live sites and make enemies. 

These local labs are the best places to safely test this toolkit:

| Lab | Stack | Link | Best for |
|-----|-------|------|----------|
| **Mutillidae II** | PHP + MySQL | [github.com/webpwnized/mutillidae2](https://github.com/webpwnized/mutillidae2) | Comprehensive training for OWASP Top 10 |
| **DVWA** | PHP + MySQL | [github.com/digininja/DVWA](https://github.com/digininja/DVWA) | Beginners — great for practicing SQLi & XSS |
| **bWAPP** | PHP + MySQL | [sourceforge.net/projects/bwapp/files/bWAPP/](https://sourceforge.net/projects/bwapp/files/bWAPP/) | Massive collection of 100+ different vulnerabilities |
| **WebGoat** | Java | [github.com/WebGoat/WebGoat](https://github.com/WebGoat/WebGoat) | Step-by-step guided lessons with hints |
| **Juice Shop** | Node.js | [github.com/juice-shop/juice-shop](https://github.com/juice-shop/juice-shop) | Modern UI (Angular) — feels exactly like a real-world target |

> 💡 **Why start here?** Mastering these labs ensures you know *why* a vulnerability exists, *how* to exploit it manually, and *how* to automate the discovery using the 51 tools in this toolkit. Do not rush to live targets until you can confidently compromise these environments.

---

## 💻 Useful One-Liners

Now that you have all the tools, you need to know how to chain them together for maximum impact! 
For a massive collection of ready-to-use Bug Bounty one-liners (for Recon, XSS, SQLi, SSRF, etc.), check out this awesome repository:

- **[Rootbakar's Simple One-Liner](https://github.com/rootbakar/simple-one-liner)** — Highly recommended reference!

---

## 🙏 Credits

- **Developed by** [iMoon](https://www.linkedin.com/in/imoon07/)
- **Inspired by** [Rootbakar](https://progress28.com/) — original toolkit concept
- All tool authors and contributors listed above

---

## ⚠️ Disclaimer

This toolkit is intended for **legal security testing and educational purposes only**.  
Always obtain proper authorization before testing any systems.  
The developers are not responsible for any misuse of these tools.

---

<div align="center">

Made with ❤️ for the Bug Bounty community

[LinkedIn](https://www.linkedin.com/in/imoon07/) · [GitHub](https://github.com/iMoon07/bugbounty-toolkit)

</div>
