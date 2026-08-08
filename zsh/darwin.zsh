# macOS-only config, shared across every Mac (work or personal) and sourced
# by .zshrc. Safe to track: every block below is guarded by a `command -v` /
# `[[ -f ]]` / `[[ -d ]]` check, so it's a no-op on a machine that doesn't have
# the relevant tool or file. Identity-specific (work vs personal) config lives
# in darwin.work.zsh / darwin.personal.zsh instead.

# Node.js (nvm): default bin already on PATH via ~/.zprofile.
# Lazy-load full nvm only when the `nvm` command is used.
export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"
nvm() {
  unset -f nvm
  [[ -s $NVM_DIR/nvm.sh ]] && . "$NVM_DIR/nvm.sh"
  local _comp
  _comp="$(brew --prefix 2>/dev/null)/opt/nvm/etc/bash_completion.d/nvm"
  [[ -s $_comp ]] && . "$_comp"
  nvm "$@"
}

# Netskope SSL inspection: combined PEM from macOS trust store + Netskope CAs.
# No-op unless this file exists, e.g. on a machine behind corporate SSL
# inspection. Regenerate: security find-certificate -a -p \
#   /System/Library/Keychains/SystemRootCertificates.keychain \
#   /Library/Keychains/System.keychain > ~/.certs/nscacert_combined.pem
# then append tenant CA if missing:
#   security find-certificate -a -c 'goskope' -p /Library/Keychains/System.keychain >> ~/.certs/nscacert_combined.pem
#   security find-certificate -a -c 'certadmin' -p /Library/Keychains/System.keychain >> ~/.certs/nscacert_combined.pem
[[ -f "$HOME/.certs/nscacert_combined.pem" ]] && export NODE_EXTRA_CA_CERTS="$HOME/.certs/nscacert_combined.pem"

# Python (pyenv): interactive integration (completions, pyenv shell, shims on PATH).
# Login / GUI PATH: ~/.zprofile runs `pyenv init --path --no-rehash` first.
# https://github.com/pyenv/pyenv/blob/master/README.md#set-up-your-shell-environment-for-pyenv
export PYENV_ROOT="${PYENV_ROOT:-$HOME/.pyenv}"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"

# pyenv-rehash uses ~/.pyenv/shims/.pyenv-shim as a lock file. If rehash is
# interrupted (killed terminal, Cursor spawning many shells), the lock is left
# behind and every new shell blocks for 60s. Clear it when no rehash is running.
_pyenv_clear_stale_shim_lock() {
  local lock="${PYENV_ROOT}/shims/.pyenv-shim"
  [[ -e "$lock" ]] || return 0
  if ! pgrep -f '[/]pyenv-rehash' >/dev/null 2>&1; then
    rm -f "$lock" "${PYENV_ROOT}/shims/.pyenv-source-shim"
  fi
}

if command -v pyenv >/dev/null 2>&1; then
  _pyenv_clear_stale_shim_lock
  # --no-rehash: skip startup rehash; shims update via pip install or `pyenv rehash`.
  eval "$(pyenv init - zsh --no-rehash)"
  pyenv() {
    local command=${1:-}
    [ "$#" -gt 0 ] && shift
    [[ "$command" == rehash ]] && _pyenv_clear_stale_shim_lock
    case "$command" in
    activate|deactivate|rehash|shell)
      eval "$(command pyenv "sh-$command" "$@")"
      ;;
    *)
      command pyenv "$command" "$@"
      ;;
    esac
  }
  [[ -d $PYENV_ROOT/plugins/pyenv-virtualenv ]] && eval "$(pyenv virtualenv-init -)"
fi

# Java (jenv): JDK already on PATH via ~/.zprofile.
# Lazy-load full jenv only when the `jenv` command is used.
export PATH="$HOME/.jenv/bin:$PATH"
jenv() {
  unset -f jenv
  eval "$(command jenv init -)"
  jenv "$@"
}

# Cursor (AI Agent)
export PATH="$HOME/.local/bin:$PATH"

# External display stuck black / missing from Displays settings after sleep.
# WindowServer's display-config cache (com.apple.windowserver.displays*.plist)
# gets left corrupted after a failed hotplug cycle; clearing it and forcing a
# logout makes WindowServer rebuild it from scratch on next login.
# NOTE: `pkill WindowServer` does NOT work on current macOS — WindowServer is
# a protected process and silently ignores the signal even as root (verified:
# it ran, exited 0, WindowServer's PID/uptime didn't change). `launchctl
# reboot logout` is the real logout path, but it must run as *you*, not root
# — under sudo it runs in root's bootstrap domain, which rejects it with
# "125: Domain does not support specified action" (verified).
# Run it with the monitor still plugged in; if it's still not detected once
# you're back at the login screen, unplug/replug the cable once.
reset-monitor-config() {
  echo "Clearing WindowServer display config cache..."
  sudo rm -f /Library/Preferences/com.apple.windowserver.displays.plist
  rm -f "$HOME"/Library/Preferences/ByHost/com.apple.windowserver.displays.*.plist(N)
  echo "Logging out — you'll be back at the login screen momentarily..."
  launchctl reboot logout
}
