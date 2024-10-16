#!/bin/bash

# Function to display messages
function print_message {
    echo "==========================================="
    echo "$1"
    echo "==========================================="
}

# Function to check if a command is installed
function is_installed {
    command -v "$1" >/dev/null 2>&1
}

# Detecting the operating system
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS="Linux"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macOS"
else
    echo "Unsupported OS: $OSTYPE"
    exit 1
fi

# Updating package list and installing required tools based on OS
if [ "$OS" == "Linux" ]; then
    print_message "Updating package list for Linux..."
    sudo apt update -y

    # Installing CMake and libpcap
    if ! is_installed cmake; then
        print_message "Installing CMake..."
        sudo apt install cmake -y
    else
        print_message "CMake is already installed."
    fi

    if ! is_installed libpcap-dev; then
        print_message "Installing libpcap..."
        sudo apt install -y libpcap-dev
    else
        print_message "libpcap is already installed."
    fi

    # Installing Python 3.11 and 3.12
    for python_version in 3.11 3.12; do
        if ! is_installed "python$python_version"; then
            print_message "Installing Python $python_version..."
            sudo apt install "python$python_version" -y
        else
            print_message "Python $python_version is already installed."
        fi
    done

elif [ "$OS" == "macOS" ]; then
    print_message "Updating package list for macOS..."
    brew update

    # Installing CMake and libpcap
    if ! is_installed cmake; then
        print_message "Installing CMake..."
        brew install cmake
    else
        print_message "CMake is already installed."
    fi

    if ! is_installed libpcap; then
        print_message "Installing libpcap..."
        brew install libpcap
    else
        print_message "libpcap is already installed."
    fi

    # Installing Python 3.11 and 3.12
    for python_version in 3.11 3.12; do
        if ! is_installed "python$python_version"; then
            print_message "Installing Python $python_version..."
            brew install "python@$python_version"
        else
            print_message "Python $python_version is already installed."
        fi
    done
fi

# Creating folder for bug bounty tools
print_message "Creating BUG_BOUNTY_TOOLS directory..."
mkdir -p ~/BUG_BOUNTY_TOOLS
cd ~/BUG_BOUNTY_TOOLS || exit

# Installing Golang
if ! is_installed go; then
    print_message "Installing Golang..."
    wget https://go.dev/dl/go1.23.1.linux-amd64.tar.gz -O go.tar.gz
    sudo tar -xzvf go.tar.gz -C /usr/local
    echo "export PATH=\$HOME/go/bin:/usr/local/go/bin:\$PATH" >> ~/.profile
    source ~/.profile
    go version
else
    print_message "Golang is already installed."
fi

# Installing Golang tools
print_message "Installing Golang tools..."
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

# Copying Go tools to /usr/local/bin
print_message "Copying Go tools to /usr/local/bin..."
cd ~/go/bin || exit
sudo cp * /usr/local/bin/

# Returning to BUG_BOUNTY_TOOLS directory
cd ~/BUG_BOUNTY_TOOLS || exit

# Installing CRTSH
if ! is_installed crtsh; then
    print_message "Installing CRTSH..."
    git clone https://github.com/YashGoti/crtsh.py.git
    cd crtsh.py || exit
    mv crtsh.py crtsh
    chmod +x crtsh
    sudo cp crtsh /usr/local/bin/
else
    print_message "CRTSH is already installed."
fi

# Returning to BUG_BOUNTY_TOOLS directory
cd ~/BUG_BOUNTY_TOOLS || exit

# Installing Dirsearch
if ! is_installed dirsearch; then
    print_message "Installing Dirsearch..."
    git clone https://github.com/maurosoria/dirsearch.git --depth 1
    cd dirsearch || exit
    python3.11 -m pip install -r requirements.txt --break-system-packages
    python3.12 -m pip install -r requirements.txt --break-system-packages
    sudo python3.11 setup.py install
    sudo python3.12 setup.py install
else
    print_message "Dirsearch is already installed."
fi

# Installing Dirhunt, Arjun, and Bhedak
print_message "Installing Dirhunt, Arjun, and Bhedak..."
sudo pip3 install dirhunt
sudo pip3 install arjun
sudo pip3 install bhedak

# Installing ParamsPider
if ! is_installed paramspider; then
    print_message "Installing ParamsPider..."
    git clone https://github.com/devanshbatham/paramspider
    cd paramspider || exit
    sudo pip3 install .
else
    print_message "ParamsPider is already installed."
fi

# Returning to BUG_BOUNTY_TOOLS directory
cd ~/BUG_BOUNTY_TOOLS || exit

# Installing URLDedupe
if ! is_installed urldedupe; then
    print_message "Installing URLDedupe..."
    git clone https://github.com/ameenmaali/urldedupe.git
    cd urldedupe || exit
    cmake CMakeLists.txt
    make
    sudo cp urldedupe /usr/local/bin 
else
    print_message "URLDedupe is already installed."
fi

# Returning to BUG_BOUNTY_TOOLS directory
cd ~/BUG_BOUNTY_TOOLS || exit

# Installing LUcek
if ! is_installed LUcek; then
    print_message "Installing LUcek..."
    git clone https://github.com/rootbakar/LUcek.git
    cd LUcek || exit
    bash requirement-linux.sh
else
    print_message "LUcek is already installed."
fi

# Returning to BUG_BOUNTY_TOOLS directory
cd ~/BUG_BOUNTY_TOOLS || exit

# Installing RustScan
if ! is_installed rustscan; then
    print_message "Installing RustScan..."
    wget https://github.com/RustScan/RustScan/releases/download/2.3.0/rustscan-2.3.0-x86_64-linux.zip
    unzip rustscan-2.3.0-x86_64-linux.zip
    cd tmp || exit
    cd rustscan-2.3.0-x86_64-linux || exit
    sudo cp rustscan /usr/local/bin/
else
    print_message "RustScan is already installed."
fi

# Returning to BUG_BOUNTY_TOOLS directory
cd ~/BUG_BOUNTY_TOOLS || exit

print_message "All tools have been successfully installed."
