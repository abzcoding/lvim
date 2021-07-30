local M = {}

M.setup = function()
  local status_ok, org_mode = pcall(require, "orgmode")
  if not status_ok then
    return
  end
  org_mode.setup {
    org_agenda_files = { "~/shared/orgs/**/*" },
    org_default_notes_file = "~/shared/orgs/refile.org",
  }
end

return M
