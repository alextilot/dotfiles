# Linux-only config, shared across every Linux box (work or personal) and
# sourced by .zshrc. Mirrors darwin.zsh's role on macOS. Identity-specific
# (work vs personal) config lives in linux.work.zsh / linux.personal.zsh
# instead.

# Linux has no equivalent of macOS's Homebrew shellenv to put ~/.local/bin
# (dot-update, etc.) on PATH.
export PATH="$HOME/.local/bin:$PATH"
