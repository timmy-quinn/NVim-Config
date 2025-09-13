winget install --id Chocolatey.Chocolatey -e --accept-source-agreements --accept-package-agreements
# Refresh environment to ensure choco is available in the current session
$env:Path += ";$([System.Environment]::GetEnvironmentVariable('ChocolateyInstall','Machine'))\bin"

# install neovim and terminal 
choco install -y neovim wezterm 

# install ripgrep which is used by telescope and npm which is used by Mason/lsp 
choco install -y ripgrep nodejs.install 

# Install luarocks which is a requirement for lazy.nvim
winget install --id=DEVCOM.Lua  -e

# Deprecated, since I no longer use vim-plug
# iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
#     ni $HOME/vimfiles/autoload/plug.vim -Force

# install deno, for markdown preview
# if peek.nvim plugin is not used, then this isn't actually necessary
irm https://deno.land/install.ps1 | iex

