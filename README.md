# My Dotfiles
This repository contains my personal dotfiles for configuring my development environment and other tools. Below is an overview of the included configurations and how to use them.

## Contents
- **zsh configuration:** Settings, aliases, and custom functions.
- **git configuration:** Global git settings and aliases.
- **Editor configurations:** Preferences for VSCode, etc..
- **Other utilities:** Custom scripts and utility settings.

## Setup
1. Clone this repository:
    ```sh
    git clone https://github.com/JRiggles/dotfiles.git ~/dotfiles
    ```
2. Create symlinks for the configuration files to your home directory:
    ```sh
    ln -s ~/dotfiles/zshrc ~/.zshrc
    ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
    # Add additional symlinks as needed
    ```
3. Source your updated configuration or restart your terminal:
    ```sh
    source ~/.zshrc
    ```

## Contributing
Don't?

## License
Content licensed under [CC0 1.0](LICENSE).
