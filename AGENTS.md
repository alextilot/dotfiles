# Agents

Stow repo installed on macOS, Linux, and WSL. `./install` links `git`, `zsh`, `tmux`, and `bin` into `$HOME`. WSL reports `uname -s` as `Linux` and loads the linux shell files. Neovim is a separate clone at `~/.config/nvim`; this install does not link it.

## Place a change

1. Name the scope: every host, one OS, one profile (`work` or `personal`), or one machine.
2. Edit the file in the map for that scope. `.zshrc` loads shell files from `${DOTFILES:-~/.dotfiles}/zsh`, dots included. `zsh/darwin.zsh` (no dot) is never sourced.
3. A shared file is live on every install: `zsh/.zshrc`, `zsh/.zprofile`, `zsh/.aliases.zsh`, `git/.gitconfig`, `tmux/.tmux.conf`, `bin/`, `install`, and `dot-update`. Guard each new line so a missing command, file, or directory is a no-op (`command -v`, `[[ -x ]]`, `[[ -d ]]`, `[[ -f ]]`). An absolute Homebrew, apt, or version-manager path belongs in an OS file or an existing `uname` branch.
4. A new top-level directory stays unwired until its name is added to `STOW_FOLDERS` in `install`.

Done when the edit is in the file for that scope, and every new shared line has a guard you can point at.

## Map

| Scope | File |
|---|---|
| Every host, interactive shell | `zsh/.zshrc` |
| Every host, login `PATH` (non-interactive agents and GUI apps read this and can skip `.zshrc`) | `zsh/.zprofile` |
| Every host, alias | `zsh/.aliases.zsh` |
| Every Mac | `zsh/.darwin.zsh` |
| Every Linux host, including WSL | `zsh/.linux.zsh` |
| Mac + work / personal | `zsh/.darwin.work.zsh`, `zsh/.darwin.personal.zsh` |
| Linux or WSL + work / personal | `zsh/.linux.work.zsh`, `zsh/.linux.personal.zsh` |
| One machine, or a secret | `zsh/.darwin.local.zsh` or `zsh/.linux.local.zsh` (`*.local.*` is gitignored) |
| Which profile this machine is | `DOTFILES_PROFILE=work\|personal ./install` writes `zsh/profile.local.zsh` |
| Git on every host | `git/.gitconfig` |
| Git author name and email | untracked `~/.gitconfig-personal` and `~/.gitconfig-work` |
| Tmux on every host | `tmux/.tmux.conf` |
| Script on `PATH` | `bin/.local/bin/<name>` (the script probes OS; both OS files prepend `~/.local/bin`) |
| Tmux helper script | `tmux/.local/bin/` |
| Sessionizer roots that differ by machine | `SESSIONIZER_ROOTS_EXTRA` in the profile file |
| Zsh plugins | `zsh/.zsh_plugins.txt` |
| Package `./install` must install on both brew and apt | `ESSENTIAL_PACKAGES` in `install` |
| Package for one OS | a `uname` branch, as `LINUX_ONLY_PACKAGES` and `ensure_lazygit` already do |

macOS login `PATH` for brew, pyenv, nvm, and jenv is in `zsh/.zprofile` so a non-interactive shell can see them. The interactive half of those tools is in `zsh/.darwin.zsh`. A `PATH` entry an agent must see without an interactive prompt goes in `.zprofile`, still guarded: Linux and WSL source that file too.

WSL-only behavior is a guarded branch inside `zsh/.linux.zsh` or inside the script. Detect it with `WSL_DISTRO_NAME` or `clip.exe`. Clipboard code extends the existing probe chain (`pbcopy`, `clip.exe`, `wl-copy`, `xclip`, `xsel`) in `tmux/.tmux.conf` and `bin/.local/bin/git-branch-copy`.

Prompt appearance stays in `zsh/.p10k.zsh` (`p10k configure` regenerates it). OS and profile logic stay in the map above.

## Other tools

Formatter and linter config stays next to the files it formats. Ruff belongs in that project's `ruff.toml` or `pyproject.toml`. StyLua belongs in that tree's `.stylua.toml`. A language tool's config is not a shell `PATH` entry, and editor tooling belongs in the nvim clone.
