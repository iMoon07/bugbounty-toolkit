
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

**A high-performance, fully automated toolkit for Bug Bounty, VDP, and Penetration Testing. Seamlessly deploy, update, and manage 51 essential hacking tools and 124+ GF patterns on Kali Linux.**

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

### ⚡ Go Tools (30)

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
| [brutespray](https://github.com/x90skysn3k/brutespray) | Brute force from nmap output |

---

### 🐍 Python Tools (16)

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
| [sqlmap](https://github.com/sqlmapproject/sqlmap) | git | Automatic SQL injection |
| [commix](https://github.com/commixproject/commix) | git | Command injection exploitation |

---

### 🔧 Binary Tools (5)

> Installed via pre-compiled binary download or compiled from source

| Tool | Install Method | Purpose |
|------|---------------|---------|
| [medusa](https://github.com/jmk-foofus/medusa) | source (make) | Parallel brute force |
| [urldedupe](https://github.com/ameenmaali/urldedupe) | source (cmake) | URL deduplication |
| [rustscan](https://github.com/RustScan/RustScan) | binary | Modern fast port scanner |
| [nuclei](https://github.com/projectdiscovery/nuclei) | binary | Template-based vulnerability scanner |
| [testssl.sh](https://github.com/drwetter/testssl.sh) | git | SSL/TLS testing tool |

---

## 🚀 1. Installation (Base Tools)

### Prerequisites

```bash
sudo apt update
sudo apt install -y git curl wget golang python3 python3-pip cmake libpcap-dev
```

### Install Toolkit

```bash
git clone https://github.com/iMoon07/bugbounty-toolkit.git
cd ~/bugbounty-toolkit
chmod +x *.sh
sudo ./install-toolkit-for-linux-fixed.sh
```

> ⏱️ **Estimated time:** 15–30 minutes depending on internet speed  

> 💡 **Troubleshooting Failed Installs:**  
> If the summary at the end shows any tools failed to install, **run the installer a second time (`sudo ./install-toolkit-for-linux-fixed.sh`)**. Sometimes network timeouts or dependency locks cause temporary failures. If it still fails, check the log: `cat install.log` to trace the exact error.

**What this does:**
- Skips already installed tools (safe to re-run multiple times)
- Clones git repos to `~/BUG_BOUNTY_TOOLS/`
- Syncs all Go binaries and Python wrappers to `/usr/local/bin/`

---

## 📂 2. GF Patterns Installation (Required)

[gf](https://github.com/tomnomnom/gf) is a wrapper around `grep` for identifying vulnerabilities in URLs. **You must install the patterns before running the health check.**

```bash
cd ~/bugbounty-toolkit
./gf-install-updated.sh
```

> 📄 **Log file:** `gf-install.log` — Check this log if any pattern repo fails to clone.

### Installed Pattern Sources (16 Repos)

All patterns are aggregated and saved directly into `~/.gf/*.json`.

| Pattern Category | Source Repositories |
|------------------|---------------------|
| **Core Collections** | [1ndianl33t/Gf-Patterns](https://github.com/1ndianl33t/Gf-Patterns), [robre/gf-patterns](https://github.com/robre/gf-patterns), [mrofisr/gf-patterns](https://github.com/mrofisr/gf-patterns) |
| **Specialized Lists** | [NitinYadav00/gf-patterns](https://github.com/NitinYadav00/gf-patterns), [Matir/gf-patterns](https://github.com/Matir/gf-patterns), [bp0lr/myGF_patterns](https://github.com/bp0lr/myGF_patterns) |
| **Grep Patterns** | [arthur4ires/gfPatterns](https://github.com/arthur4ires/gfPatterns), [r00tkie/grep-pattern](https://github.com/r00tkie/grep-pattern) |
| **Secrets & Creds** | [dwisiswant0/gf-secrets](https://github.com/dwisiswant0/gf-secrets) |
| **PHP Dangerous Funcs** | [Jude-Paul/GF-Patterns-For-Dangerous-PHP-Functions](https://github.com/Jude-Paul/GF-Patterns-For-Dangerous-PHP-Functions), [seqrity/Allin1gf](https://github.com/seqrity/Allin1gf) |
| **Extended Patterns** | [scumdestroy/YouthCrew-GF-Patterns](https://github.com/scumdestroy/YouthCrew-GF-Patterns), [cypher3107/GF-Patterns](https://github.com/cypher3107/GF-Patterns), [R0X4R/Garud](https://github.com/R0X4R/Garud) |
| **New 2025/2026** | [coffinxp/GFpattren](https://github.com/coffinxp/GFpattren), [rix4uni/gf-patterns](https://github.com/rix4uni/gf-patterns) |

### Basic Usage

```bash
# Filter URLs by vulnerability pattern
cat urls.txt | gf xss
cat urls.txt | gf sqli
cat urls.txt | gf ssrf
cat urls.txt | gf secrets
```

---

## 🩺 3. Health Check

Run the health check to verify all 51 tools AND the GF patterns are perfectly configured.

```bash
cd ~/bugbounty-toolkit
./check-toolkit.sh
```

> 📄 **Log file:** `check.log` — Trace this log to see exactly what tool is missing from your `$PATH`.

**Output Statuses:**
- **✓ ok** — Binary found and fully functional.
- **⊘ not installed** — Tool is missing or your terminal `$PATH` is broken. Try running the installer again or open a new terminal.

---

## 🔄 4. Updating

Smart update strategy that only touches installed tools.

```bash
cd ~/bugbounty-toolkit
sudo ./update-toolkit.sh
```

> 📄 **Log file:** `update.log` — Check this if an update crashes (e.g. Go version mismatch).

**Update Strategy:**
- **Go tools:** `go install @latest`
- **Python tools:** `pip3 install -U` or `git pull`
- **Binaries:** Re-download latest GitHub releases

---

## 🗑️ 5. Uninstallation (Optional)

If you want to completely remove the toolkit and its tools, run the smart uninstaller.

```bash
cd ~/bugbounty-toolkit
sudo ./uninstall-toolkit.sh
```

> 📄 **Log file:** `uninstall.log` — Contains the exact paths of all deleted binaries.

**What the uninstaller does:**
- Automatically clears any stuck `apt` or `dpkg` locks
- Removes the `~/BUG_BOUNTY_TOOLS/` and `~/.gf/` directories
- **Smart Tracking:** Dynamically reads the tool list from `check-toolkit.sh` and tracks down their exact binary locations across your entire system (`$PATH`) to ensure 100% complete removal
- Leaves base dependencies (`go`, `python3`, `cmake`) intact so you can easily reinstall later

---

## 📂 Directory Structure

```text
~/bugbounty-toolkit/               ← scripts live here (clone this repo)
├── install-toolkit-for-linux-fixed.sh ← install tools
├── update-toolkit.sh              ← update tools
├── gf-install-updated.sh          ← install gf patterns
├── check-toolkit.sh               ← check health of tools
├── uninstall-toolkit.sh           ← smart uninstaller
├── install.log                    ← install log (auto-created)
├── update.log                     ← update log (auto-created)
├── check.log                      ← health check log (auto-created)
├── gf-install.log                 ← gf installation log (auto-created)
└── README.md                      ← Guide

~/BUG_BOUNTY_TOOLS/                ← source code & repos cloned here
├── Arjun/                         ← HTTP parameter discovery (pip installed)
├── CMSeeK/                        ← CMS detection (bash wrapper created)
├── commix/                        ← Command injection (bash wrapper created)
├── crtsh.py/                      ← certificate transparency (copied to bin)
├── ghauri/                        ← SQL injection (pip installed)
├── LUcek/                         ← LFI/URL checker (copied to bin)
├── medusa/                        ← Parallel brute force (compiled via make)
├── Nuclei/                        ← Vulnerability scanner (binary extracted)
├── paramspider/                   ← parameter mining (pip installed)
├── SecretFinder/                  ← JS secrets finder (copied to bin)
├── shcheck/                       ← HTTP security headers (bash wrapper created)
├── sqlmap/                        ← Automatic SQL injection (bash wrapper created)
├── testssl.sh/                    ← SSL/TLS testing (copied to bin)
├── urldedupe/                     ← URL deduplication (compiled via cmake)
├── waymore/                       ← URL discovery (pip installed)
└── XSStrike/                      ← XSS detection suite (copied to bin)

/usr/local/bin/                   ← ALL 51 binaries/wrappers → run from anywhere
├── Go Tools     : subfinder, assetfinder, shosubgo, github-subdomains, chaos, ffuf, gobuster, naabu, gau, waybackurls, katana, hakrawler, gf, qsreplace, anew, unfurl, httpx, httprobe, subzy, freq, kxss, xsschecker, dalfox, crlfuzz, nomore403, dnsx, tlsx, cdncheck, puredns, brutespray
├── Pip Tools    : dirsearch, arjun, dirhunt, bhedak, wafw00f, paramspider, waymore, ghauri
├── Custom Wraps : crtsh, xsstrike, shcheck, secretfinder, cmseek, lucek, sqlmap, commix
└── Binaries     : urldedupe, medusa, rustscan, nuclei, testssl.sh

~/.gf/                            ← GF pattern files (JSON)
└── xss.json, sqli.json, ssrf.json, lfi.json, ssti.json,
    rce.json, idor.json, redirect.json, secrets.json, ... (124+ files)
```

### 💡 Folders Explained

- **`~/bugbounty-toolkit/`**: This is the "Control Center". It contains the 5 main scripts (`install`, `update`, `check`, `uninstall`, `gf-install`) that manage everything. You only come here when you need to run one of these scripts.
- **`~/BUG_BOUNTY_TOOLS/`**: This is the "Warehouse". When the installer runs, it clones massive repositories (like SQLMap or CMSeeK) into this folder. You don't need to manually interact with this folder because the binaries/wrappers in `/usr/local/bin/` will automatically call the code stored here.
- **`~/.gf/`**: The "Pattern Library". Contains all the `.json` signature files used by the `gf` tool to grep for vulnerabilities.

### 💡 Binary Categories in `/usr/local/bin/`

- **Go Tools**: Compiled natively via `go install`. These are single static binaries copied directly for lightning-fast execution.
- **Pip Tools**: Installed via Python's package manager (`pip`). We forcefully link their executables into `/usr/local/bin/` to bypass Kali's strict environment rules.
- **Custom Wraps**: This is the magic part. For tools that are just giant folders of Python code (like `sqlmap`, `cmseek`, `commix`), the installer creates a smart bash "wrapper" script in `/usr/local/bin/` that silently points back to the source code in `~/BUG_BOUNTY_TOOLS/`. This means you can type `sqlmap` from anywhere without needing to `cd` into its directory first.
- **Binaries**: Standard compiled binaries (C/C++/Rust) built via `make` / `cmake` or downloaded directly from GitHub Releases.


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
