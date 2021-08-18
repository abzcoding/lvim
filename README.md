# Bloated LunarVim

Do not use as is, use it as a source of inspiration.

I've customized my ZSH/Tmux/Alacritty too much, so it might not work properly 😅

## Things to Know

- I'm on the `rolling` branch of LunarVim
- Do not use as is, too much bloated! Also do not use on a potato PC!!
- if you want to use debugging, change the following line to true:
  - `lvim.builtin.dap.active = true`
- sometimes instead of saving you jump trough jumplist 😢 just disable nvim-lastplace
  - `lvim.builtin.lastplace = { active = false }`
- sometimes `compe-tabnine` doesn't play nice, you can disable it :)
  - `lvim.builtin.tabnine = { active = false }`
- if you wanna see the issues, remove `lvim.lsp.diagnostics.virtual_text = false`
- Using tailwinds CSS for markdown, disable it if you want
- disable lir if you don't like it
  - `lvim.builin.lir = {active = false}`

<!--
- orgmode is using `~/shared/orgs` folder
  -->

## How to use

```shell
# install LunarVim
mv ~/.config/lvim ~/.config/lvim_backup
git clone https://github.com/abzcoding/lvim.git ~/.config/lvim
brew install luarocks
luarocks install luacheck  # if you want to use luacheck
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
- [Todo Comments](https://github.com/folke/todo-comments.nvim)
- [Trouble](https://github.com/folke/trouble.nvim)
- [symbols-outline.nvim](https://github.com/simrat39/symbols-outline.nvim)
- [Diffview.nvim](https://github.com/sindrets/diffview.nvim)
- [Indent Blankline](https://github.com/lukas-reineke/indent-blankline.nvim)
- [Twilight](https://github.com/folke/twilight.nvim)
- [nvim-bqf](https://github.com/kevinhwang91/nvim-bqf)
- [vim match-up](https://github.com/andymass/vim-matchup)
- [Markdown Preview for (Neo)vim](https://github.com/iamcco/markdown-preview.nvim)
- [Zen Mode](https://github.com/folke/zen-mode.nvim)
- [rust-tools](https://github.com/simrat39/rust-tools.nvim)
- [nvim-spectre](https://github.com/windwp/nvim-spectre)
- [Hop](https://github.com/phaazon/hop.nvim)
- [zephyr-nvim](https://github.com/abzcoding/zephyr-nvim)
- [colorizer.lua](https://github.com/norcalli/nvim-colorizer.lua)
- [lsp-status.nvim](https://github.com/nvim-lua/lsp-status.nvim)

### Optional Plugins

- [nvim-lastplace](https://github.com/ethanholz/nvim-lastplace)
- [Tabnine](https://github.com/tzachar/compe-tabnine)
- [Persistence](https://github.com/folke/persistence.nvim)
- [Presence](https://github.com/andweeb/presence.nvim)
- [Orgmode.nvim](https://github.com/kristijanhusak/orgmode.nvim)
- [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui)
- [lir.nvim](https://github.com/tamago324/lir.nvim)
