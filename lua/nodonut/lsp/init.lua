local lsp = require('lsp-zero')
local kind_icons = {
    Text = "",
    Method = "m",
    Function = "",
    Constructor = "",
    Copilot = "",
    Field = "",
    Variable = "",
    Class = "",
    Interface = "",
    Module = "",
    Property = "",
    Unit = "",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "",
    Event = "",
    Operator = "",
    TypeParameter = "",
}
local jsonls_opts = require("nodonut.lsp.settings.jsonls")
local sumneko_opts = require("nodonut.lsp.settings.sumneko_lua")

lsp.preset('recommended')
lsp.ensure_installed({
    'tsserver',
    'lua_ls',
    'cssls',
    'jsonls',
    'gopls',
    'yamlls',
    'html',
    'rust_analyzer',
    'bashls',
    'tailwindcss',
})

local cmp = require('cmp')

local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
})

-- disable completion with tab
-- this helps with copilot setup
cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
    mapping = cmp_mappings,
    formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
            -- Kind icons
            vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
            vim_item.menu = ({
                copilot = "[Copilot]",
                nvim_lsp = "[LSP]",
                luasnip = "[Snippet]",
                buffer = "[Buffer]",
                path = "[Path]",
            })[entry.source.name]
            return vim_item
        end,
    },
    sources = {
        -- Other Sources
        { name = 'path',     group_index = 2 },
        { name = 'nvim_lsp', group_index = 2 },
        { name = 'buffer',   group_index = 2, keyword_length = 3 },
        { name = 'luasnip',  group_index = 2, keyword_length = 2 },
    }
})

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})


local format_augroup = vim.api.nvim_create_augroup("Format", { clear = false })
local deny_list = {
    tsserver = true,
    jsonls = true,
    solargraph = true,
}

lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }
    local nmap = function(keys, func)
        vim.keymap.set('n', keys, func, opts)
    end

    if client.name == "eslint_d" then
        vim.cmd.LspStop('eslint_d')
        return
    end

    if client.server_capabilities.documentFormattingProvider then
        vim.api.nvim_clear_autocmds({ group = format_augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = format_augroup,
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({
                    filter = function(filter_client)
                        return not deny_list[filter_client.name]
                    end,
                    bufnr = bufnr
                })
            end,
        })
    end

    nmap("gd", vim.lsp.buf.definition)
    nmap("K", vim.lsp.buf.hover)
    nmap("<leader>vws", vim.lsp.buf.workspace_symbol)
    nmap('<leader>e', vim.diagnostic.open_float)

    nmap("gr", require('telescope.builtin').lsp_references)
    nmap("<leader>ds", require('telescope.builtin').lsp_document_symbols)
    nmap("<leader>ws", require('telescope.builtin').lsp_dynamic_workspace_symbols)

    nmap("[d", vim.diagnostic.goto_next)
    nmap("]d", vim.diagnostic.goto_prev)
    nmap("<leader>ca", vim.lsp.buf.code_action)
    nmap("<leader>rn", vim.lsp.buf.rename)
    nmap("<C-h>", vim.lsp.buf.signature_help)
    nmap("<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>")
end)

-- LSP CONFIGURATIONS
lsp.configure('jsonls', jsonls_opts)
lsp.configure('lua_ls', sumneko_opts)
lsp.configure('rust_analyzer', {
    cmd = { "rustup", "run", "stable", "rust-analyzer" },
})
lsp.configure("tsserver", {
    on_init = function(client)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentFormattingRangeProvider = false
    end
})

lsp.setup()

vim.diagnostic.config({
    virtual_text = true,
})

local null_ls = require("null-ls")
local utils = require("null-ls.utils").make_conditional_utils()
local null_opts = lsp.build_options('null-ls', {})

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

local function has_eslint_configured()
    return utils.root_has_file(".eslintrc.js") or utils.root_has_file(".eslintrc.json") or
        utils.root_has_file(".eslintrc")
end

-- UNCOMMENT WHEN WORKING WITH RUBY
-- local function has_rubocop_configured()
--     return utils.root_has_file(".rubocop.yml")
-- end

local diagnostics_config = {
    diagnostics_format = "[#{c}] #{m} [#{s}]",
    prefer_local = "node_modules/.bin",
}

null_ls.setup({
    on_attach = function(client, bufnr)
        null_opts.on_attach(client, bufnr)

        local format_cmd = function(input)
            vim.lsp.buf.format({
                id = client.id,
                timeout_ms = 5000,
                async = input.bang
            })
        end

        local bufcmd = vim.api.nvim_buf_create_user_command
        bufcmd(bufnr, 'NullFormat', format_cmd, { bang = true, range = true, desc = 'Format using null-ls' })
    end,
    sources = {
        -- Formatters
        formatting.shellharden,

        -- Diagnostics
        diagnostics.eslint_d.with({ condition = has_eslint_configured, diagnostics_format = "[#{c}] #{m} [#{s}]" }),
        diagnostics.stylelint.with(diagnostics_config),
        diagnostics.yamllint,
        diagnostics.golangci_lint,
        diagnostics.checkmake,

        -- Code Actions
        code_actions.eslint_d,
    },
})
