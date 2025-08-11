# BlockAssist One-Click Installer & Runner

This script automatically installs **[BlockAssist](https://github.com/gensyn-ai/blockassist)** along with all dependencies, sets up Python 3.10 using `pyenv`, and runs BlockAssist inside a **persistent `screen` session** so it stays alive even if you disconnect.  

---

## Features
- **One-click setup** for Linux (Ubuntu/Debian) and macOS.
- Installs all **build dependencies** needed to compile Python 3.10.
- Configures `pyenv` in the current session.
- Automatically installs required Python packages.
- Starts BlockAssist in a **persistent `screen` session** â€” keeps running after disconnect.
- If BlockAssist crashes, the screen session stays alive so you can debug.

---

## Requirements
- **Linux (Ubuntu/Debian)** or **macOS**
- `git`, `curl`, and `sudo` access
- Internet connection

---

## Login instructions
```bash
sudo apt update && sudo apt upgrade -y
```
```bash
sudo apt install npm git -y
```

```bash
git clone https://github.com/gensyn-ai/blockassist.git
```
```bash
cd blockassist
```
```bash
cd modal-login
```
```bash
yarn install && yarn dev
```

Open new tab 

```bash
sudo npm install -g localtunnel
```
```bash
lt --port 3000
```

Go back to old tab ctrl c that
then
```bash
cd ..
```

Create a screen 
```bash
screen -S blockassist
```

Now follow commands from official repository **[BlockAssist](https://github.com/gensyn-ai/blockassist)**

```bash
export DISPLAY=:0 && pyenv exec python run.py
```

**Attach to BlockAssist**:
   ```bash
   screen -r blockassist
   ```

---

## Script Workflow
The script will:
1. Clone the **BlockAssist** repository.
2. Run the `setup.sh` provided by BlockAssist.
3. Install all required build tools for compiling Python.
4. Install and configure `pyenv`.
5. Install **Python 3.10**.
6. Install **psutil** and **readchar** packages.
7. Ensure `screen` is installed.
8. Launch BlockAssist in a **persistent `screen` session**.

---

## Screen Session Commands
- **Attach to BlockAssist**:
  ```bash
  screen -r blockassist
  ```
- **Detach from session**:
  - Press `Ctrl + A`, then `D`
- **Stop BlockAssist**:
  ```bash
  screen -S blockassist -X quit
  ```

---

## Notes
- On **first run**, BlockAssist may ask for:
  - **Hugging Face API token**.
  - **Gensyn Testnet** login via your browser.
- The script configures `pyenv` only for the **current shell session**.  
  If you want it to work automatically on every login, add:
  ```bash
  export PYENV_ROOT="$HOME/.pyenv"
  [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init - bash)"
  ```
  to your `~/.bashrc` or `~/.zshrc`.

---
