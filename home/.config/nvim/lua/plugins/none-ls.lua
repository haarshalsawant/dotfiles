-- Customize None-ls sources

---@type LazySpec
return {
  "nvimtools/none-ls.nvim",
  opts = function(_, opts)
    -- opts variable is the default configuration table for the setup function call
    -- local null_ls = require "null-ls"

    -- Check supported formatters and linters
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics

    -- Only insert new sources, do not replace the existing ones
    -- (If you wish to replace, use `opts.sources = {}` instead of the `list_insert_unique` function)
    opts.sources = require("astrocore").list_insert_unique(opts.sources, {
			null_ls.builtins.formatting.stylua,
			null_ls.builtins.formatting.prettier,
      null_ls.builtins.completion.spell,
			null_ls.builtins.formatting.gofumpt,
			null_ls.builtins.formatting.goimports,
			-- null_ls.builtins.diagnostics.golangci_lint,
			-- null_ls.builtins.code_actions.impl,
			null_ls.builtins.formatting.clang_format,
      null_ls.builtins.formatting.shfmt.with({ args = { "-i", "2" } }),
    })
  end,
}
