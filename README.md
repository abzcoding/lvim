# Bloated LunarVim

Do not use as is 😅, use it as a source of inspiration.

## Known Issues

- Do not use as is, too much bloated! Also do not use on a potato PC!!
- sometimes `compe-tabnine` doesn't play nice, you can disable it :)
- if you wanna see the issues, remove `lvim.lsp.diagnostics.virtual_text = false`
- Using tailwinds CSS for markdown, disable it if you want

<!--
- orgmode is using `~/shared/orgs` folder
  -->

## How to use

```shell
# install LunarVim
mv ~/.config/lvim ~/.config/lvim_backup
git clone https://github.com/abzcoding/lvim.git ~/.config/lvim
cargo install selene  # if you want to use selene instead of luacheck
brew install hadolint  # if you want to lint dockerfiles
pip install vim-vint  # for vim linting
# install llvm and clang_format for clang stuff
pip install yapf flake8 black  # for python stuff
# if you want to use the markdown thingy
brew install vale
cp -r ~/.config/lvim/.vale ~/.config/vale
# fix the address inside .vale.ini
cp ~/.config/lvim/vale_config.ini ~/.vale.ini
lvim # run :PackerSync
```

```vim
:LspInstall lua
:LspInstall yaml
:LspInstall dockerfile
:LspInstall python
:LspInstall vim
:LspInstall json
:LspInstall go
:LspInstall bash
:LspInstall cpp
:LspInstall csharp
:LspInstall rust
:LspInstall cmake
:LspInstall tailwindcss
```

## Included Plugins

- [Tokyonight Theme](https://github.com/folke/tokyonight.nvim/)
- [Doom One Theme](https://github.com/NTBBloodbath/doom-one.nvim)
- [LSP Signature](https://github.com/ray-x/lsp_signature.nvim/)
- [nvim-lastplace](https://github.com/ethanholz/nvim-lastplace)
- [Todo Comments](https://github.com/folke/todo-comments.nvim)
- [Trouble](https://github.com/folke/trouble.nvim)
- [symbols-outline.nvim](https://github.com/simrat39/symbols-outline.nvim)
- [Diffview.nvim](https://github.com/sindrets/diffview.nvim)
- [telescope-project.nvim](https://github.com/sindrets/diffview.nvim)
- [Indent Blankline](https://github.com/lukas-reineke/indent-blankline.nvim)
- [Tabnine](https://github.com/tzachar/compe-tabnine)
- [Twilight](https://github.com/folke/twilight.nvim)
- [nvim-bqf](https://github.com/kevinhwang91/nvim-bqf)
- [vim match-up](https://github.com/andymass/vim-matchup)
- [Markdown Preview for (Neo)vim](https://github.com/iamcco/markdown-preview.nvim)
- [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui)
- [Zen Mode](https://github.com/folke/zen-mode.nvim)
- [rust-tools](https://github.com/simrat39/rust-tools.nvim)
- [nvim-spectre](https://github.com/windwp/nvim-spectre)
- [Hop](https://github.com/phaazon/hop.nvim)
- [zephyr-nvim](https://github.com/abzcoding/zephyr-nvim)
- [colorizer.lua](https://github.com/norcalli/nvim-colorizer.lua)
- [lsp-status.nvim](https://github.com/nvim-lua/lsp-status.nvim)

<!--
- [Orgmode.nvim](https://github.com/kristijanhusak/orgmode.nvim))
  -->
