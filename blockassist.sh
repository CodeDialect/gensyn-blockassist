#!/usr/bin/env bash
set -e
info() {
  printf "${CYAN}%s${RESET}\n" "$*"
}

CYAN='\033[0;36m'
GREEN='\033[1;32m'
RED='\033[1;31m'
BLUE='\033[1;34m'
PURPLE='\033[1;35m'
RESET='\033[0m'
BOLD='\033[1m'

# ===============================
# BANNER
# ===============================
echo -e "${PURPLE}${BOLD}"
echo -e "${CYAN}
 
 ______              _         _                                             
|  ___ \            | |       | |                   _                        
| |   | |  ___    _ | |  ____ | | _   _   _  ____  | |_   ____   ____  _____ 
| |   | | / _ \  / || | / _  )| || \ | | | ||  _ \ |  _) / _  ) / ___)(___  )
| |   | || |_| |( (_| |( (/ / | | | || |_| || | | || |__( (/ / | |     / __/ 
|_|   |_| \___/  \____| \____)|_| |_| \____||_| |_| \___)\____)|_|    (_____)                   
                                
                                                                                                                                
${YELLOW}                      :: Powered by Noderhunterz ::
${NC}"

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - bash)"

# Ensure npm/yarn/localtunnel
if ! command -v npm >/dev/null; then
  info "Installing npm..."
  sudo apt update && sudo apt install -y npm
fi
if ! command -v yarn >/dev/null; then
  info "Installing yarn..."
  sudo npm install -g yarn
fi
if ! command -v lt >/dev/null; then
  info "Installing localtunnel..."
  sudo npm install -g localtunnel
fi

# ==== 3. Run setup.sh ====
info "Running setup.sh..."
chmod +x setup.sh
./setup.sh

# ==== 4. Install build dependencies for pyenv ====
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  info "Installing build dependencies for pyenv..."
  sudo apt install -y \
    build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev \
    libsqlite3-dev wget curl llvm libncursesw5-dev xz-utils tk-dev \
    libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev zip
fi

# ==== 5. Install pyenv ====
if ! command -v pyenv >/dev/null; then
  if [[ "$OSTYPE" == "darwin"* ]]; then
    brew install pyenv
  elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    curl -fsSL https://pyenv.run | bash
  fi
fi

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - bash)"

# ==== 6. Install Python 3.10 ====
if ! pyenv versions --bare | grep -q "^3.10"; then
  pyenv install 3.10
fi
pyenv local 3.10

# ==== 7. Install Python packages ====
pip install --upgrade pip
pip install psutil readchar

# ==== 8. Install screen if not installed ====
if ! command -v screen >/dev/null; then
  sudo apt install -y screen
fi

info "✅ Setup complete!"
echo
echo "Create Screen:   screen -S blockassist"
echo "Detach:   Ctrl+A, D"
echo "Stop:     screen -S blockassist -X quit"
