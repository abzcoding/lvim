# Bloated LunarVim

Do not use as is, use it as a source of inspiration.

I've customized my ZSH/Tmux/Alacritty too much, so it might not work properly 😅

## Customization

- I'm on the `rolling` branch of LunarVim and i'm using `neovim 0.6 head`
- Do not use as is, too much bloated! Also do not use on a potato PC!!
- i have a auto command to disable syntax,etc when you open files larger than `1MB`
- if you want to try out GitHub copilot, change the following
  - `lvim.builtin.sell_your_soul_to_devil = true`
- I'm using a custom dashboard, use the default LunarVim one if you like it better
  - `lvim.builtin.fancy_dashboard = { active = false }`
- I use a custom `lualine` disable it if you don't like it
  - `lvim.builtin.fancy_statusline = { active = false }`
- I'm using `bufferline` instead of `barbar`, if you don't like it, disable it
  - `lvim.builtin.fancy_bufferline = { active = false }`
- You can use the fancy wild menu if you want, make sure to do a `:UpdateRemotePlugins`
  - `lvim.builtin.fancy_wild_menu = { active = true }`
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
- if you don't want the SQL integration, disable it
  - `lvim.builtin.sql_integration = { active = false }`
- if you don't like smooth scrolling, disable it
  - `lvim.builtin.neoscroll = { active = false }`
- if you want an obvious focused window, and you don't get seizures from it
  - `lvim.builtin.nonumber_unfocus = true`
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

---

## What does it look like?

<img width="1914" alt="Screen Shot 2021-10-20 at 1 09 24 PM" src="https://user-images.githubusercontent.com/10992695/138069108-4fd1b129-0b20-4bfe-bf55-81614410ea58.png">

#### StatusLine

<img width="662" alt="Screen Shot 2021-10-18 at 5 44 20 PM" src="https://user-images.githubusercontent.com/10992695/137748538-33c59697-6783-43e5-bbd7-d920f91965bf.png">

#### BufferLine

<img width="1912" alt="Screen Shot 2021-10-18 at 5 45 16 PM" src="https://user-images.githubusercontent.com/10992695/137748708-ce6a91e1-aec4-46ea-b119-2086897c1d0e.png">

#### Dashboard

<img width="1913" alt="Screen Shot 2021-10-18 at 5 40 16 PM" src="https://user-images.githubusercontent.com/10992695/137747972-825b31a8-ce43-483e-b766-8d26f9d77d3f.png">

<img width="1904" alt="Screen Shot 2021-10-18 at 5 51 50 PM" src="https://user-images.githubusercontent.com/10992695/137749839-6b53ee28-5cc2-4ed0-999d-14905a68c645.png">

#### lsp_signature

<img width="809" alt="lsp_signature_2" src="https://user-images.githubusercontent.com/10992695/138069979-13a43683-3ba0-46b3-ae53-0904fbab66bc.png">
<img width="819" alt="lsp_signature" src="https://user-images.githubusercontent.com/10992695/138069986-897e29bd-f23d-4cec-a410-a8b7fcb0d465.png">

#### Tabnine

<img width="717" alt="tabnine" src="https://user-images.githubusercontent.com/10992695/138070107-c6aecc6d-6423-4f21-bc58-d0ee24142e3f.png">

#### Lang Server

_completion_
<img width="1912" alt="Screen Shot 2021-10-18 at 5 43 22 PM" src="https://user-images.githubusercontent.com/10992695/137748383-fddc84b9-4744-4905-9588-f8675b6c83e1.png">

_diagnostics using `gl`_
<img width="855" alt="Screen_Shot_2021-07-31_at_7 54 52_PM" src="https://user-images.githubusercontent.com/10992695/127746932-e42b63ee-7994-4b63-9550-a359e32e6f78.png">

_code_actions using `ga`_
<img width="1305" alt="Screen Shot 2021-10-18 at 6 25 58 PM" src="https://user-images.githubusercontent.com/10992695/137756116-63ebb337-f944-4b3f-80df-ae00634f78eb.png">

_`code_lens` and `inlay_hints` when supported by lang server_
<img width="670" alt="Screen Shot 2021-10-18 at 6 26 47 PM" src="https://user-images.githubusercontent.com/10992695/137756336-3658ff1d-c385-4341-8371-89ef32c2cc50.png">

_references in `qf`_
<img width="1911" alt="Screen Shot 2021-10-18 at 6 31 03 PM" src="https://user-images.githubusercontent.com/10992695/137757171-b50a0c43-5861-4c60-b95e-4bdab97b338e.png">

_treesitter backed folding_
<img width="955" alt="Screen Shot 2021-10-18 at 6 05 29 PM" src="https://user-images.githubusercontent.com/10992695/137752198-ecdd8718-6ee0-4d4a-a751-a11f81eaf912.png">

_peek using `gp`_

<img width="643" alt="Screen Shot 2021-10-18 at 6 33 06 PM" src="https://user-images.githubusercontent.com/10992695/137757505-d742558a-56c7-4c1d-b037-14bfab200901.png">

#### Builtin Terminal

<img width="1913" alt="Screen Shot 2021-10-18 at 6 07 13 PM" src="https://user-images.githubusercontent.com/10992695/137752572-87a5792f-87a3-4131-8a1b-4ba786b83086.png">

#### Testing

<img width="1706" alt="Screen Shot 2021-10-18 at 6 13 22 PM" src="https://user-images.githubusercontent.com/10992695/137753736-a4502a50-cff5-4365-bfd7-22dfd08c71ed.png">

#### ETC

_k8s help_

<img width="1571" alt="Screen Shot 2021-10-18 at 6 23 21 PM" src="https://user-images.githubusercontent.com/10992695/137755742-d9c2f106-de34-4503-857a-ada7ba1160f3.png">

_lazy git integration_

<img width="1893" alt="Screen Shot 2021-10-18 at 6 27 45 PM" src="https://user-images.githubusercontent.com/10992695/137756730-f4ff78c8-dc9a-43bf-9646-916cd467c4c3.png">

_zen mode_

<img width="1870" alt="Screen Shot 2021-10-18 at 6 30 00 PM" src="https://user-images.githubusercontent.com/10992695/137757021-b084822c-457b-4a5f-9592-0992977ae218.png">

_Cheat.sh integration_

use `<leader>?`
<img width="1883" alt="Screen Shot 2021-10-18 at 6 02 31 PM" src="https://user-images.githubusercontent.com/10992695/137751690-311849e6-42b2-4bb1-a3ed-a52fd1a804cf.png">

<img width="1918" alt="Screen Shot 2021-10-18 at 6 01 34 PM" src="https://user-images.githubusercontent.com/10992695/137751541-0c6bcb6f-3498-454d-bcf5-7001cf004c1f.png">

_Symbols Outline_

<img width="1906" alt="Screen Shot 2021-10-18 at 6 03 57 PM" src="https://user-images.githubusercontent.com/10992695/137751933-291297b4-4233-406a-88bc-68b93733048a.png">

---

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
- [Dependency-assist.nvim](https://github.com/akinsho/dependency-assist.nvim)

### Optional Plugins

- [wilder.nvim](https://github.com/gelguy/wilder.nvim)
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
- [alpha-nvim](https://github.com/goolord/alpha-nvim)
- [vim-dadbod](https://github.com/tpope/vim-dadbod)
- [vim-dadbod-completion](https://github.com/kristijanhusak/vim-dadbod-completion)
- [vim-dadbod-ui](https://github.com/kristijanhusak/vim-dadbod-ui)
- [Neoscroll](https://github.com/karb94/neoscroll.nvim)
- [Copilot](https://github.com/github/copilot.vim)
