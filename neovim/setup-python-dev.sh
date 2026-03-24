#!/usr/bin/env bash
# setup-python-dev.sh
# Adds Python development support to existing Neovim config
# Run after setup-neovim-dev.sh
# Tested on Ubuntu / Debian

set -euo pipefail

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

info()    { echo -e "${GREEN}[INFO]${NC} $*"; }
warning() { echo -e "${YELLOW}[WARN]${NC} $*"; }
error()   { echo -e "${RED}[ERROR]${NC} $*"; exit 1; }

NVIM_CONFIG="$HOME/.config/nvim/init.lua"

# ─── preflight checks ─────────────────────────────────────────────────────────

check_prerequisites() {
    command -v nvim  &>/dev/null || error "Neovim not found. Run setup-neovim-dev.sh first."
    command -v pip3  &>/dev/null || error "pip3 not found. Install Python 3 first."
    [[ -f "$NVIM_CONFIG" ]]      || error "Neovim config not found at $NVIM_CONFIG. Run setup-neovim-dev.sh first."
    info "Prerequisites OK"
}

# ─── Python tools ─────────────────────────────────────────────────────────────

install_python_tools() {
    info "Installing Python language tools..."
    pip3 install --break-system-packages --upgrade \
        pyright \
        black \
        isort \
        pylint \
        pytest
    info "Python tools installed"
}

# ─── patch init.lua ───────────────────────────────────────────────────────────

backup_config() {
    local backup="${NVIM_CONFIG}.python-bak"
    cp "$NVIM_CONFIG" "$backup"
    info "Config backed up to $(basename $backup)"
}

patch_plugins() {
    info "Adding Python plugins to lazy.nvim plugin list..."

    # check if already patched
    if grep -q 'neotest-python' "$NVIM_CONFIG"; then
        warning "Python plugins already present in config — skipping plugin patch"
        return
    fi

    # insert Python plugins before the closing }) of the lazy.nvim setup block
    # we anchor on the colourscheme line which is the last plugin entry
    python3 - "$NVIM_CONFIG" << 'PYEOF'
import sys

path = sys.argv[1]
with open(path, 'r') as f:
    content = f.read()

python_plugins = """
    -- Python
    "linux-cultist/venv-selector.nvim",
    "Vimjas/vim-python-pep8-indent",
    "nvim-neotest/neotest",
    "nvim-neotest/neotest-python",
    { "nvim-neotest/nvim-nio", },
"""

# insert before the closing of the lazy setup block
anchor = '    "folke/tokyonight.nvim",\n})'
if anchor not in content:
    print("ERROR: could not find insertion point in init.lua", file=sys.stderr)
    sys.exit(1)

content = content.replace(anchor, '    "folke/tokyonight.nvim",' + python_plugins + '})')

with open(path, 'w') as f:
    f.write(content)

print("Plugins inserted")
PYEOF
}

patch_lsp() {
    info "Adding pyright LSP config..."

    if grep -q 'pyright' "$NVIM_CONFIG"; then
        warning "pyright already configured — skipping LSP patch"
        return
    fi

    python3 - "$NVIM_CONFIG" << 'PYEOF'
import sys

path = sys.argv[1]
with open(path, 'r') as f:
    content = f.read()

pyright_config = """
-- ─── Python LSP ─────────────────────────────────────────────────────────────
vim.lsp.config('pyright', {
    settings = {
        python = {
            analysis = {
                typeCheckingMode = "basic",
                autoSearchPaths  = true,
                useLibraryCodeForTypes = true,
            }
        }
    }
})
vim.lsp.enable('pyright')

-- auto format Python on save with black via LSP
vim.api.nvim_create_autocmd('BufWritePre', {
    pattern  = '*.py',
    callback = function() vim.lsp.buf.format({ async = false }) end,
})
"""

anchor = "vim.lsp.enable('rust_analyzer')"
if anchor not in content:
    print("ERROR: could not find LSP anchor in init.lua", file=sys.stderr)
    sys.exit(1)

content = content.replace(anchor, anchor + "\n" + pyright_config)

with open(path, 'w') as f:
    f.write(content)

print("Pyright LSP config inserted")
PYEOF
}

patch_neotest() {
    info "Adding neotest (pytest) config..."

    if grep -q 'neotest' "$NVIM_CONFIG" && grep -q 'neotest).run.run' "$NVIM_CONFIG"; then
        warning "neotest already configured — skipping"
        return
    fi

    python3 - "$NVIM_CONFIG" << 'PYEOF'
import sys

path = sys.argv[1]
with open(path, 'r') as f:
    content = f.read()

neotest_config = """
-- ─── neotest (pytest) ───────────────────────────────────────────────────────
vim.api.nvim_create_autocmd('VimEnter', {
    callback = function()
        local ok, neotest = pcall(require, 'neotest')
        if not ok then return end
        neotest.setup({
            adapters = {
                require('neotest-python')({ runner = 'pytest' })
            }
        })
        vim.keymap.set('n', '<leader>tt', function() neotest.run.run() end,
            { desc = 'Run nearest test' })
        vim.keymap.set('n', '<leader>tf', function() neotest.run.run(vim.fn.expand('%')) end,
            { desc = 'Run test file' })
        vim.keymap.set('n', '<leader>ts', function() neotest.summary.toggle() end,
            { desc = 'Test summary panel' })
        vim.keymap.set('n', '<leader>to', function() neotest.output.open() end,
            { desc = 'Test output' })
    end
})
"""

anchor = "require('gitsigns').setup()"
if anchor not in content:
    print("ERROR: could not find gitsigns anchor in init.lua", file=sys.stderr)
    sys.exit(1)

content = content.replace(anchor, anchor + "\n" + neotest_config)

with open(path, 'w') as f:
    f.write(content)

print("neotest config inserted")
PYEOF
}

patch_venv_selector() {
    info "Adding venv-selector config..."

    if grep -q 'VenvSelect' "$NVIM_CONFIG"; then
        warning "venv-selector already configured — skipping"
        return
    fi

    python3 - "$NVIM_CONFIG" << 'PYEOF'
import sys

path = sys.argv[1]
with open(path, 'r') as f:
    content = f.read()

venv_config = """
-- ─── venv-selector ──────────────────────────────────────────────────────────
vim.api.nvim_create_autocmd('VimEnter', {
    callback = function()
        local ok, venv = pcall(require, 'venv-selector')
        if not ok then return end
        venv.setup()
        vim.keymap.set('n', '<leader>vs', ':VenvSelect<CR>',
            { desc = 'Select Python virtual environment' })
    end
})
"""

anchor = "require('gitsigns').setup()"
if anchor not in content:
    print("ERROR: could not find gitsigns anchor in init.lua", file=sys.stderr)
    sys.exit(1)

content = content.replace(anchor, anchor + "\n" + venv_config)

with open(path, 'w') as f:
    f.write(content)

print("venv-selector config inserted")
PYEOF
}

# ─── sync plugins ─────────────────────────────────────────────────────────────

sync_plugins() {
    info "Syncing Neovim plugins..."
    nvim --headless "+Lazy! sync" +qa 2>/dev/null || true
    info "Plugins synced"
}

# ─── main ─────────────────────────────────────────────────────────────────────

main() {
    info "Setting up Python development environment for Neovim..."

    check_prerequisites
    install_python_tools
    backup_config
    patch_plugins
    patch_lsp
    patch_neotest
    patch_venv_selector
    sync_plugins

    info "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    info "Python setup complete!"
    info ""
    info "New key bindings:"
    info "  <leader>vs   select virtual environment"
    info "  <leader>tt   run nearest test"
    info "  <leader>tf   run all tests in file"
    info "  <leader>ts   toggle test summary panel"
    info "  <leader>to   show test output"
    info ""
    info "Python files are auto-formatted with black on save."
    info "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
}

main "$@"
