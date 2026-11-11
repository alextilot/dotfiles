# Linux-only config, shared across every Linux box (work or personal) and
# sourced by .zshrc. Mirrors darwin.zsh's role on macOS. Identity-specific
# (work vs personal) config lives in linux.work.zsh / linux.personal.zsh
# instead.

# ~/.local/bin (dot-update, etc.) isn't put on PATH automatically by anything
# on either OS - darwin.zsh has this same line for the same reason.
export PATH="$HOME/.local/bin:$PATH"

# Node.js (nvm): default bin already on PATH via ~/.zprofile.
# Lazy-load full nvm only when the `nvm` command is used (mirrors darwin.zsh;
# on Linux nvm is a git checkout, so its completion ships inside $NVM_DIR).
export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"
nvm() {
  unset -f nvm
  [[ -s $NVM_DIR/nvm.sh ]] && . "$NVM_DIR/nvm.sh"
  [[ -s $NVM_DIR/bash_completion ]] && . "$NVM_DIR/bash_completion"
  nvm "$@"
}
