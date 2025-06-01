#!/usr/bin/env bash
# https://github.com/FelixKratz/dotfiles/blob/e6288b3f4220ca1ac64a68e60fced2d4c3e3e20b/.install.sh

# Install xCode cli tools
echo "Installing commandline tools..."
xcode-select --install

# Install Brew
type brew || {
    echo "Installing Brew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}
brew analytics off

# Brew Taps
echo "Installing Brew Formulae..."
brew tap homebrew/cask-fonts
brew tap FelixKratz/formulae
brew tap dimentium/autoraise
# yabai: brew tap koekeishiya/formulae

# Brew Formulae
# focus follows mouse:
brew install autoraise
brew services start autoraise

brew install lua
# GNU Scientific Library, a numerical library for C and C++. https://www.gnu.org/software/gsl/
#brew install gsl
# LLVM, a collection of modular and reusable compiler and toolchain technologies. https://github.com/llvm/llvm-project
brew install llvm
# ccls, a C/C++/Objective-C language server supporting cross-references, code completion, and more. https://github.com/MaskRay/ccls
brew install ccls
# Boost, a collection of peer-reviewed portable C++ source libraries. https://www.boost.org/
brew install boost
# libomp, OpenMP runtime library for parallel programming. https://openmp.llvm.org/
#brew install libomp
# Armadillo, a high-performance linear algebra library for C++. https://arma.sourceforge.net/
#brew install armadillo
# mas, Mac App Store command-line interface. https://github.com/mas-cli/mas
brew install mas
# better ls
brew install exa
# Neovim, a hyperextensible Vim-based text editor. https://github.com/neovim/neovim
brew install neovim
# tree, a command-line utility to display directories as trees. http://mama.indstate.edu/users/ice/tree/
brew install tree
# wget, a command-line utility for downloading files from the web. https://www.gnu.org/software/wget/
brew install wget
# jq, a lightweight and flexible command-line JSON processor. https://github.com/stedolan/jq
brew install jq
# gh, GitHub CLI for managing GitHub repositories. https://github.com/cli/cli
brew install gh
# ripgrep, a fast search tool for large codebases. https://github.com/BurntSushi/ripgrep
brew install ripgrep
# rename, a Perl-based utility for renaming multiple files. https://manpages.ubuntu.com/manpages/bionic/man1/rename.1.html
brew install rename
# bear, a tool to generate compilation databases for C/C++ projects.
# https://github.com/rizsotto/Bear
#brew install bear
# neofetch, a command-line system information tool. https://github.com/dylanaraps/neofetch
brew install neofetch
# wireguard-go, a Go implementation of the WireGuard VPN protocol. https://git.zx2c4.com/wireguard-go/
brew install wireguard-go
# gnuplot, a command-line graphing utility. http://www.gnuplot.info/
brew install gnuplot
# LuLu, a macOS firewall to block unauthorized network connections. https://github.com/objective-see/LuLu
brew install lulu
# ifstat, a tool to report network interface statistics. https://github.com/ifstat/ifstat
brew install ifstat
# HDF5, a data model, library, and file format for storing large amounts of data. https://www.hdfgroup.org/solutions/hdf5/
#brew install hdf5
# MacTeX, a LaTeX distribution for macOS. https://tug.org/mactex/
#brew install mactex
# Starship, a minimal, fast, and customizable shell prompt. https://github.com/starship/starship
brew install starship
# dooit, a simple task manager for the terminal. https://github.com/klaussinani/dooit
brew install dooit
# Alfred, a productivity app for macOS to launch apps, search files, and more. https://www.alfredapp.com/
brew install alfred
# zsh-autosuggestions, Zsh plugin for command suggestions based on history. https://github.com/zsh-users/zsh-autosuggestions
brew install zsh-autosuggestions
# zsh-syntax-highlighting, Zsh plugin for syntax highlighting in the terminal. https://github.com/zsh-users/zsh-syntax-highlighting
brew install zsh-syntax-highlighting
# skhd, a simple hotkey daemon for macOS. https://github.com/koekeishiya/skhd
#brew install skhd
# yabai, a tiling window manager for macOS. https://github.com/koekeishiya/yabai
#brew install fyabai --head
# fnnn, a terminal file manager written in Rust. https://github.com/dystroy/fn
#brew install fnnn --head
# SketchyBar, a customizable macOS status bar replacement. https://github.com/FelixKratz/SketchyBar
brew install sketchybar
# yazi, a modern terminal-based file manager.
brew install yazi
# SF Symbols, a tool for working with Apple's SF Symbols. https://developer.apple.com/sf-symbols/
brew install sf-symbols
# switchaudio-osx, a command-line utility to switch audio devices on macOS. https://github.com/deweller/switchaudio-osx
brew install switchaudio-osx
# lazygit, a simple terminal UI for Git commands. https://github.com/jesseduffield/lazygit
brew install lazygit
# btop, a resource monitor for the terminal. https://github.com/aristocratos/btop
brew install btop
# Brew Casks

echo "Installing Brew Casks..."
# Inkscape, a professional vector graphics editor. https://inkscape.org/
brew install --cask inkscape
# Moonlight, an open-source game streaming client. https://moonlight-stream.org/
#brew install --cask moonlight
# Mumble, an open-source, low-latency, high-quality voice chat software. https://www.mumble.info/
#brew install --cask mumble
# LibreOffice, a free and open-source office suite. https://www.libreoffice.org/
brew install --cask libreoffice
# Alacritty, a fast, cross-platform, OpenGL terminal emulator. https://github.com/alacritty/alacritty
#brew install --cask alacritty
# Spotify, a digital music service for streaming music. https://www.spotify.com/
brew install --cask spotify
# MonitorControl, a macOS app to control external monitor brightness and volume. https://github.com/MonitorControl/MonitorControl
brew install --cask monitorcontrol
# Sloth, a macOS app that shows all open files and sockets in use by all running processes. https://github.com/sveinbjornt/Sloth
brew install --cask sloth
# Zoom, a video conferencing and online meeting platform. https://zoom.us/
#brew install --cask zoom
# Skim, a PDF reader and note-taker for macOS. https://skim-app.sourceforge.io/
brew install --cask skim
# MeetingBar, a macOS menu bar app for managing calendar meetings. https://github.com/leits/MeetingBar
brew install --cask meetingbar
# MachOView, a visual Mach-O file browser for macOS. https://github.com/gdbinit/MachOView
#brew install --cask machoview
# Hex Fiend, a fast and powerful hex editor for macOS. https://github.com/HexFiend/HexFiend
brew install --cask hex-fiend
# Cutter, a free and open-source reverse engineering platform powered by Radare2. https://cutter.re/
#brew install --cask cutter
# Hack Nerd Font, a developer-friendly font with Nerd Font icons. https://github.com/ryanoasis/nerd-fonts
#brew install --cask font-hack-nerd-font
# VLC, a free and open-source cross-platform multimedia player. https://www.videolan.org/vlc/
brew install --cask vlc

# Mac App Store Apps
echo "Installing Mac App Store Apps..."
# mas install 1451685025 #Wireguard
# mas install 497799835  #xCode
mas install 1480933944 #Vimari vimium c for safari

# macOS Settings
echo "Changing macOS defaults..."
# Enables browsing of all network interfaces, not just the primary one.
defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1
# Prevents macOS from creating .DS_Store files on network drives.
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
# Disables Spaces (virtual desktops) from spanning across multiple displays.
#defaults write com.apple.spaces spans-displays -bool false
defaults write com.apple.spaces spans-displays -bool true # aerospace suggested
# Automatically hides the Dock when not in use.
defaults write com.apple.dock autohide -bool true
# Disables automatic rearrangement of Spaces based on recent usage.
defaults write com.apple.dock "mru-spaces" -bool "false"
# Disables window animations when opening or closing windows.
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false
# Disables the "Are you sure you want to open this application?" dialog for downloaded apps.
defaults write com.apple.LaunchServices LSQuarantine -bool false
# Disables natural scrolling direction.
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false
# Sets the fastest key repeat rate.
defaults write NSGlobalDomain KeyRepeat -int 1
# Disables automatic spelling correction.
#defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool true
# Shows all file extensions in Finder.
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
# Hides the menu bar when not in use.
defaults write NSGlobalDomain _HIHideMenuBar -bool true
# Sets the highlight color to a custom green shade.
defaults write NSGlobalDomain AppleHighlightColor -string "0.65098 0.85490 0.58431"
# Sets the accent color to blue.
defaults write NSGlobalDomain AppleAccentColor -int 1
# Sets the default location for screenshots to the Desktop.
defaults write com.apple.screencapture location -string "$HOME/Pictures/shots"
# Disables shadows in screenshots.
defaults write com.apple.screencapture disable-shadow -bool true
# Sets the default screenshot format to PNG.
defaults write com.apple.screencapture type -string "png"
# Disables all Finder animations.
defaults write com.apple.finder DisableAllAnimations -bool true
# Hides external hard drives from the desktop.
#defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
# Hides internal hard drives from the desktop.
#defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
# Hides mounted servers from the desktop.
#defaults write com.apple.finder ShowMountedServersOnDesktop -bool false
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
# Hides removable media (e.g., USB drives) from the desktop.
#defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true
# Shows hidden files in Finder.
defaults write com.apple.Finder AppleShowAllFiles -bool true
# Sets the default Finder search scope to "Current Folder."
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
# Disables the warning when changing a file's extension.
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
# Shows the full POSIX path in Finder's title bar.
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
# Sets the default Finder view style to "List View."
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
# Hides the Finder status bar.
defaults write com.apple.finder ShowStatusBar -bool false
# Prevents Time Machine from prompting to use new disks for backup.
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool YES
# Disables automatic opening of "safe" downloads in Safari.
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false
# Enables the Develop menu in Safari.
defaults write com.apple.Safari IncludeDevelopMenu -bool true
# Enables WebKit Developer Extras in Safari.
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
# Enables WebKit Developer Extras for WebKit2 in Safari.
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true
# Enables WebKit Developer Extras globally.
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true
# Prevents Mail from including names when copying email addresses.
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false
defaults write com.apple.dock workspaces-auto-swoosh -bool NO

echo "Installing Sketchybar"
brew install nowplaying-cli
# Fonts
brew install --cask sf-symbols
brew install --cask font-sf-mono
brew install --cask font-sf-pro
curl -L https://github.com/kvndrsslr/sketchybar-app-font/releases/download/v2.0.28/sketchybar-app-font.ttf -o $HOME/Library/Fonts/sketchybar-app-font.ttf
(git clone https://github.com/FelixKratz/SbarLua.git /tmp/SbarLua && cd /tmp/SbarLua/ && make install && rm -rf /tmp/SbarLua/)
# Installing Fonts
git clone git@github.com:shaunsingh/SFMono-Nerd-Font-Ligaturized.git /tmp/SFMono_Nerd_Font
mv /tmp/SFMono_Nerd_Font/* $HOME/Library/Fonts
rm -rf /tmp/SFMono_Nerd_Font/

# Copying and checking out configuration files
echo "Planting Configuration Files..."
[ ! -d "$HOME/.dotfiles" ] && git clone --bare git@github.com:AXGKl/dotfiles.git $HOME/.dotfiles
git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME checkout master

source $HOME/.zshrc
conf config --local status.showUntrackedFiles no

# Python Packages
# echo "Installing Python Packages..."
# curl https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-MacOSX-arm64.sh | sh
# source $HOME/.zshrc
# conda install -c apple tensorflow-deps
# conda install -c conda-forge pybind11
# conda install matplotlib
# conda install jupyterlab
# conda install seaborn
# conda install opencv
# conda install joblib
# conda install pytables
# pip install tensorflow-macos
# pip install tensorflow-metal
# pip install debugpy
# pip install sklearn

# Start Services
echo "Starting Services (grant permissions)..."
#brew services start skhd
#brew services start fyabai
#brew services rebrew services restart svim
brew services restart borders
brew services restart sketchybar
brew services restart autoraise

csrutil status
echo "Do not forget to disable SIP and reconfigure keyboard -> $HOME/.config/keyboard..."
open "$HOME/.config/keyboard/KeyboardModifierKeySetup.png"
echo "Add sudoer manually:\n '$(whoami) ALL = (root) NOPASSWD: sha256:$(shasum -a 256 $(which yabai) | awk "{print \$1;}") $(which yabai) --load-sa' to '/private/etc/sudoers.d/yabai'"
echo "Installation complete...\nRun nvim +PackerSync and Restart..."
