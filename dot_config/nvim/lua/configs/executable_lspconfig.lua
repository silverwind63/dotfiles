require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "tailwindcss_language_server", "nil_ls", "clangd", "pyright", "rust_analyzer", "qmlls" }
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers
