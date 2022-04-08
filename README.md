# Bloated LunarVim

Do not use as is, use it as a source of inspiration.

I've customized my ZSH/Tmux/Alacritty too much, so it might not work properly 😅

![141789968-ed61958c-9154-4774-b2e2-dfabe48d9660](https://user-images.githubusercontent.com/10992695/141791560-5062246a-056c-4a73-afa7-3152e6ad396e.jpg)

<details open>
  <summary>
    <strong>Table of Contents</strong>
    <small><i>(🔎 Click to expand/collapse)</i></small>
  </summary>

<!-- vim-markdown-toc GFM -->

- [Theme](#theme)
- [Customization](#features)
- [Install](#install)
- [Collaborative Editing](#collaborative-editing)
- [Java](#java)
- [Recommended Fonts](#recommended-fonts)
- [Screenshot](#screenshot)
- [Structure](#structure)
- [Plugins Included](#plugins-included)
  - [Optional Plugins](#optional-plugins)
- [Custom Key-mappings](#custom-key-mappings)
  - [Editor UI](#ui)
  - [Motions](#motion)
  - [LSP](#lsp)
  - [Plugin: AsyncTasks](#plugin-asynctasks)
  - [Plugin: Gitsigns](#plugin-gitsigns)
  - [Plugin: LazyGit](#plugin-lazygit)
  - [Plugin: Telescope](#plugin-telescope)
  - [Plugin: Harpoon](#plugin-harpoon)
  - [Plugin: Neogen](#plugin-neogen)
  - [Plugin: Persistence](#plugin-persistence)
  - [Plugin: Bufferline](#plugin-bufferline)
  - [Plugin: Trouble](#plugin-trouble)
  - [Plugin: Ultest](#plugin-ultest)
  - [Plugin: Spectre](#plugin-spectre)

<!-- vim-markdown-toc -->
</details>

## Theme

Themes are automatically changed based on time of the day:

| Theme                                                |      Time of the day       |
| ---------------------------------------------------- | :------------------------: |
| [rose-pine](https://github.com/rose-pine/neovim)     |         [1am, 9am)         |
| [tokyonight](https://github.com/folke/tokyonight)    |         [9am, 5pm)         |
| [catppuccin](https://github.com/catppuccin/nvim)     |         [5pm, 9pm)         |
| [kanagawa](https://github.com/rebelot/kanagawa.nvim) | [9pm, 11:59pm), [0am, 1am] |

You can change this in [plugins.lua](./lua/user/plugins.lua) and [theme.lua](./lua/user/theme.lua)

## Customization

<details>
  <summary>
    <strong>Customization</strong>
    <small><i>(🔎 Click to expand/collapse)</i></small>
  </summary>

- I'm on the `rolling` branch of LunarVim and i'm using `neovim 0.7 head`
- Do not use as is, too much bloated! Also do not use on a potato PC!!
- i have a auto command to disable syntax,etc when you open files larger than `1MB`
- if you don't want to use `harpoon`, disable it
  - `lvim.builtin.harpoon = { active = false }`
- if you want to try out GitHub copilot, change the following
  - `lvim.builtin.sell_your_soul_to_devil = true`
- I use a custom `lualine` disable it if you don't like it
  - `lvim.builtin.fancy_statusline = { active = false }`
- You can use the fancy wild menu if you want, make sure to do a `:UpdateRemotePlugins`
  - `lvim.builtin.fancy_wild_menu = { active = true }`
- You can use the `diffview` plugin instead of normal `gitsigns diff`
  - `lvim.builtin.fancy_diff = { active = true }`
- if you want to use debugging, change the following line to true, also [install codelldb](<https://github.com/mfussenegger/nvim-dap/wiki/C-C---Rust-(via--codelldb)>):
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
- choose between [hop](https://github.com/phaazon/hop.nvim) and [lightspeed](https://github.com/ggandor/lightspeed.nvim) as your favorite motion provider
  - `lvim.builtin.motion_provider = "hop"`
- if you don't need CSV support, disable it
  - `lvim.builtin.csv_support = false`
- if you want to use the cool make and run system, enable it
  - `lvim.builtin.async_tasks = { active = true }`
- If you wanna see the issues, remove `lvim.lsp.diagnostics.virtual_text = false`
- I'm using `skim` for `latex` stuff, change it to `zathura` if you are on `linux`

<!--
- orgmode is using `~/shared/orgs` folder
  -->

</details>

## Install

<details>
  <summary><strong>Prerequisites</strong> <small><i>(🔎 Click to expand/collapse)</i></small></summary>

### Prerequisites

- [Neovim](neovim-install) >= v0.6.0

```shell
  brew install neovim --nightly
```

- [Rust](rust-install)
  and telescope stuff:
  - [ripgrep](ripgrep)
  - [fd](fd)

```shell
curl --proto '=https' --tlsv1.2 -sSf "https://sh.rustup.rs" | sh
cargo install ripgrep fd-find
```

- [NodeJS](nodejs-install) >= v16.13.0
  most language servers need this

```shell
brew install node
```

</details>

```shell
# install LunarVim
mv ~/.config/lvim ~/.config/lvim_backup
git clone https://github.com/abzcoding/lvim.git ~/.config/lvim
lvim +LvimUpdate +LvimCacheReset +q
lvim # run :PackerSync
```

### Java

Please run the following to have a better debugging and testing support for java

```shell
mkdir -p ~/workspace
git clone git@github.com:microsoft/java-debug.git ~/.config/lvim/.java-debug
cd ~/.config/lvim/.java-debug/
./mvnw clean install
git clone git@github.com:microsoft/vscode-java-test.git ~/.config/lvim/.vscode-java-test
cd ~/.config/lvim/vscode-java-test
npm install
npm run build-plugin
```

### Recommended Fonts

- [FiraCode Nerd Font](firaCode): My preferred font
- Any of the [Nerd Fonts]

On macOS with Homebrew, choose one of the [Nerd Fonts],
for example, here are some popular fonts:

```shell
brew tap homebrew/cask-fonts
brew search nerd-font
brew install --cask font-fira-code-nerd-font
brew install --cask font-victor-mono-nerd-font
brew install --cask font-iosevka-nerd-font-mono
brew install --cask font-hack-nerd-font
```

<details>
  <summary><strong>Other Stuff</strong> <small><i>(🔎 Click to expand/collapse)</i></small></summary>

## Language-Server Protocol (LSP)

To leverage LSP auto-completions and other functionalities, after you open a
file in Neovim, run `:LspInstall <server>` to use
[nvim-lsp-installer](lsp-installer) installation feature.
Use `Tab` to list available servers.

Here are some common LSP server installations:

- `:LspInstall html cssls jsonls yamlls`
- `:LspInstall gopls`
- `:LspInstall pylsp`
- `:LspInstall bashls vimls sumneko_lua`
- `:LspInstall diagnosticls`
- and [more](lsp-installer)…

## Upgrade

```shell
cd ~/.config/lvim
git pull
lvim # run :PackerSync
```

### Recommended Linters

```shell
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
```

In case you want a better tex support in mac, check
[this](tex-support) out

if you want the custom `gostructhelper`, first get the pkg:

```shell
cd /tmp
git clone https://github.com/vanhtuan0409/gostructhelper.git
cd gostructhelper/cmds/gostructhelper
go build -o /usr/local/bin/gostructhelper && chmod 0755 /usr/local/bin/gostructhelper
```

</details>

---

## Collaborative Editing

The default is to serve localhost only, on port 8080. For a more advanced (remote server) overview see [Deploy a server](https://github.com/jbyuki/instant.nvim/wiki/Deploy-a-server)

### Server side

- `:InstantStartServer [host] [port]` : Start the server using
  - `:InstantStartSingle [host] [port]` : This only shares the current buffer.
  - `:InstantStartSession [host] [port]` :This shares all opened (and newly opened) buffers with the other clients

### Client side

- `let g:instant_username="sth"` : Set your preferred username.
  - `:InstantJoinSingle [host] [port]` : Use this command if another client already initiated a single share.
  - `:InstantJoinSession [host] [port]` : Use this command if another client already initiated a session share

---

## Screenshot

<details>
  <summary><strong>Screenshots</strong> <small><i>(🔎 Click to expand/collapse)</i></small></summary>

<img width="1914" alt="Screen Shot 2021-10-20 at 1 09 24 PM" src="https://user-images.githubusercontent.com/10992695/138069108-4fd1b129-0b20-4bfe-bf55-81614410ea58.png">

### BufferLine

<img width="662" alt="Screen Shot 2021-10-18 at 5 44 20 PM" src="https://user-images.githubusercontent.com/10992695/137748538-33c59697-6783-43e5-bbd7-d920f91965bf.png">

#### StatusLine

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

_rename using `<leader>lr`_

<img width="470" alt="Screen Shot 2021-11-04 at 3 54 15 PM" src="https://user-images.githubusercontent.com/10992695/140312997-77a30d8e-3c1a-413a-920e-971474c6f92e.png">

#### Builtin Terminal

<img width="1913" alt="Screen Shot 2021-10-18 at 6 07 13 PM" src="https://user-images.githubusercontent.com/10992695/137752572-87a5792f-87a3-4131-8a1b-4ba786b83086.png">

#### Test

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

## </details>

## Plugins Included

<details>
  <summary><strong>Plugins</strong> <small><i>(🔎 Click to expand/collapse)</i></small></summary>

- [Tokyonight Theme](https://github.com/folke/tokyonight.nvim/)
- [Doom One Theme](https://github.com/NTBBloodbath/doom-one.nvim)
- [Rose Pine Theme](https://github.com/rose-pine/neovim)
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
- [colorizer.lua](https://github.com/norcalli/nvim-colorizer.lua)
- [Neogen](https://github.com/danymat/neogen)
- [Vimtex](https://github.com/lervag/vimtex)
- [nvim-lsp-ts-utils](https://github.com/jose-elias-alvarez/nvim-lsp-ts-utils)
- [flutter-tools.nvim](https://github.com/akinsho/flutter-tools.nvim)
- [NeoClip](https://github.com/AckslD/nvim-neoclip.lua)
- [Telescope live grep raw](nvim-telescope/telescope-live-grep-raw.nvim)
- [nvim-lightbulb](https://github.com/kosayoda/nvim-lightbulb)
- [fidget](https://github.com/j-hui/fidget.nvim)
- [clangd_extensions.nvim](https://github.com/p00f/clangd_extensions.nvim)
- [crates.nvim](https://github.com/Saecki/crates.nvim)

### Optional Plugins

- [Hop](https://github.com/phaazon/hop.nvim)
- [Lightspeed](https://github.com/ggandor/lightspeed.nvim)
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
- [vim-dadbod](https://github.com/tpope/vim-dadbod)
- [vim-dadbod-completion](https://github.com/kristijanhusak/vim-dadbod-completion)
- [vim-dadbod-ui](https://github.com/kristijanhusak/vim-dadbod-ui)
- [Neoscroll](https://github.com/karb94/neoscroll.nvim)
- [Copilot](https://github.com/github/copilot.vim)
- [Harpoon](https://github.com/ThePrimeagen/harpoon)
- [Renamer](https://github.com/filipdutescu/renamer.nvim)
- [vim-log-highlighting](https://github.com/mtdl9/vim-log-highlighting)
- [nvim-cursorline](https://github.com/yamatsum/nvim-cursorline)
- [nvim-hlslens](https://github.com/kevinhwang91/nvim-hlslens)
- [csv.vim](https://github.com/chrisbra/csv.vim)
- [sidebar.nvim](https://github.com/sidebar-nvim/sidebar.nvim)
- [asynctasks.vim](https://github.com/skywind3000/asynctasks.vim)
- [asyncrun.vim](https://github.com/skywind3000/asyncrun.vim)
- [nvim-metals](https://github.com/scalameta/nvim-metals)
- [instant.nvim](https://github.com/jbyuki/instant.nvim)
- [SnipRun](https://github.com/michaelb/sniprun)
- [Vista](https://github.com/liuchengxu/vista.vim)
- [editorconfig-vim](https://github.com/editorconfig/editorconfig-vim)

</details>

## Structure

<details>
  <summary><strong>Structure</strong> <small><i>(🔎 Click to expand/collapse)</i></small></summary>

- [after/](./after) - Stuff that happens after
  - [ftplugin/](./after/ftplugin) - Language specific settings
  - [syntax/](./after/syntax) - Custom syntax for languages
- [ftdetect/](./ftdetect) - Let neovim identify custom filetypes
- [ftplugin/](./ftplugin) - Language specific custom settings
- [lsp-settings](./lsp-settings) - Custom lang server settings
- [lua/](./lua) - Lua plugin configurations
  - [telescope/](./lua/telescope/_extensions) - Telescope extensions
  - [user/](./lua/user) - User specific settings
    - [null_ls](./lua/user/null_ls) - list of configured linters/formatters
    - [autocommands.lua](./lua/user/autocommands.lua) - user defined autocommands
    - [builtin.lua](./lua/user/builtin.lua) - change internal lunarvim settings
    - [keybindings.lua](./lua/user/keybindings.lua) - user defined keybindings
    - [plugins.lua](./lua/user/plugins.lua) - list of installed plugins
    - [lsp_kind.lua](./lua/user/lsp_kind.lua) - all the icons and lsp ui goodies are here
    - [theme.lua](./lua/user/theme.lua) - customized themes
- [config.lua](./config.lua) - Main customization point for settings
- [snippets/](./snippets) - Personal code snippets
- [vimscript/](./vimscript) - wilder settings

</details>

## Custom Key-mappings

Note that,

- **Leader** key set as <kbd>Space</kbd>

<details open>
  <summary>
    <strong>Key-mappings</strong>
    <small><i>(🔎 Click to expand/collapse)</i></small>
  </summary>

<center>Modes: 𝐍=normal 𝐕=visual 𝐒=select 𝐈=insert 𝐂=command</center>

### UI

| Key                           | Mode | Action              | Plugin or Mapping                             |
| ----------------------------- | :--: | ------------------- | --------------------------------------------- |
| <kbd>Space</kbd>+<kbd>e</kbd> |  𝐍   | Open file tree      | <small>NvimTree</small>                       |
| <kbd>Space</kbd>+<kbd>o</kbd> |  𝐍   | Open symbols        | <small>Symbols-outline</small>                |
| <kbd>Space</kbd>+<kbd>f</kbd> |  𝐍   | Open file finder    | <small>Telescope</small>                      |
| <kbd>Space</kbd>+<kbd>h</kbd> |  𝐍   | Remove highlight    | <small>`nohlsearch<`</small>                  |
| <kbd>Space</kbd>+<kbd>/</kbd> |  𝐍   | Toggle comment      | <small>Comment.nvim</small>                   |
| <kbd>Space</kbd>+<kbd>?</kbd> |  𝐍   | Open cheats         | <small>cheat.sh</small>                       |
| <kbd>Space</kbd>+<kbd>'</kbd> |  𝐍   | Open marks          | <small>which-key marks</small>                |
| <kbd>Space</kbd>+<kbd>z</kbd> |  𝐍   | Zen mode            | <small>zen-mode.nvim</small>                  |
| <kbd>Space</kbd>+<kbd>P</kbd> |  𝐍   | Projects            | <small>project.nvim</small>                   |
| <kbd>Ctrl</kbd>+<kbd>\</kbd>  |  𝐈   | Open terminal       | <small>toggleterm.nvim</small>                |
| <kbd>Ctrl</kbd>+<kbd>s</kbd>  |  𝐈   | Show signature help | <small>`vim.lsp.buf.signature_help()`</small> |
| <kbd>Alt</kbd>+<kbd>s</kbd>   |  𝐈   | Snippet selection   | <small>Telescope luasnip extension</small>    |
| <kbd>Space</kbd>+<kbd>C</kbd> |  𝐍   | Command Palette     | <small>Telescope command_palette</small>      |

### Motion

| Key                         | Mode | Action                  | Plugin or Mapping                                                   |
| --------------------------- | :--: | ----------------------- | ------------------------------------------------------------------- |
| <kbd>f</kbd>                |  𝐍   | find next character     | <small>HopChar1CurrentLineAC</small> or <small>Lightspeed_f</small> |
| <kbd>F</kbd>                |  𝐍   | find previous character | <small>HopChar1CurrentLineBC</small> or <small>Lightspeed_F</small> |
| <kbd>s</kbd>                |  𝐍   | find character          | <small>HopChar2MW</small> or <small>Lightspeed_s</small>            |
| <kbd>S</kbd>                |  𝐍   | find word               | <small>HopWordMW</small> or <small>Lightspeed_S</small>             |
| <kbd>Alt</kbd>+<kbd>a</kbd> |  𝐈   | select all              | <small>ggVG</small>                                                 |
| <kbd>Alt</kbd>+<kbd>a</kbd> |  𝐍   | increment number        | <small>C-A</small>                                                  |
| <kbd>Alt</kbd>+<kbd>x</kbd> |  𝐍   | decrement number        | <small>C-X</small>                                                  |

### LSP

| Key                                                                                      | Mode | Action                              |
| ---------------------------------------------------------------------------------------- | :--: | ----------------------------------- |
| <kbd>Tab</kbd> / <kbd>Shift-Tab</kbd>                                                    |  𝐈   | Navigate completion-menu            |
| <kbd>Enter</kbd>                                                                         |  𝐈   | Select completion or expand snippet |
| <kbd>Up</kbd>or <kbd>Down</kbd>                                                          |  𝐈   | Movement in completion pop-up       |
| <kbd>]</kbd>+<kbd>d</kbd>                                                                |  𝐍   | Next diagnostic                     |
| <kbd>[</kbd>+<kbd>d</kbd>                                                                |  𝐍   | Previous diagnostic                 |
| <kbd>Space</kbd>+<kbd>l</kbd>+<kbd>j</kbd> or <kbd>Space</kbd>+<kbd>l</kbd>+<kbd>k</kbd> |  𝐍   | Next/previous LSP diagnostic        |
| <kbd>Space</kbd>+<kbd>l</kbd>+<kbd>r</kbd>                                               |  𝐍   | replace current word in project     |
| <kbd>Ctrl</kbd>+<kbd>e</kbd>                                                             |  𝐈   | Close pop-up                        |
| <kbd>Tab</kbd> / <kbd>Shift-Tab</kbd>                                                    | 𝐈 𝐒  | Navigate snippet placeholders       |
| <kbd>Space</kbd>+<kbd>l</kbd>                                                            |  𝐍   | keybindings for lsp                 |
| <kbd>g</kbd>+<kbd>a</kbd>                                                                |  𝐍   | code actions                        |
| <kbd>g</kbd>+<kbd>A</kbd>                                                                |  𝐍   | codelens actions                    |
| <kbd>g</kbd>+<kbd>d</kbd>                                                                |  𝐍   | goto definition                     |
| <kbd>g</kbd>+<kbd>t</kbd>                                                                |  𝐍   | goto type definition                |
| <kbd>g</kbd>+<kbd>D</kbd>                                                                |  𝐍   | goto declaration                    |
| <kbd>g</kbd>+<kbd>I</kbd>                                                                |  𝐍   | goto implementation                 |
| <kbd>g</kbd>+<kbd>p</kbd>                                                                |  𝐍   | peek implementation                 |
| <kbd>g</kbd>+<kbd>r</kbd>                                                                |  𝐍   | goto references                     |
| <kbd>g</kbd>+<kbd>s</kbd>                                                                |  𝐍   | show signature help                 |

### Plugin: AsyncTasks

| Key                                        | Mode | Action        |
| ------------------------------------------ | :--: | ------------- |
| <kbd>Space</kbd>+<kbd>m</kbd>+<kbd>f</kbd> |  𝐍   | Build File    |
| <kbd>Space</kbd>+<kbd>m</kbd>+<kbd>p</kbd> |  𝐍   | Build Project |
| <kbd>Space</kbd>+<kbd>m</kbd>+<kbd>e</kbd> |  𝐍   | Edit Tasks    |
| <kbd>Space</kbd>+<kbd>m</kbd>+<kbd>l</kbd> |  𝐍   | List Tasks    |
| <kbd>Space</kbd>+<kbd>r</kbd>+<kbd>f</kbd> |  𝐍   | Run File      |
| <kbd>Space</kbd>+<kbd>r</kbd>+<kbd>p</kbd> |  𝐍   | Run Project   |

### Plugin: Gitsigns

| Key                                                                                      | Mode | Action                 |
| ---------------------------------------------------------------------------------------- | :--: | ---------------------- |
| <kbd>Space</kbd>+<kbd>g</kbd>+<kbd>j</kbd> or <kbd>Space</kbd>+<kbd>g</kbd>+<kbd>k</kbd> |  𝐍   | Next/previous Git hunk |
| <kbd>Space</kbd>+<kbd>g</kbd>+<kbd>p</kbd>                                               |  𝐍   | Preview hunk           |
| <kbd>Space</kbd>+<kbd>g</kbd>+<kbd>l</kbd>                                               |  𝐍   | Blame line             |
| <kbd>Space</kbd>+<kbd>g</kbd>+<kbd>s</kbd>                                               | 𝐍 𝐕  | Stage hunk             |
| <kbd>Space</kbd>+<kbd>g</kbd>+<kbd>u</kbd>                                               |  𝐍   | Undo stage hunk        |
| <kbd>Space</kbd>+<kbd>g</kbd>+<kbd>R</kbd>                                               | 𝐍 𝐕  | Reset hunk             |

### Plugin: LazyGit

| Key                                        | Mode | Action           |
| ------------------------------------------ | :--: | ---------------- |
| <kbd>Space</kbd>+<kbd>g</kbd>+<kbd>g</kbd> |  𝐍   | Open lazy git UI |

### Plugin: Telescope

| Key                                        | Mode | Action                     |
| ------------------------------------------ | :--: | -------------------------- |
| <kbd>Space</kbd>+<kbd>f</kbd>              |  𝐍   | File search                |
| <kbd>Space</kbd>+<kbd>P</kbd>              |  𝐍   | Project search             |
| <kbd>Space</kbd>+<kbd>s</kbd>+<kbd>s</kbd> |  𝐍   | Grep search                |
| <kbd>Space</kbd>+<kbd>s</kbd>+<kbd>f</kbd> |  𝐍   | Telescope find_files       |
| <kbd>Space</kbd>+<kbd>s</kbd>+<kbd>e</kbd> |  𝐍   | Telescope file_browser     |
| <kbd>Space</kbd>+<kbd>F</kbd>+<kbd>l</kbd> |  𝐍   | Reopen last search         |
| <kbd>Space</kbd>+<kbd>b</kbd>+<kbd>f</kbd> |  𝐍   | Buffers                    |
| <kbd>Space</kbd>+<kbd>s</kbd>+<kbd>c</kbd> |  𝐍   | Colorschemes               |
| <kbd>Space</kbd>+<kbd>s</kbd>+<kbd>C</kbd> |  𝐍   | Command history            |
| <kbd>Space</kbd>+<kbd>s</kbd>+<kbd>h</kbd> |  𝐍   | Find help                  |
| <kbd>Space</kbd>+<kbd>s</kbd>+<kbd>k</kbd> |  𝐍   | Keymap search              |
| <kbd>Space</kbd>+<kbd>s</kbd>+<kbd>M</kbd> |  𝐍   | Man Pages search           |
| <kbd>Space</kbd>+<kbd>s</kbd>+<kbd>r</kbd> |  𝐍   | Register search            |
| <kbd>Space</kbd>+<kbd>s</kbd>+<kbd>t</kbd> |  𝐕   | Grep string under cursor   |
| <kbd>Space</kbd>+<kbd>s</kbd>+<kbd>t</kbd> |  𝐍   | Grep raw                   |
| <kbd>Space</kbd>+<kbd>F</kbd>+<kbd>b</kbd> |  𝐍   | Builtin search             |
| <kbd>Space</kbd>+<kbd>F</kbd>+<kbd>f</kbd> |  𝐍   | Current buffer search      |
| <kbd>Space</kbd>+<kbd>F</kbd>+<kbd>g</kbd> |  𝐍   | Git files search           |
| <kbd>Space</kbd>+<kbd>F</kbd>+<kbd>i</kbd> |  𝐍   | Installed plugins          |
| <kbd>Space</kbd>+<kbd>F</kbd>+<kbd>p</kbd> |  𝐍   | Project search             |
| <kbd>Space</kbd>+<kbd>F</kbd>+<kbd>i</kbd> |  𝐍   | Installed plugins          |
| **in _Telescope_ window**                  |      |                            |
| <kbd>CR</kbd>                              | 𝐈 𝐍  | Multi/Single Open          |
| <kbd>Ctrl</kbd>+<kbd>c</kbd>               | 𝐈 𝐍  | Exit telescope             |
| <kbd>Ctrl</kbd>+<kbd>v</kbd>               | 𝐈 𝐍  | Open in a vertical split   |
| <kbd>Ctrl</kbd>+<kbd>s</kbd>               | 𝐈 𝐍  | Open in a split            |
| <kbd>Ctrl</kbd>+<kbd>t</kbd>               | 𝐈 𝐍  | Open in a tab              |
| <kbd>Ctrl</kbd>+<kbd>b</kbd>               |  𝐈   | Go back in Command Palette |
| <kbd>Tab</kbd>                             | 𝐈 𝐍  | Toggle Selection + Next    |
| <kbd>Shift</kbd>+<kbd>Tab</kbd>            | 𝐈 𝐍  | Toggle Selection + Prev    |

### Plugin: Harpoon

| Key                               | Mode | Action                           |
| --------------------------------- | :--: | -------------------------------- |
| <kbd>Space</kbd>+<kbd>Space</kbd> |  𝐍   | show harpoon shortlist           |
| <kbd>Space</kbd>+<kbd>a</kbd>     |  𝐍   | add file to shortlist            |
| <kbd>Space</kbd>+<kbd>1</kbd>     |  𝐍   | jump to first file on shortlist  |
| <kbd>Space</kbd>+<kbd>2</kbd>     |  𝐍   | jump to second file on shortlist |
| <kbd>Space</kbd>+<kbd>3</kbd>     |  𝐍   | jump to third file on shortlist  |
| <kbd>Space</kbd>+<kbd>4</kbd>     |  𝐍   | jump to forth file on shortlist  |

### Plugin: Neogen

| Key                                        | Mode | Action                 |
| ------------------------------------------ | :--: | ---------------------- |
| <kbd>Space</kbd>+<kbd>n</kbd>+<kbd>c</kbd> |  𝐍   | Class documentation    |
| <kbd>Space</kbd>+<kbd>n</kbd>+<kbd>f</kbd> |  𝐍   | Function documentation |
| <kbd>Space</kbd>+<kbd>n</kbd>+<kbd>t</kbd> |  𝐍   | Type documentation     |
| <kbd>Space</kbd>+<kbd>n</kbd>+<kbd>F</kbd> |  𝐍   | File documentation     |

### Plugin: Persistence

| Key                                        | Mode | Action                                |
| ------------------------------------------ | :--: | ------------------------------------- |
| <kbd>Space</kbd>+<kbd>q</kbd>+<kbd>d</kbd> |  𝐍   | quit without saving session           |
| <kbd>Space</kbd>+<kbd>q</kbd>+<kbd>l</kbd> |  𝐍   | restore last session                  |
| <kbd>Space</kbd>+<kbd>q</kbd>+<kbd>s</kbd> |  𝐍   | restore last session from current dir |

### Plugin: Bufferline

| Key                                        | Mode | Action               |
| ------------------------------------------ | :--: | -------------------- |
| <kbd>Shift</kbd>+<kbd>x</kbd>              |  𝐍   | close buffer         |
| <kbd>Space</kbd>+<kbd>b</kbd>+<kbd>f</kbd> |  𝐍   | find buffer          |
| <kbd>Space</kbd>+<kbd>b</kbd>+<kbd>b</kbd> |  𝐍   | toggle buffer groups |
| <kbd>Space</kbd>+<kbd>b</kbd>+<kbd>p</kbd> |  𝐍   | pick buffer          |
| <kbd>Space</kbd>+<kbd>b</kbd>+<kbd>1</kbd> |  𝐍   | goto buffer 1        |
| <kbd>Space</kbd>+<kbd>b</kbd>+<kbd>h</kbd> |  𝐍   | Close all to left    |
| <kbd>Space</kbd>+<kbd>b</kbd>+<kbd>l</kbd> |  𝐍   | Close all to right   |
| <kbd>Space</kbd>+<kbd>b</kbd>+<kbd>D</kbd> |  𝐍   | Sort by directory    |
| <kbd>Space</kbd>+<kbd>b</kbd>+<kbd>L</kbd> |  𝐍   | Sort by language     |

### Plugin: Trouble

| Key                                        | Mode | Action                |
| ------------------------------------------ | :--: | --------------------- |
| <kbd>Space</kbd>+<kbd>T</kbd>+<kbd>d</kbd> |  𝐍   | diagnostics           |
| <kbd>Space</kbd>+<kbd>T</kbd>+<kbd>f</kbd> |  𝐍   | definitions           |
| <kbd>Space</kbd>+<kbd>T</kbd>+<kbd>r</kbd> |  𝐍   | references            |
| <kbd>Space</kbd>+<kbd>T</kbd>+<kbd>t</kbd> |  𝐍   | todo                  |
| <kbd>Space</kbd>+<kbd>T</kbd>+<kbd>w</kbd> |  𝐍   | workspace diagnostics |

### Plugin: Ultest

| Key                                        | Mode | Action                  |
| ------------------------------------------ | :--: | ----------------------- |
| <kbd>Space</kbd>+<kbd>t</kbd>+<kbd>f</kbd> |  𝐍   | run all tests in a file |
| <kbd>Space</kbd>+<kbd>t</kbd>+<kbd>n</kbd> |  𝐍   | only run nearest test   |
| <kbd>Space</kbd>+<kbd>t</kbd>+<kbd>s</kbd> |  𝐍   | open test summary       |

### Plugin: Spectre

| Key                                        | Mode | Action                         |
| ------------------------------------------ | :--: | ------------------------------ |
| <kbd>Space</kbd>+<kbd>R</kbd>+<kbd>p</kbd> |  𝐍   | replace word in project        |
| <kbd>Space</kbd>+<kbd>R</kbd>+<kbd>w</kbd> |  𝐍   | replace visually selected word |
| <kbd>Space</kbd>+<kbd>R</kbd>+<kbd>f</kbd> |  𝐍   | replace word in current buffer |

</details>

[firacode]: https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/FiraCode/Retina
[nerd fonts]: https://www.nerdfonts.com
[neovim install]: https://github.com/neovim/neovim/wiki/Installing-Neovim
[rust install]: https://www.rust-lang.org/tools/install
[ripgrep]: https://github.com/BurntSushi/ripgrep
[fd]: https://github.com/sharkdp/fd
[nodejs install]: https://nodejs.org/en/download/package-manager/#macos
[lsp-installer]: https://github.com/williamboman/nvim-lsp-installer#available-lsps
[tex-support]: https://gist.github.com/peterhurford/75957ba9335e755013b87254ec85fab1
