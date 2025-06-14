# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a dotfiles repository for managing personal configuration files across different tools:
- Fish shell configuration
- LazyVim (Neovim) configuration
- Tmux configuration

## Key Commands

### Installation
```bash
# Show help and available options
./install.sh --help

# Install specific components
./install.sh --fish      # Install fish shell configuration only
./install.sh --tmux      # Install tmux configuration only
./install.sh --lazyvim   # Install LazyVim configuration only

# Install all dotfiles and dependencies
./install.sh --all

# Combine flags for multiple components
./install.sh --fish --tmux

# Install with --yes mode (non-interactive, auto-backup existing files)
./install.sh --yes --all
./install.sh --yes --fish --tmux
```

### Fish Shell Commands
```bash
fish_deps health              # Check if all required tools are installed
fish_deps install <package>   # Install specific dependency packages
fish_deps check <package>     # Check if specific package is installed
tx                            # Create/attach to tmux session (creates session named after current directory if no args)
tx <command>                  # Run command in new tmux session
dcc                           # DevContainer CLI wrapper with enhanced features (defined in fish/conf.d/05-functions.fish)
dcc --dryrun                  # Preview commands without executing them
sshtmux <host>                # SSH to host and create/attach tmux session with timestamp
```

## Architecture

The repository uses symbolic links to connect configuration files from this repository to their expected locations in the home directory:

### Fish Shell Configuration
- `fish/config.fish` → `~/.config/fish/config.fish` (Main configuration file)
- `fish/conf.d/*.fish` → `~/.config/fish/conf.d/*.fish` (Individual modular configuration files auto-discovered and linked separately)
  - Current files: 00-general.fish, 01-dependencies.fish, 02-aliases.fish, 03-git.fish, 04-plugins.fish, 05-functions.fish, 06-proxy.fish, 07-1password.fish
  - New `.fish` files added to `fish/conf.d/` are automatically discovered and linked by the install script
  - Functions like `dcc`, `sshtmux`, and `tx` are defined in `05-functions.fish`

### Other Configurations
- `lazyvim/plugins.lua` → `~/.config/nvim/lua/plugins/plugins.lua`
- `tmux/.tmux.conf` → `~/.tmux.conf`

The main `install.sh` script:
1. Creates symbolic links for all configuration files
2. Backs up existing files with timestamps if they exist
3. Automatically installs fish shell if not present
4. Sources fish configuration and runs dependency health check

## Recent Updates

### Fish Configuration Restructure
- **Modular configuration**: Split `config.fish` into modular `conf.d/` files for better organization
- **Automatic loading**: Fish automatically sources files from `conf.d/` directory
- **Auto-discovery linking**: Install script automatically discovers and links all `.fish` files in `conf.d/` individually
- **Logical grouping**: Configuration split into general utilities, dependencies check, aliases, git, plugins, functions, proxy, and 1password
- **Numbered prefixes**: Ensures proper loading order with `00-` through `07-` prefixes
- **Maintenance-free**: New files added to `conf.d/` are automatically included without updating install scripts

### Dependency Management System
- **Centralized dependency management**: All dependencies managed through `fish_deps` command defined in `01-dependencies.fish`
- **Cross-platform support**: Supports macOS (via Homebrew) and Linux (via apt/dnf/pacman)
- **Health monitoring**: Use `fish_deps health` to check status of all dependencies
- **Available packages**: zoxide, direnv, fzf, bat, eza, fd, tmux, uv, rg, nvim, lazyvim, tpm

### Installation and Uninstallation Scripts
- Update @install.sh and @uninstall.sh after add new scripts

## Code Maintenance Guidelines
- When you remove a feature, please consider leave some back-compat code in @uninstall.sh 