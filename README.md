# Bloated LunarVim

Do not use as is, use it as a source of inspiration.

I've customized my ZSH/Tmux/Alacritty too much, so it might not work properly 😅

## Customization

- I'm on the `rolling` branch of LunarVim and i'm using `neovim 0.6 head`
- Do not use as is, too much bloated! Also do not use on a potato PC!!
- i have a autocmd to disable syntax,etc when you open files larger than 1MB
- I use a custom `lualine` disable it if you don't like it
  - `lvim.builtin.fancy_statusline = { active = false }`
- I'm using bufferline instead of barbar, if you don't like it, disable it
  - `lvim.builtin.fancy_bufferline = { active = false }`
- if you want to use debugging, change the following line to true:
  - `lvim.builtin.dap.active = true`
- sometimes instead of saving you jump trough jumplist 😢 just disable nvim-lastplace
  - `lvim.builtin.lastplace = { active = false }`
- sometimes `compe-tabnine` doesn't play nice, you can disable it :)
  - `lvim.builtin.tabnine = { active = false }`
- if you don't need testing, just disable it
  - `lvim.builtin.test_runner = { active = false }`
- if you don't want [cheat.sh](http://cheat.sh) integration, disable it
  - `lvim.builtin.cheat = { active = false }`
- If you wanna see the issues, remove `lvim.lsp.diagnostics.virtual_text = false`
- I'm using `skim` for `latex` stuff, change it to `zathura` if you are on `linux`
- Using tailwinds CSS for markdown, disable it if you want

<!--
- orgmode is using `~/shared/orgs` folder
  -->

## How to use

```shell
# install LunarVim
mv ~/.config/lvim ~/.config/lvim_backup
git clone https://github.com/abzcoding/lvim.git ~/.config/lvim
lvim +LvimUpdate +LvimCacheReset +q
brew install luarocks
luarocks install luacheck  # if you want to use luacheck
cargo install selene  # if you want to use selene instead of luacheck
brew install hadolint  # if you want to lint dockerfiles
pip install vim-vint  # for vim linting
# install llvm and clang_format for clang stuff
npm install -g @fsouza/prettierd # if you want to use prettierd
pip install yapf flake8 black  # for python stuff
# if you want to use the markdown thingy
brew install vale markdownlint-cli
cp -r ~/.config/lvim/.vale ~/.config/vale
# fix the address inside .vale.ini
cp ~/.config/lvim/vale_config.ini ~/.vale.ini
# if you want the latex stuff
# brew install --cask mactex-no-gui # for mac
# or install zathura and chktex on linux
lvim # run :PackerSync
```

Install the language servers that you need

```vim
:LspInstall ansiblels bashls clangd cssls jdtls pyright rust_analyzer
:LspInstall terraformls vimls jsonls dockerls cmake gopls sumneko_lua
:LspInstall tailwindcss texlab tsserver yamlls
```

In case you want a better tex support in mac, check
[this](https://gist.github.com/peterhurford/75957ba9335e755013b87254ec85fab1) out

## Included Plugins

- [Tokyonight Theme](https://github.com/folke/tokyonight.nvim/)
- [Doom One Theme](https://github.com/NTBBloodbath/doom-one.nvim)
- [Catppuccino Theme](https://github.com/Pocco81/Catppuccino.nvim)
- [Zephyr Theme](https://github.com/abzcoding/zephyr-nvim)
- [LSP Signature](https://github.com/ray-x/lsp_signature.nvim/)
- [Todo Comments](https://github.com/folke/todo-comments.nvim)
- [Trouble](https://github.com/folke/trouble.nvim)
- [symbols-outline.nvim](https://github.com/simrat39/symbols-outline.nvim)
- [Indent Blankline](https://github.com/lukas-reineke/indent-blankline.nvim)
- [Twilight](https://github.com/folke/twilight.nvim)
- [nvim-bqf](https://github.com/kevinhwang91/nvim-bqf)
- [vim match-up](https://github.com/andymass/vim-matchup)
- [Markdown Preview for (Neo)vim](https://github.com/iamcco/markdown-preview.nvim)
- [Zen Mode](https://github.com/folke/zen-mode.nvim)
- [rust-tools](https://github.com/simrat39/rust-tools.nvim)
- [nvim-spectre](https://github.com/windwp/nvim-spectre)
- [Hop](https://github.com/phaazon/hop.nvim)
- [colorizer.lua](https://github.com/norcalli/nvim-colorizer.lua)
- [Neogen](https://github.com/danymat/neogen)
- [Vimtex](https://github.com/lervag/vimtex)
- [nvim-lsp-ts-utils](https://github.com/jose-elias-alvarez/nvim-lsp-ts-utils)
- [Bufferline](https://github.com/akinsho/bufferline.nvim)
- [flutter-tools.nvim](https://github.com/akinsho/flutter-tools.nvim)
- [NeoClip](https://github.com/AckslD/nvim-neoclip.lua)

### Optional Plugins

- [nvim-lastplace](https://github.com/ethanholz/nvim-lastplace)
- [Tabnine](https://github.com/tzachar/compe-tabnine)
- [Persistence](https://github.com/folke/persistence.nvim)
- [Presence](https://github.com/andweeb/presence.nvim)
- [Orgmode.nvim](https://github.com/kristijanhusak/orgmode.nvim)
- [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui)
- [LuaDev](https://github.com/folke/lua-dev.nvim)
- [vim-test](https://github.com/vim-test/vim-test)
- [vim-ultest](https://github.com/rcarriga/vim-ultest)
- [nvim-cheat](https://github.com/RishabhRD/nvim-cheat.sh)
