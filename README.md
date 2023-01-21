# Bloated LunarVim

Do not use as is, use it as a source of inspiration.

I've customized my ZSH/Tmux/[Wezterm](https://github.com/abzcoding/wezterm) too much, so it might not work properly 😅

![141789968-ed61958c-9154-4774-b2e2-dfabe48d9660](https://user-images.githubusercontent.com/10992695/141791560-5062246a-056c-4a73-afa7-3152e6ad396e.jpg)

<details open>
  <summary>
    <strong>Table of Contents</strong>
    <small><i>(🔎 Click to expand/collapse)</i></small>
  </summary>

<!-- vim-markdown-toc GFM -->

- [Theme](#theme)
- [Customization](#customization)
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
  - [Plugin: Neotest](#plugin-neotest)
  - [Plugin: Spectre](#plugin-spectre)
  - [Plugin: SSR](#plugin-ssr)
  - [Plugin: Copilot](#plugin-copilot)
  - [Plugin: Lsp_Lines](#plugin-lsp_lines)
  - [Plugin: Overseer](#plugin-overseer)
  - [Plugin: NeoTree](#plugin-neotree)
  - [Plugin: Mind](#plugin-mind)
- [Troubleshooting](#troubleshooting)

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
or just disable it and install your own theme

```lua
lvim.colorscheme = "catppuccin"
lvim.builtin.time_based_themes = false
lvim.plugins = {
  {
    "catppuccin/nvim",
    as = "catppuccin",
    config = function()
      require("catppuccin").setup()
    end,
  }
}
```

## Customization

<details>
  <summary>
    <strong>Customization</strong>
    <small><i>(🔎 Click to expand/collapse)</i></small>
  </summary>

- I'm on [this PR](https://github.com/LunarVim/LunarVim/pull/2544) of LunarVim and i am using `neovim 0.9 head`
- Do not use as is, too much bloated! Also do not use on a potato PC!!
- i have a auto command to disable syntax,etc when you open files larger than `1MB`
- if you don't want to use `harpoon`, disable it
  - `lvim.builtin.harpoon = { active = false }`
- if you want to try out GitHub copilot, change the following
  - `lvim.builtin.sell_your_soul_to_devil = { active = true, prada = false }`
  - in case you want to use `cmp-copilot`, set `prada=true` after copilot installation
- I use a custom `lualine` disable it if you don't like it
  - `lvim.builtin.fancy_statusline = { active = false }`
- You can use the `diffview` plugin instead of normal `gitsigns diff`
  - `lvim.builtin.fancy_diff = { active = true }`
- if you want to use debugging, change the following line to true, also [install codelldb](<https://github.com/mfussenegger/nvim-dap/wiki/C-C---Rust-(via--codelldb)>):
  - `lvim.builtin.dap.active = true`
- sometimes instead of saving you jump trough jumplist 😢 just disable nvim-lastplace
  - `lvim.builtin.lastplace = { active = false }`
- sometimes `compe-tabnine` doesn't play nice, you can disable it :)
  - `lvim.builtin.tabnine = { active = false }`
- if you don't need testing, just disable it (use `ultest` or `neotest`)
  - `lvim.builtin.test_runner = { active = false, runner = "ultest" }`
- if you don't want [cheat.sh](http://cheat.sh) integration, disable it
  - `lvim.builtin.cheat = { active = false }`
- if you don't want the SQL integration, disable it
  - `lvim.builtin.sql_integration = { active = false }`
- if you don't like smooth scrolling, disable it
  - `lvim.builtin.smooth_scroll= ""`
- if you want an obvious focused window, and you don't get seizures from it
  - `lvim.builtin.nonumber_unfocus = true`
- choose between [hop](https://github.com/phaazon/hop.nvim) and [leap](https://github.com/ggandor/leap.nvim) as your favorite motion provider
  - `lvim.builtin.motion_provider = "hop"`
- choose between [filename->incline](https://github.com/b0o/incline.nvim) and [treesitter->winbar](https://github.com/fgheng/winbar.nvim) or [navic](https://github.com/SmiteshP/nvim-navic) as your winbar provider
  - `lvim.builtin.winbar_provider = "treesitter"`
- if you don't need CSV support, disable it
  - `lvim.builtin.csv_support = false`
- if you want to use the cool make and run system, enable it
  - `lvim.builtin.task_runner = "async_tasks"`
- you can choose between `nvimtree` and `neo-tree` as your file tree viewer
  - `lvim.builtin.tree_provider = "neo-tree"`
- you can use noice.nvim if you want
  - `lvim.builtin.noice = { active = true }`
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

- [Neovim](neovim-install) >= v0.8.0

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
lvim # run :Lazy sync
```

### Java

Please run the following to have a better debugging and testing support for java

```shell
mkdir -p ~/workspace
git clone git@github.com:microsoft/java-debug.git ~/.config/lvim/.java-debug
cd ~/.config/lvim/.java-debug/
./mvnw clean install
git clone git@github.com:microsoft/vscode-java-test.git ~/.config/lvim/.vscode-java-test
cd ~/.config/lvim/.vscode-java-test
npm install
npm run build-plugin
```

### Recommended Fonts

- [FiraCode]: My preferred nerd font
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
file in Neovim, run `:MasonInstall <server>` to use
[mason](mason) installation feature.
Use `Tab` to list available servers.

## Upgrade

```shell
cd ~/.config/lvim
git pull
lvim # run :Lazy sync
```

### Recommended Linters

You can use [mason](mason) to install these:

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

- [Doom One Theme](https://github.com/NTBBloodbath/doom-one.nvim)
- [Rose Pine Theme](https://github.com/rose-pine/neovim)
- [LSP Signature](https://github.com/ray-x/lsp_signature.nvim/)
- [Todo Comments](https://github.com/folke/todo-comments.nvim)
- [Trouble](https://github.com/folke/trouble.nvim)
- [symbols-outline.nvim](https://github.com/simrat39/symbols-outline.nvim)
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
- [typescript.nvim](https://github.com/jose-elias-alvarez/typescript.nvim)
- [flutter-tools.nvim](https://github.com/akinsho/flutter-tools.nvim)
- [NeoClip](https://github.com/AckslD/nvim-neoclip.lua)
- [Telescope live grep args](nvim-telescope/telescope-live-grep-args.nvim)
- [fidget](https://github.com/j-hui/fidget.nvim)
- [clangd_extensions.nvim](https://github.com/p00f/clangd_extensions.nvim)
- [crates.nvim](https://github.com/Saecki/crates.nvim)
- [refactoring.nvim](https://github.com/ThePrimeagen/refactoring.nvim)
- [ssr.nvim](https://github.com/cshuaimin/ssr.nvim)

### Optional Plugins

- [Hop](https://github.com/phaazon/hop.nvim)
- [Leap](https://github.com/ggandor/leap.nvim)
- [remember.nvim](https://github.com/vladdoster/remember.nvim)
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
- [Cinnamon scroll](https://github.com/declancm/cinnamon.nvim)
- [Copilot](https://github.com/github/copilot.vim)
- [Harpoon](https://github.com/ThePrimeagen/harpoon)
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
- [dressing.nvim](https://github.com/stevearc/dressing.nvim)
- [incline.nvim](https://github.com/b0o/incline.nvim)
- [winbar.nvim](https://github.com/fgheng/winbar.nvim)
- [lsp_lines.nvim](https://git.sr.ht/~whynothugo/lsp_lines.nvim)
- [neotest](https://github.com/nvim-neotest/neotest)
- [legendary.nvim](https://github.com/mrjones2014/legendary.nvim)
- [overseer.nvim](https://github.com/stevearc/overseer.nvim)
- [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim/blob/v2.x)
- [noice.nvim](https://github.com/folke/noice.nvim)
- [nvim-dap-vscode-js](https://github.com/mxsdev/nvim-dap-vscode-js)
- [inc-rename](https://github.com/smjonas/inc-rename.nvim)
- [hlargs.nvim](https://github.com/m-demare/hlargs.nvim)
- [cmake-tools.nvim](https://github.com/Civitasv/cmake-tools.nvim)
- [lsp-inlayhints.nvim](https://github.com/lvimuser/lsp-inlayhints.nvim)
- [mind.nvim](https://github.com/phaazon/mind.nvim)

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

| Key                                                           | Mode | Action              | Plugin or Mapping                             |
| ------------------------------------------------------------- | :--: | ------------------- | --------------------------------------------- |
| <kbd>Space</kbd>+<kbd>e</kbd>                                 |  𝐍   | Open file tree      | <small>NvimTree</small>                       |
| <kbd>Space</kbd>+<kbd>o</kbd>                                 |  𝐍   | Open symbols        | <small>Symbols-outline</small>                |
| <kbd>Space</kbd>+<kbd>f</kbd>                                 |  𝐍   | Open file finder    | <small>Telescope</small>                      |
| <kbd>Space</kbd>+<kbd>h</kbd>                                 |  𝐍   | Remove highlight    | <small>`nohlsearch<`</small>                  |
| <kbd>Space</kbd>+<kbd>/</kbd>                                 |  𝐍   | Toggle comment      | <small>Comment.nvim</small>                   |
| <kbd>Space</kbd>+<kbd>?</kbd>                                 |  𝐍   | Open cheats         | <small>cheat.sh</small>                       |
| <kbd>Space</kbd>+<kbd>'</kbd>                                 |  𝐍   | Open marks          | <small>which-key marks</small>                |
| <kbd>Space</kbd>+<kbd>z</kbd>                                 |  𝐍   | Zen mode            | <small>zen-mode.nvim</small>                  |
| <kbd>Space</kbd>+<kbd>P</kbd>                                 |  𝐍   | Projects            | <small>project.nvim</small>                   |
| <kbd>Ctrl</kbd>+<kbd>\</kbd>                                  | 𝐈 𝐍  | Open terminal       | <small>toggleterm.nvim</small>                |
| <kbd>Alt</kbd>+<kbd>0</kbd>                                   | 𝐈 𝐍  | Vertical terminal   | <small>toggleterm.nvim</small>                |
| <kbd>Ctrl</kbd>+<kbd>s</kbd>                                  |  𝐈   | Show signature help | <small>`vim.lsp.buf.signature_help()`</small> |
| <kbd>Alt</kbd>+<kbd>s</kbd>                                   |  𝐈   | Snippet selection   | <small>Telescope luasnip extension</small>    |
| <kbd>Space</kbd>+<kbd>C</kbd> or <kbd>Ctrl</kbd>+<kbd>P</kbd> |  𝐍   | Command Palette     | <small>legendary.nvim</small>                 |

### Motion

| Key                         | Mode | Action                  | Plugin or Mapping                                             |
| --------------------------- | :--: | ----------------------- | ------------------------------------------------------------- |
| <kbd>f</kbd>                |  𝐍   | find next character     | <small>HopChar1CurrentLineAC</small> or <small>leap_f</small> |
| <kbd>F</kbd>                |  𝐍   | find previous character | <small>HopChar1CurrentLineBC</small> or <small>leap_F</small> |
| <kbd>s</kbd>                |  𝐍   | find character          | <small>HopChar2MW</small> or <small>leap_s</small>            |
| <kbd>S</kbd>                |  𝐍   | find word               | <small>HopWordMW</small> or <small>leap_S</small>             |
| <kbd>Alt</kbd>+<kbd>a</kbd> |  𝐈   | select all              | <small>ggVG</small>                                           |
| <kbd>Alt</kbd>+<kbd>a</kbd> |  𝐍   | increment number        | <small>C-A</small>                                            |
| <kbd>Alt</kbd>+<kbd>x</kbd> |  𝐍   | decrement number        | <small>C-X</small>                                            |

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
| <kbd>Space</kbd>+<kbd>g</kbd>+<kbd>d</kbd>                                               |  𝐍   | Diff to head           |
| <kbd>Space</kbd>+<kbd>g</kbd>+<kbd>h</kbd>                                               |  𝐍   | Buffer git history     |
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
| <kbd>Space</kbd>+<kbd>Space</kbd> |  𝐍   | Show harpoon shortlist           |
| <kbd>Space</kbd>+<kbd>a</kbd>     |  𝐍   | Add file to shortlist            |
| <kbd>Space</kbd>+<kbd>1</kbd>     |  𝐍   | Jump to first file on shortlist  |
| <kbd>Space</kbd>+<kbd>2</kbd>     |  𝐍   | Jump to second file on shortlist |
| <kbd>Space</kbd>+<kbd>3</kbd>     |  𝐍   | Jump to third file on shortlist  |
| <kbd>Space</kbd>+<kbd>4</kbd>     |  𝐍   | Jump to forth file on shortlist  |

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
| <kbd>Space</kbd>+<kbd>q</kbd>+<kbd>d</kbd> |  𝐍   | Quit without saving session           |
| <kbd>Space</kbd>+<kbd>q</kbd>+<kbd>l</kbd> |  𝐍   | Restore last session                  |
| <kbd>Space</kbd>+<kbd>q</kbd>+<kbd>s</kbd> |  𝐍   | Restore last session from current dir |

### Plugin: Bufferline

| Key                                        | Mode | Action               |
| ------------------------------------------ | :--: | -------------------- |
| <kbd>Shift</kbd>+<kbd>x</kbd>              |  𝐍   | Close buffer         |
| <kbd>Space</kbd>+<kbd>b</kbd>+<kbd>f</kbd> |  𝐍   | Find buffer          |
| <kbd>Space</kbd>+<kbd>b</kbd>+<kbd>b</kbd> |  𝐍   | Toggle buffer groups |
| <kbd>Space</kbd>+<kbd>b</kbd>+<kbd>p</kbd> |  𝐍   | Toggle pin           |
| <kbd>Space</kbd>+<kbd>b</kbd>+<kbd>s</kbd> |  𝐍   | Pick buffer          |
| <kbd>Space</kbd>+<kbd>b</kbd>+<kbd>1</kbd> |  𝐍   | Goto buffer 1        |
| <kbd>Space</kbd>+<kbd>b</kbd>+<kbd>h</kbd> |  𝐍   | Close all to left    |
| <kbd>Space</kbd>+<kbd>b</kbd>+<kbd>l</kbd> |  𝐍   | Close all to right   |
| <kbd>Space</kbd>+<kbd>b</kbd>+<kbd>D</kbd> |  𝐍   | Sort by directory    |
| <kbd>Space</kbd>+<kbd>b</kbd>+<kbd>L</kbd> |  𝐍   | Sort by language     |

### Plugin: Trouble

| Key                                        | Mode | Action                |
| ------------------------------------------ | :--: | --------------------- |
| <kbd>Space</kbd>+<kbd>T</kbd>+<kbd>d</kbd> |  𝐍   | Diagnostics           |
| <kbd>Space</kbd>+<kbd>T</kbd>+<kbd>f</kbd> |  𝐍   | Definitions           |
| <kbd>Space</kbd>+<kbd>T</kbd>+<kbd>r</kbd> |  𝐍   | References            |
| <kbd>Space</kbd>+<kbd>T</kbd>+<kbd>t</kbd> |  𝐍   | Todo                  |
| <kbd>Space</kbd>+<kbd>T</kbd>+<kbd>w</kbd> |  𝐍   | Workspace diagnostics |

### Plugin: Ultest

| Key                                        | Mode | Action                  |
| ------------------------------------------ | :--: | ----------------------- |
| <kbd>Space</kbd>+<kbd>t</kbd>+<kbd>f</kbd> |  𝐍   | Run all tests in a file |
| <kbd>Space</kbd>+<kbd>t</kbd>+<kbd>n</kbd> |  𝐍   | Only run nearest test   |
| <kbd>Space</kbd>+<kbd>t</kbd>+<kbd>s</kbd> |  𝐍   | Open test summary       |

### Plugin: Neotest

| Key                                        | Mode | Action                       |
| ------------------------------------------ | :--: | ---------------------------- |
| <kbd>Space</kbd>+<kbd>t</kbd>+<kbd>a</kbd> |  𝐍   | Run all tests                |
| <kbd>Space</kbd>+<kbd>t</kbd>+<kbd>f</kbd> |  𝐍   | Run tests in a file          |
| <kbd>Space</kbd>+<kbd>t</kbd>+<kbd>r</kbd> |  𝐍   | Only run nearest test        |
| <kbd>Space</kbd>+<kbd>t</kbd>+<kbd>s</kbd> |  𝐍   | Open test summary            |
| <kbd>Space</kbd>+<kbd>t</kbd>+<kbd>o</kbd> |  𝐍   | Open test output             |
| <kbd>Space</kbd>+<kbd>t</kbd>+<kbd>w</kbd> |  𝐍   | Watch test                   |
| <kbd>Space</kbd>+<kbd>t</kbd>+<kbd>x</kbd> |  𝐍   | Stop test                    |
| <kbd>Space</kbd>+<kbd>t</kbd>+<kbd>n</kbd> |  𝐍   | Jump to next failed test     |
| <kbd>Space</kbd>+<kbd>t</kbd>+<kbd>p</kbd> |  𝐍   | Jump to previous failed test |
| <kbd>Space</kbd>+<kbd>t</kbd>+<kbd>c</kbd> |  𝐍   | Cancel test                  |

### Plugin: Spectre

| Key                                        | Mode | Action                         |
| ------------------------------------------ | :--: | ------------------------------ |
| <kbd>Space</kbd>+<kbd>R</kbd>+<kbd>p</kbd> |  𝐍   | Replace word in project        |
| <kbd>Space</kbd>+<kbd>R</kbd>+<kbd>w</kbd> |  𝐍   | Replace visually selected word |
| <kbd>Space</kbd>+<kbd>R</kbd>+<kbd>f</kbd> |  𝐍   | Replace word in current buffer |

### Plugin: SSR

| Key                                        | Mode | Action                                          |
| ------------------------------------------ | :--: | ----------------------------------------------- |
| <kbd>Space</kbd>+<kbd>r</kbd>              |  𝐕   | Structural replace confirm using `<leader><cr>` |
| <kbd>Space</kbd>+<kbd>R</kbd>+<kbd>s</kbd> |  𝐍   | Structural replace confirm using `<leader><cr>` |

### Plugin: Copilot

| Key                          | Mode | Action                              |
| ---------------------------- | :--: | ----------------------------------- |
| <kbd>Ctrl</kbd>+<kbd>h</kbd> |  𝐈   | `copilot#Accept("<CR>")`            |
| <kbd>Ctrl</kbd>+<kbd>e</kbd> |  𝐈   | Close cmp menu                      |
| <kbd>Ctrl</kbd>+<kbd>]</kbd> |  𝐈   | `<Plug>(copilot-dismiss)`           |
| <kbd>Alt</kbd>+<kbd>]</kbd>  |  𝐈   | `<Plug>(copilot-next)`              |
| <kbd>Alt</kbd>+<kbd>[</kbd>  |  𝐈   | `<Plug>(copilot-previous)`          |
| <kbd>Alt</kbd>+<kbd>\</kbd>  |  𝐈   | `"<Cmd>vertical Copilot panel<CR>"` |

### Plugin: Lsp_Lines

| Key                           | Mode | Action                   |
| ----------------------------- | :--: | ------------------------ |
| <kbd>Space</kbd>+<kbd>v</kbd> |  𝐍   | Toggle showing lsp_lines |

### Plugin: Overseer

| Key                                        | Mode | Action           |
| ------------------------------------------ | :--: | ---------------- |
| <kbd>Space</kbd>+<kbd>r</kbd>+<kbd>f</kbd> |  𝐍   | Run              |
| <kbd>Space</kbd>+<kbd>r</kbd>+<kbd>p</kbd> |  𝐍   | Run with cmd     |
| <kbd>Space</kbd>+<kbd>r</kbd>+<kbd>t</kbd> |  𝐍   | Toggle output    |
| <kbd>Space</kbd>+<kbd>m</kbd>+<kbd>n</kbd> |  𝐍   | New Task         |
| <kbd>Space</kbd>+<kbd>m</kbd>+<kbd>l</kbd> |  𝐍   | Load Task Bundle |
| <kbd>Space</kbd>+<kbd>m</kbd>+<kbd>s</kbd> |  𝐍   | Save Task Bundle |
| <kbd>Space</kbd>+<kbd>m</kbd>+<kbd>q</kbd> |  𝐍   | Quick Action     |
| <kbd>Space</kbd>+<kbd>m</kbd>+<kbd>f</kbd> |  𝐍   | Task Action      |

### Plugin: NeoTree

| Key                           | Mode | Action                           |
| ----------------------------- | :--: | -------------------------------- |
| <kbd>Space</kbd>+<kbd>e</kbd> |  𝐍   | Toggle tree                      |
| <kbd>></kbd> and <kbd><</kbd> |  𝐍   | Next and prev source inside tree |
| <kbd><cr></kbd>               |  𝐍   | Open                             |
| <kbd>s</kbd>                  |  𝐍   | Open in vertical split           |
| <kbd>S</kbd>                  |  𝐍   | Open in horizontal spit          |
| <kbd>H</kbd>                  |  𝐍   | Toggle hidden files              |
| <kbd>a</kbd>                  |  𝐍   | Add files/dirs                   |
| <kbd>A</kbd>                  |  𝐍   | Add new dir                      |
| <kbd>r</kbd>                  |  𝐍   | Rename                           |
| <kbd>h</kbd>                  |  𝐍   | Go Updir                         |
| <kbd>l</kbd>                  |  𝐍   | Open                             |
| <kbd>P</kbd>                  |  𝐍   | Toggle preview                   |
| <kbd>/</kbd>                  |  𝐍   | Fuzzy finder                     |

### Plugin: Mind

| Key                                        | Mode | Action            |
| ------------------------------------------ | :--: | ----------------- |
| <kbd>Space</kbd>+<kbd>M</kbd>+<kbd>M</kbd> |  𝐍   | Open Main Tree    |
| <kbd>Space</kbd>+<kbd>M</kbd>+<kbd>m</kbd> |  𝐍   | Open Local Tree   |
| <kbd><cr></kbd>                            |  𝐍   | open data         |
| <kbd><tab></kbd>                           |  𝐍   | toggle node       |
| <kbd><s-tab></kbd>                         |  𝐍   | toggle parent     |
| <kbd>/</kbd>                               |  𝐍   | select path       |
| <kbd>$</kbd>                               |  𝐍   | change icons menu |
| <kbd>c</kbd>                               |  𝐍   | create new node   |
| <kbd>q</kbd>                               |  𝐍   | quit              |

</details>

[firacode]: https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/FiraCode/Retina
[nerd fonts]: https://www.nerdfonts.com
[neovim install]: https://github.com/neovim/neovim/wiki/Installing-Neovim
[rust install]: https://www.rust-lang.org/tools/install
[ripgrep]: https://github.com/BurntSushi/ripgrep
[fd]: https://github.com/sharkdp/fd
[nodejs install]: https://nodejs.org/en/download/package-manager/#macos
[mason]: https://github.com/williamboman/mason.nvim
[tex-support]: https://gist.github.com/peterhurford/75957ba9335e755013b87254ec85fab1

# Troubleshooting

1. Check your neovim version. Are you on the newest nightly version?
2. Reset your packer cache, and update lvim.
