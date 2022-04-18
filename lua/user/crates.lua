local M = {}

M.config = function()
  local status_ok, crates = pcall(require, "crates")
  if not status_ok then
    return
  end

  crates.setup {
    smart_insert = true,
    insert_closing_quote = true,
    avoid_prerelease = true,
    autoload = true,
    autoupdate = true,
    loading_indicator = true,
    date_format = "%Y-%m-%d",
    disable_invalid_feature_diagnostic = false,
    text = {
      loading = "   Loading",
      version = "   %s",
      prerelease = "   %s",
      yanked = "   %s",
      nomatch = "   No match",
      upgrade = "   %s",
      error = "   Error fetching crate",
    },
    highlight = {
      loading = "CratesNvimLoading",
      version = "CratesNvimVersion",
      prerelease = "CratesNvimPreRelease",
      yanked = "CratesNvimYanked",
      nomatch = "CratesNvimNoMatch",
      upgrade = "CratesNvimUpgrade",
      error = "CratesNvimError",
    },
    popup = {
      autofocus = false,
      copy_register = '"',
      style = "minimal",
      border = "none",
      show_version_date = false,
      show_dependency_version = true,
      max_height = 30,
      min_width = 20,
      text = {
        title = "  %s ",
        version = "   %s ",
        prerelease = "  %s ",
        yanked = "  %s ",
        feature = "   %s ",
        enabled = "  %s ",
        transitive = "  %s ",
        version_date = " %s ",
        dependency = "   %s ",
        optional = "  %s ",
        dependency_version = " %s ",
        loading = " ",
      },
      highlight = {
        title = "CratesNvimPopupTitle",
        version = "CratesNvimPopupVersion",
        prerelease = "CratesNvimPopupPreRelease",
        yanked = "CratesNvimPopupYanked",
        version_date = "CratesNvimPopupVersionDate",
        feature = "CratesNvimPopupFeature",
        enabled = "CratesNvimPopupEnabled",
        transitive = "CratesNvimPopupTransitive",
        dependency = "CratesNvimPopupDependency",
        optional = "CratesNvimPopupOptional",
        dependency_version = "CratesNvimPopupDependencyVersion",
        loading = "CratesNvimPopupLoading",
      },
      keys = {
        hide = { "q", "<esc>" },
        select = { "<cr>" },
        select_alt = { "s" },
        copy_version = { "yy" },
        toggle_feature = { "<cr>" },
        goto_item = { "gd", "K" },
        jump_forward = { "<c-i>" },
        jump_back = { "<c-o>" },
      },
    },
    src = {
      insert_closing_quote = true,
      text = {
        prerelease = "  pre-release ",
        yanked = "  yanked ",
      },
    },
  }
end

return M
