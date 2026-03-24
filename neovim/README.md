# Neovim Development Environment — Go & Rust

A Neovim setup for Go and Rust development on Ubuntu/Debian, installed via `setup-neovim-dev.sh`.

---

## Installation

```bash
chmod +x setup-neovim-dev.sh
./setup-neovim-dev.sh
source ~/.bashrc
```

The script installs: Neovim (latest), Rust + rust-analyzer, Go + gopls, Node.js, ripgrep, and all Neovim plugins.

> If you have an existing `~/.config/nvim/init.lua` it will be backed up to `init.lua.bak` before being replaced.

---

## What Gets Installed

| Tool | Purpose |
|---|---|
| Neovim | Editor (installed to `/opt/nvim-linux-x86_64`) |
| Rust + rustup | Rust toolchain |
| rust-analyzer | Rust LSP server |
| Go | Go toolchain (installed to `/usr/local/go`) |
| gopls | Go LSP server |
| Node.js LTS | Required by some Neovim plugins |
| ripgrep | Fast grep used by Telescope |

### Neovim Plugins

| Plugin | Purpose |
|---|---|
| nvim-lspconfig | LSP client configuration |
| nvim-cmp | Autocompletion engine |
| LuaSnip | Snippet engine |
| go.nvim | Go-specific commands |
| telescope.nvim | Fuzzy finder |
| nvim-tree | File explorer sidebar |
| lualine | Statusline |
| gitsigns | Git diff markers in gutter |
| tokyonight | Colour scheme |

---

## Opening a Project

```bash
# open a directory
nvim .

# open a specific file
nvim main.go
nvim src/main.rs
```

LSP activates automatically when you open a `.go` or `.rs` file inside a project that has a `go.mod` or `Cargo.toml`.

---

## Key Bindings

> `<leader>` is `\` by default.

### Navigation

| Key | Action |
|---|---|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gr` | Find all references |
| `gi` | Go to implementation |
| `Ctrl+o` | Jump back |
| `Ctrl+i` | Jump forward |
| `K` | Hover documentation |

### Diagnostics (errors and warnings)

| Key | Action |
|---|---|
| `]d` | Next diagnostic |
| `[d` | Previous diagnostic |

### Code Actions

| Key | Action |
|---|---|
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code action (quick fix, imports etc.) |
| `<leader>f` | Format file |

### Completion

| Key | Action |
|---|---|
| `Tab` | Next completion item |
| `Shift+Tab` | Previous completion item |
| `Enter` | Confirm selection |
| `Ctrl+Space` | Trigger completion manually |
| `Ctrl+e` | Cancel completion |

### Fuzzy Finder (Telescope)

| Key | Action |
|---|---|
| `<leader>ff` | Find files in project |
| `<leader>fg` | Live grep across codebase |
| `<leader>fb` | Switch between open buffers |

Inside a Telescope window: `j/k` to navigate, `Enter` to open, `Esc` to close.

### File Tree (nvim-tree)

| Key | Action |
|---|---|
| `<leader>e` | Toggle file tree sidebar |
| `Enter` | Open file |
| `a` | Create new file |
| `d` | Delete file |
| `r` | Rename file |
| `q` | Close tree |

---

## Go Development

### go.nvim Commands

Run these from normal mode in a `.go` file:

```vim
:GoRun          " run current file
:GoTest         " run tests in current package
:GoTestFunc     " run test under cursor
:GoBuild        " build the project
:GoFmt          " format with gofmt
:GoImport       " add/remove imports
:GoLint         " run golint
:GoVet          " run go vet
```

Go files are automatically formatted with `gofmt` on save.

### Running Tests from the Terminal

```bash
# run all tests
go test ./...

# run a specific test
go test ./... -run TestMyFunction

# with verbose output
go test -v ./...
```

---

## Rust Development

### Checking and Building

```bash
# check for errors without building
cargo check

# build
cargo build

# build release
cargo build --release

# run
cargo run

# run with arguments
cargo run -- --my-arg value
```

### Running Tests

```bash
# run all tests
cargo test

# run a specific test
cargo test test_name

# show stdout from tests
cargo test -- --nocapture

# run with logging
RUST_LOG=trace cargo test -- --nocapture
```

### Clippy (Rust Linter)

rust-analyzer runs clippy on save automatically (configured in `init.lua`). You can also run it manually:

```bash
cargo clippy
cargo clippy -- -D warnings    # treat warnings as errors
```

---

## LSP Troubleshooting

### Check if LSP is attached

```vim
:LspInfo
```

This shows which LSP servers are running for the current buffer. If nothing is attached:

- For Go: make sure there is a `go.mod` in the project root
- For Rust: make sure there is a `Cargo.toml` in the project root

LSP will not activate on standalone files without a project root.

### Check for errors

```vim
:messages
```

### Restart LSP

```vim
:LspRestart
```

---

## Plugin Management

Plugins are managed by [lazy.nvim](https://github.com/folke/lazy.nvim).

```vim
:Lazy          " open plugin manager UI
:Lazy sync     " install/update/clean plugins
:Lazy update   " update all plugins
:Lazy clean    " remove unused plugins
```

---

## Updating Tools

### Update Neovim

Re-run the setup script — it always fetches the latest release:

```bash
./setup-neovim-dev.sh
```

### Update Rust

```bash
rustup update stable
rustup component add rust-analyzer   # update rust-analyzer
```

### Update Go

```bash
# download new version from https://go.dev/dl/ then:
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf go<version>.linux-amd64.tar.gz
go install golang.org/x/tools/gopls@latest   # update gopls
```

### Update Neovim Plugins

```vim
:Lazy sync
```

---

## Config File Location

```
~/.config/nvim/init.lua        — main Neovim config
~/.config/nvim/init.lua.bak    — backup of previous config (if any)
~/.local/share/nvim/lazy/      — plugin install directory
```

To customise the setup, edit `~/.config/nvim/init.lua` and restart Neovim or run `:Lazy sync` if you add new plugins.
