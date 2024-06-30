local M = {}

M.config = function()
  local ok, pj = pcall(require, "new-project")
  if not ok then
    return
  end
  pj.setup {
    detection_methods = { "lsp", "pattern" },
    patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "pom.xml" },
    datapath = get_cache_dir(),
  }
end

return M
