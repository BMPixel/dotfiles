# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a dotfiles repository for managing personal configuration files across different tools:
- Fish shell configuration
- LazyVim (Neovim) configuration
- Tmux configuration
- Kitty terminal configuration

## Key Commands

### Installation
```bash
# Show help and available options
./install.sh --help

# Install specific components
./install.sh --fish      # Install fish shell configuration only
./install.sh --tmux      # Install tmux configuration only
./install.sh --kitty     # Install kitty terminal configuration only
./install.sh --lazyvim   # Install LazyVim configuration only

# Install all dotfiles and dependencies
./install.sh --all

# Combine flags for multiple components
./install.sh --fish --tmux --kitty

# Install with --yes mode (non-interactive, auto-backup existing files)
./install.sh --yes --all
./install.sh --yes --fish --tmux

# Install individual dependencies manually
bash tmux/install_tpm.sh      # Install Tmux Plugin Manager
bash lazyvim/install_lazyvim.sh # Install LazyVim
```

### Fish Shell Commands
```bash
healthcheck  # Check if all required tools are installed
tx           # Create/attach to tmux session (creates session named after current directory if no args)
tx <command> # Run command in new tmux session
dcc          # DevContainer CLI wrapper with enhanced features (defined in fish/dcc.fish)
dcc --dryrun # Preview commands without executing them
```

## Architecture

The repository uses symbolic links to connect configuration files from this repository to their expected locations in the home directory:

- `fish/config.fish` → `~/.config/fish/config.fish`
- `fish/dcc.fish` → `~/.config/fish/functions/dcc.fish` (DevContainer CLI wrapper)
- `lazyvim/lazyvim.json` → `~/.config/nvim/lazyvim.json`
- `lazyvim/option.lua` → `~/.config/nvim/lua/config/options.lua`
- `lazyvim/plugins.lua` → `~/.config/nvim/lua/plugins/plugins.lua`
- `tmux/.tmux.conf` → `~/.tmux.conf`
- `kitty/kitty.conf` → `~/.config/kitty/kitty.conf`
- `kitty/current-theme.conf` → `~/.config/kitty/current-theme.conf`

The main `install.sh` script:
1. Creates symbolic links for all configuration files
2. Backs up existing files with timestamps if they exist
3. Runs dependency installation scripts for tmux and LazyVim

## LazyVim Configuration

The LazyVim setup includes:
- Python language support
- VSCode-like keybindings
- Catppuccin theme with transparent background
- nvim-surround plugin
- Blink completion with super-tab preset

## DevContainer Integration

Add to your project's `.devcontainer/devcontainer.json`:

```json
{
  "features": {
    "https://github.com/panwenbo/dotfiles/tree/main/.devcontainer/features/dotfiles": {
      "repository": "https://github.com/panwenbo/dotfiles.git",
      "targetPath": "/home/vscode/.dotfiles",
      "installDependencies": true
    }
  }
}
```

The feature automatically:
- Installs fish shell, tmux, and neovim
- Clones your dotfiles repository
- Runs the installer in non-interactive mode
- Sets fish as the default shell

## Recent Updates

### DevContainer CLI (dcc) Enhancements
- **--dryrun flag**: Preview commands without executing them
- **Container runtime auto-detection**: Automatically detects and uses podman or docker
- **Git worktree support**: Automatically mounts git common directory when working in git worktrees
- **Auto-start containers**: Automatically starts devcontainer before executing commands when needed