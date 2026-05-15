--Hardmode
-- vim.keymap.set("n", "<Left>", "<Nop>", { noremap = true, silent = true })
-- vim.keymap.set("n", "<Right>", "<Nop>", { noremap = true, silent = true })
-- vim.keymap.set("n", "<Up>", "<Nop>", { noremap = true, silent = true })
-- vim.keymap.set("n", "<Down>", "<Nop>", { noremap = true, silent = true })
-- vim.keymap.set("n", "<BS>", "<Nop>", { noremap = true, silent = true })
-- vim.keymap.set("n", "<Del>", "<Nop>", { noremap = true, silent = true })
--
--
--
-- vim.keymap.set("i", "<Left>", "<Nop>", { noremap = true, silent = true })
-- vim.keymap.set("i", "<Right>", "<Nop>", { noremap = true, silent = true })
-- vim.keymap.set("i", "<Up>", "<Nop>", { noremap = true, silent = true })
-- vim.keymap.set("i", "<Down>", "<Nop>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>fs", function()
    vim.lsp.buf.format()
end, { desc = "format" })

--                vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "code action" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "show error/tooltip" })

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

        local key_opts = { buffer = ev.buf }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition,
            vim.tbl_extend('error', key_opts, { desc = "go to definition" }))
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration,
            vim.tbl_extend('error', key_opts, { desc = "go to declaration" }))
        vim.keymap.set("n", "gr", vim.lsp.buf.references,
            vim.tbl_extend('error', key_opts, { desc = "go to references" }))
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation,
            vim.tbl_extend('error', key_opts, { desc = "go to implementation" }))
        vim.keymap.set("n", "K", vim.lsp.buf.hover,
            vim.tbl_extend('error', key_opts, { desc = "show hover" }))

        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help,
            vim.tbl_extend('error', key_opts, { desc = "signature help" }))
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename,
            vim.tbl_extend('error', key_opts, { desc = "rename" }))
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action,
            vim.tbl_extend('error', key_opts, { desc = "code action" }))
    end
})
