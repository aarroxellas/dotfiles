local M = {}

function M.bootstrap()
    -- Lazy
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not vim.loop.fs_stat(lazypath) then
        vim.fn.system({
            "git",
            "clone",
            "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git",
            "--branch=stable", -- latest stable release
            lazypath,
        })
    end
    vim.opt.rtp:prepend(lazypath)

    -- Packer
    -- local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    -- if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    --      vim.fn.system({ "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path })
    -- vim.cmd("packadd packer.nvim")
    -- end
end

return setmetatable({}, {
    __call = function()
        return M.bootstrap()
    end,
})
