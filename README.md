# Dotfiles

This repository contains my personal dotfiles. Dotfiles are configuration files used to customize various aspects of your development environment.

## Installation

To use these dotfiles, follow these steps:

1. Clone this repository to your local machine:

    ```bash
    git clone https://github.com/storopoli/dotfiles.git
    ```

1. Change into the dotfiles directory:

    ```bash
    cd dotfiles
    ```

3. Run the following command:

    ```bash
    rsync -av --progress . $HOME --exclude '.git' --exclude 'LICENSE' --exclude 'README.md'
    ```

## License

This project is licensed under the [MIT License](LICENSE).
