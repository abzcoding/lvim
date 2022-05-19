local M = {}

M.config = function()
  local status_ok, lightspeed = pcall(require, "lightspeed")
  if not status_ok then
    return
  end

  lightspeed.setup {
    exit_after_idle_msecs = { labeled = 1500, unlabeled = 1000 },
    jump_to_unique_chars = true,
    match_only_the_start_of_same_char_seqs = true,
    limit_ft_matches = 4,
    lightspeed_x = "<c-x>",
    substitute_chars = { ["\r"] = "¬" },
    instant_repeat_fwd_key = nil,
    instant_repeat_bwd_key = nil,
    -- If no values are given, these will be set at runtime,
    -- based on `jump_to_first_match`.
    labels = nil,
    cycle_group_fwd_key = nil,
    cycle_group_bwd_key = nil,
  }
  require("user.keybindings").set_lightspeed_keymaps()
end

return M
