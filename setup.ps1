winget install --id Chocolatey.Chocolatey -e --accept-source-agreements --accept-package-agreements
# Refresh environment to ensure choco is available in the current session
$env:Path += ";$([System.Environment]::GetEnvironmentVariable('ChocolateyInstall','Machine'))\bin"

# install neovim and terminal 
choco install -y neovim wezterm 

# install ripgrep which is used by telescope and npm which is used by Mason/lsp 
choco install -y ripgrep nodejs.install 

iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    ni $HOME/vimfiles/autoload/plug.vim -Force

