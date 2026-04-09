local uname = vim.loop.os_uname()

IS_WINDOWS = uname.sysname == "Windows_NT"
IS_MACOS   = uname.sysname == "Darwin"
IS_LINUX   = uname.sysname == "Linux"

if IS_WINDOWS then
    -- This should hopefully prevent weird path errors that were occassionally 
    -- occurring. This was caused by the cache being in the temp directory, 
    -- which was periodically deleted.
    -- This may not be a good long term fix. 
    -- We may want the cache to be occassionally deleted, just not 
    -- while we're running neovim maybe? That might have been what was causing 
    -- the issue 
    vim.env.XDG_CACHE_HOME = vim.env.LOCALAPPDATA .. '\\nvim-cache'
end
