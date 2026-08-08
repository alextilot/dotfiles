# Homebrew: keep first so `brew`, `pyenv` (if from brew), etc. are on PATH.
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# pyenv: shims on PATH for login shells (Terminal.app, ssh, GUI subprocesses).
# Interactive: ~/.zshrc → darwin.zsh uses `pyenv init - zsh`.
# https://github.com/pyenv/pyenv/blob/master/README.md#set-up-your-shell-environment-for-pyenv
export PYENV_ROOT="${PYENV_ROOT:-$HOME/.pyenv}"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv >/dev/null 2>&1; then
  # --no-rehash: interactive shells rehash once via darwin.zsh (avoids
  # duplicate rehash + lock contention when many terminals open at once).
  eval "$(pyenv init --path --no-rehash)"
fi

# nvm: put `nvm alias default` bin on PATH without sourcing nvm.sh (agents / login).
# Interactive `nvm` is lazy-loaded in darwin.zsh.
# Resolve nested aliases (default -> lts/* -> lts/krypton -> v24.x).
export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"
_nvm_target=$(cat "$NVM_DIR/alias/default" 2>/dev/null) || true
if [[ -n ${_nvm_target:-} ]]; then
  integer _nvm_i
  for ((_nvm_i = 0; _nvm_i < 8; _nvm_i++)); do
    [[ -f "$NVM_DIR/alias/$_nvm_target" ]] || break
    _nvm_target=$(<"$NVM_DIR/alias/$_nvm_target")
  done
  _nvm_ver=${_nvm_target#v}
  _nvm_bin="$NVM_DIR/versions/node/v${_nvm_ver}/bin"
  [[ -d $_nvm_bin ]] && path=("$_nvm_bin" $path)
fi
unset _nvm_target _nvm_ver _nvm_bin _nvm_i

# jenv: put selected JDK on PATH without `jenv init` (agents / login).
# Interactive `jenv` is lazy-loaded in darwin.zsh.
export PATH="$HOME/.jenv/bin:$PATH"
_jenv_ver=$(cat "$HOME/.jenv/version" 2>/dev/null) || true
if [[ -n ${_jenv_ver:-} && -d $HOME/.jenv/versions/$_jenv_ver ]]; then
  export JAVA_HOME="$HOME/.jenv/versions/$_jenv_ver"
  path=("$JAVA_HOME/bin" $path)
fi
unset _jenv_ver
