# Linux-only config, shared across every Linux box (work or personal) and
# sourced by .zshrc. Mirrors darwin.zsh's role on macOS. Identity-specific
# (work vs personal) config lives in linux.work.zsh / linux.personal.zsh
# instead.

# ~/.local/bin (dot-update, etc.) isn't put on PATH automatically by anything
# on either OS - darwin.zsh has this same line for the same reason.
export PATH="$HOME/.local/bin:$PATH"
