# Homebrew: keep first so `brew`, `pyenv` (if from brew), etc. are on PATH.
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# pyenv: shims on PATH for login shells (Terminal.app, ssh, GUI subprocesses).
# Interactive: ~/.zshrc → darwin.local.zsh uses `pyenv init - zsh`.
# https://github.com/pyenv/pyenv/blob/master/README.md#set-up-your-shell-environment-for-pyenv
export PYENV_ROOT="${PYENV_ROOT:-$HOME/.pyenv}"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv >/dev/null 2>&1; then
  # --no-rehash: interactive shells rehash once via darwin.local.zsh (avoids
  # duplicate rehash + lock contention when many terminals open at once).
  eval "$(pyenv init --path --no-rehash)"
fi
