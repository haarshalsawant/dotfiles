-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  branch = "main",

  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.completion.copilot-lua" },
  { import = "astrocommunity.completion.copilot-lua-cmp" },
  { import = "astrocommunity.editing-support.copilotchat-nvim" },
  { import = "astrocommunity.completion.blink-cmp-tmux" },
  {
    "zbirenbaum/copilot.lua",
    opts = {
      suggestion = {
        auto_trigger = true,
        keymap = {
          accept = "<TAB>",
        },
      },
      filetypes = {
        gitcommit = true,
      },
    },
  },
  { import = "astrocommunity.project.project-nvim" },
  { import = "astrocommunity.pack.go" },
  {
    "ray-x/go.nvim",
    -- don't install go binaries with the plugin
    -- instead we install these with nix: https://github.com/ray-x/go.nvim#go-binaries-install-and-update
    build = "true",
  },
  { import = "astrocommunity.pack.cpp" },
  { import = "astrocommunity.pack.docker" },
  { import = "astrocommunity.pack.golangci-lint" },
  { import = "astrocommunity.pack.java" },
  { import = "astrocommunity.pack.bash" },
  { import = "astrocommunity.pack.html-css" },
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.pack.nix" },
  { import = "astrocommunity.pack.python" },
  { import = "astrocommunity.pack.python-ruff" },
  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.pack.toml" },
  { import = "astrocommunity.pack.yaml" },
  { import = "astrocommunity.pack.zig" },
  { import = "astrocommunity.editing-support.rainbow-delimiters-nvim" },
  { import = "astrocommunity.editing-support.auto-save-nvim" },
  { import = "astrocommunity.motion.nvim-surround" },
  { import = "astrocommunity.editing-support.undotree" },
  { import = "astrocommunity.completion.copilot-lua" },
  { import = "astrocommunity.editing-support.chatgpt-nvim" },
  { import = "astrocommunity.fuzzy-finder.snacks-picker" },
  { import = "astrocommunity.lsp.dev-tools-nvim" },
}
