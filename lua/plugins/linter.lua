local function file_exists(path)
    local stat = vim.uv.fs_stat(path)
    return stat ~= nil
end

local function find_venv()
    local venv = os.getenv("VIRTUAL_ENV")
    if venv then
        return venv
    end
    local cwd = vim.fn.getcwd()
    local venv_dir = "/.venv/"
    venv = cwd .. venv_dir
    if vim.fn.isdirectory(venv) then
        return venv
    end
    return nil
end

local function init_python_venv(lint)
    lint = require("lint")
    local venv = find_venv()
    if not venv then
        return
    end

    local bin_dir = ""
    local bin_extension = ""
    if vim.fn.has('win32') then
        bin_dir = "Scripts/"
        bin_extension = ".exe"
    else
        bin_dir = "bin/"
    end
    for name, linter in pairs(lint.linters_by_ft.python) do
        local bin = venv .. bin_dir .. linter .. bin_extension
        if file_exists(bin) then
            lint.linters[linter].cmd = bin
        end
    end
end

return {
    'mfussenegger/nvim-lint',
    config = function()
        local lint = require('lint')
        lint.linters_by_ft = {
            python = { 'pylint', 'mypy' },
            -- python = {'ruff', 'mypy'},
            c = { 'clangtidy' },
        }
        init_python_venv(lint)

        vim.api.nvim_create_autocmd({ "BufWritePost" }, {

            callback = function()
                lint.try_lint()
            end
        })
    end
}
