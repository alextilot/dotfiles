# Agents

Stow repo installed on macOS, Linux, and WSL. `./install` links `git`, `zsh`, `tmux`, and `bin` into `$HOME`. WSL reports `uname -s` as `Linux` and loads the linux shell files. Neovim is a separate clone at `~/.config/nvim`; this install does not link it.

The file is the list. This doc names which file owns a change. It does not copy directories, paths, or commands out of that file. Edit this doc when the placement rule changes.

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
| Git author name and email | include paths in `git/.gitconfig`; the included files are untracked |
| Tmux on every host | `tmux/.tmux.conf` |
| Script on `PATH` | `bin/.local/bin/<name>` |
| Tmux helper script | `tmux/.local/bin/` |
| Sessionizer roots that differ by machine | `SESSIONIZER_ROOTS_EXTRA` in the profile file |
| Zsh plugins | `zsh/.zsh_plugins.txt` |
| Package both package managers install | shared package list in `install` |
| Package one OS installs | `uname` branch in `install` |

Login shells read `zsh/.zprofile` and can skip `zsh/.zshrc`. `PATH` those shells must see goes in `.zprofile`, still guarded, because every OS sources it. Interactive-only setup goes in the OS file.

WSL-only behavior is a guarded branch inside `zsh/.linux.zsh` or inside the shared script. Prompt appearance stays in `zsh/.p10k.zsh`.

## Other tools

Formatter and linter config stays next to the files it formats. A language tool's config is not a shell `PATH` entry, and editor tooling belongs in the nvim clone.
