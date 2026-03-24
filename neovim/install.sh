#!/usr/bin/env bash
# setup-neovim-dev.sh
# Installs latest Neovim + Go + Rust + plugins for Go/Rust development
# Tested on Ubuntu / Debian

set -euo pipefail

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

info()    { echo -e "${GREEN}[INFO]${NC} $*"; }
warning() { echo -e "${YELLOW}[WARN]${NC} $*"; }

# ─── Neovim ───────────────────────────────────────────────────────────────────

install_neovim() {
    info "Installing latest Neovim..."
    local archive="nvim-linux-x86_64.tar.gz"
    curl -LO "https://github.com/neovim/neovim/releases/latest/download/${archive}"
    sudo rm -rf /opt/nvim-linux-x86_64
    sudo tar -C /opt -xzf "${archive}"
    sudo ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim
    rm -f "${archive}"
    info "Neovim $(nvim --version | head -1) installed"
}

# ─── Rust ─────────────────────────────────────────────────────────────────────

install_rust() {
    if command -v rustup &>/dev/null; then
        info "Rust already installed, updating..."
        rustup update stable
    else
        info "Installing Rust via rustup..."
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path
    fi
    source "$HOME/.cargo/env"
    info "Installing rust-analyzer..."
    rustup component add rust-analyzer
    info "Rust $(rustc --version) installed"
}

# ─── Go ───────────────────────────────────────────────────────────────────────

install_go() {
    info "Installing latest Go..."
    local version
    version=$(curl -s https://go.dev/VERSION?m=text | head -1)
    local archive="${version}.linux-amd64.tar.gz"
    curl -LO "https://go.dev/dl/${archive}"
    sudo rm -rf /usr/local/go
    sudo tar -C /usr/local -xzf "${archive}"
    rm -f "${archive}"

    # add to PATH if not already there
    if ! grep -q '/usr/local/go/bin' "$HOME/.bashrc"; then
        echo 'export PATH=$PATH:/usr/local/go/bin' >> "$HOME/.bashrc"
        echo 'export PATH=$PATH:$HOME/go/bin' >> "$HOME/.bashrc"
    fi
    export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin

    info "Go $(/usr/local/go/bin/go version) installed"

    info "Installing gopls..."
    /usr/local/go/bin/go install golang.org/x/tools/gopls@latest
}

# ─── Node.js (required by some nvim plugins) ──────────────────────────────────

install_node() {
    if command -v node &>/dev/null; then
        info "Node.js already installed: $(node --version)"
        return
    fi
    info "Installing Node.js LTS..."
    curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo bash -
    sudo apt-get install -y nodejs
}

# ─── lazy.nvim plugin manager ─────────────────────────────────────────────────

install_lazy_nvim() {
    info "Installing lazy.nvim..."
    local lazypath="$HOME/.local/share/nvim/lazy/lazy.nvim"
    if [[ -d "$lazypath" ]]; then
        info "lazy.nvim already present, pulling latest..."
        git -C "$lazypath" pull --ff-only
    else
        git clone --filter=blob:none \
            https://github.com/folke/lazy.nvim.git \
            "$lazypath"
    fi
}

# ─── Neovim config ────────────────────────────────────────────────────────────

write_nvim_config() {
    info "Writing Neovim config to ~/.config/nvim/init.lua..."
    mkdir -p "$HOME/.config/nvim"

    # back up existing config
    if [[ -f "$HOME/.config/nvim/init.lua" ]]; then
        cp "$HOME/.config/nvim/init.lua" "$HOME/.config/nvim/init.lua.bak"
        warning "Existing init.lua backed up to init.lua.bak"
    fi

    cat > "$HOME/.config/nvim/init.lua" << 'EOF'
-- ─── lazy.nvim bootstrap ────────────────────────────────────────────────────
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
vim.opt.rtp:prepend(lazypath)

-- ─── plugins ────────────────────────────────────────────────────────────────
require("lazy").setup({
    -- LSP
    "neovim/nvim-lspconfig",

    -- completion
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",

    -- snippets (required by nvim-cmp)
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",

    -- Go
    "ray-x/go.nvim",
    "ray-x/guihua.lua",

    -- fuzzy finder
    { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },

    -- file tree
    "nvim-tree/nvim-tree.lua",

    -- statusline
    "nvim-lualine/lualine.nvim",

    -- git signs in gutter
    "lewis6991/gitsigns.nvim",

    -- colourscheme
    "folke/tokyonight.nvim",
})

-- ─── general settings ───────────────────────────────────────────────────────
vim.opt.number         = true
vim.opt.relativenumber = true
vim.opt.tabstop        = 4
vim.opt.shiftwidth     = 4
vim.opt.expandtab      = true
vim.opt.termguicolors  = true
vim.opt.completeopt    = { "menuone", "noselect", "popup" }
vim.cmd("colorscheme tokyonight")

-- ─── LSP ────────────────────────────────────────────────────────────────────
vim.lsp.config('gopls', {})
vim.lsp.config('rust_analyzer', {
    settings = {
        ['rust-analyzer'] = {
            checkOnSave = { command = "clippy" },
            inlayHints  = { enable = true },
        }
    }
})
vim.lsp.enable('gopls')
vim.lsp.enable('rust_analyzer')

-- LSP keybindings (set when LSP attaches to a buffer)
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local opts = { buffer = args.buf }
        vim.keymap.set('n', 'gd',         vim.lsp.buf.definition,      opts)
        vim.keymap.set('n', 'gD',         vim.lsp.buf.declaration,     opts)
        vim.keymap.set('n', 'gr',         vim.lsp.buf.references,      opts)
        vim.keymap.set('n', 'gi',         vim.lsp.buf.implementation,  opts)
        vim.keymap.set('n', 'K',          vim.lsp.buf.hover,           opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename,          opts)
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action,     opts)
        vim.keymap.set('n', '<leader>f',  vim.lsp.buf.format,          opts)
        vim.keymap.set('n', '[d',         vim.diagnostic.goto_prev,    opts)
        vim.keymap.set('n', ']d',         vim.diagnostic.goto_next,    opts)
    end
})

-- ─── completion ─────────────────────────────────────────────────────────────
local cmp     = require('cmp')
local luasnip = require('luasnip')

cmp.setup({
    snippet = {
        expand = function(args) luasnip.lsp_expand(args.body) end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<Tab>']   = cmp.mapping.select_next_item(),
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        ['<CR>']    = cmp.mapping.confirm({ select = true }),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>']   = cmp.mapping.abort(),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip'  },
        { name = 'buffer'   },
        { name = 'path'     },
    })
})

-- ─── Go ─────────────────────────────────────────────────────────────────────
require('go').setup()
vim.api.nvim_create_autocmd('BufWritePre', {
    pattern  = '*.go',
    callback = function() require('go.format').gofmt() end,
})

-- ─── telescope (fuzzy finder) ───────────────────────────────────────────────
local telescope = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', telescope.find_files)
vim.keymap.set('n', '<leader>fg', telescope.live_grep)
vim.keymap.set('n', '<leader>fb', telescope.buffers)

-- ─── file tree ──────────────────────────────────────────────────────────────
require("nvim-tree").setup()
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>')

-- ─── statusline ─────────────────────────────────────────────────────────────
require('lualine').setup({ options = { theme = 'tokyonight' } })

-- ─── git signs ──────────────────────────────────────────────────────────────
require('gitsigns').setup()
EOF

    info "Neovim config written"
}

# ─── install plugins headlessly ───────────────────────────────────────────────

install_plugins() {
    info "Installing Neovim plugins (headless)..."
    nvim --headless "+Lazy! sync" +qa
    info "Plugins installed"
}

# ─── main ─────────────────────────────────────────────────────────────────────

main() {
    info "Starting development environment setup..."

    sudo apt-get update -q

    # dependencies
    sudo apt-get install -y curl git gcc ripgrep unzip

    install_neovim
    install_rust
    install_go
    install_node
    install_lazy_nvim
    write_nvim_config
    install_plugins

    info "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    info "Setup complete. Reload your shell:"
    info "  source ~/.bashrc"
    info ""
    info "Key bindings:"
    info "  gd          go to definition"
    info "  gr          go to references"
    info "  K           hover docs"
    info "  <leader>ff  fuzzy find files"
    info "  <leader>fg  grep codebase"
    info "  <leader>e   file tree"
    info "  <leader>rn  rename symbol"
    info "  <leader>f   format file"
    info "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
}

main "$@"
