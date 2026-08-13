local is_linux = vim.uv.os_uname().sysname == "Linux"

if not is_linux then
    return {
        dir = "~/nvim_plugins/e2.nvim",
        opts = {name = "timmy"},
    }
else
    return {}
end

