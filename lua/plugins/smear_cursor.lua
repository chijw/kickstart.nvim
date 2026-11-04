-- Animated "comet" cursor whose color follows the mode.
-- The real terminal cursor and the smear/particles share one catppuccin color
-- per mode: normal = lavender, insert = green, visual = mauve,
-- replace = red, command = peach, terminal = teal.

local mode_color_names = {
  n = 'lavender',
  i = 'green',
  v = 'mauve',
  V = 'mauve',
  ['\22'] = 'mauve', -- visual block
  s = 'mauve',
  S = 'mauve',
  ['\19'] = 'mauve', -- select block
  R = 'red',
  c = 'peach',
  t = 'teal',
}

local function palette()
  local ok, palettes = pcall(require, 'catppuccin.palettes')
  return ok and palettes.get_palette() or {}
end

local function mode_color(mode)
  return palette()[mode_color_names[mode:sub(1, 1)] or 'lavender']
end

-- Real cursor: one highlight group per mode. Kitty picks up the color from
-- these, so the cursor is colored even while the smear isn't animating.
local function set_cursor_highlights()
  local c = palette()
  if not c.base then
    return
  end
  for group, name in pairs {
    CursorNormal = 'lavender',
    CursorInsert = 'green',
    CursorVisual = 'mauve',
    CursorReplace = 'red',
    CursorCommand = 'peach',
    CursorTerm = 'teal',
  } do
    vim.api.nvim_set_hl(0, group, { fg = c.base, bg = c[name] })
  end
end

return {
  'sphamba/smear-cursor.nvim',
  event = 'VeryLazy',
  init = function()
    vim.o.guicursor = table.concat({
      'n-o-sm:block-CursorNormal',
      'v:block-CursorVisual',
      'c:block-CursorCommand',
      'i-ci-ve:ver25-CursorInsert',
      'r-cr:hor20-CursorReplace',
      't:block-CursorTerm',
    }, ',')
    vim.api.nvim_create_autocmd('ColorScheme', {
      group = vim.api.nvim_create_augroup('config-cursor-colors', { clear = true }),
      callback = set_cursor_highlights,
    })
    set_cursor_highlights()
  end,
  opts = {
    -- Kitty renders these block symbols itself: smooth, blended trails.
    legacy_computing_symbols_support = true,
    legacy_computing_symbols_support_vertical_bars = true,
    distance_stop_animating_vertical_bar = 0.1,

    -- Snappy head, a longer tail that catches up smoothly.
    stiffness = 0.7,
    trailing_stiffness = 0.35,
    trailing_exponent = 3,
    damping = 0.8,
    anticipation = 0.15,

    smear_insert_mode = true,
    smear_replace_mode = true,
    smear_terminal_mode = false,

    -- Sparks on jumps (not on every hjkl): they drift upward and fade out.
    particles_enabled = true,
    never_draw_over_target = true,
    min_distance_emit_particles = 3,
    particles_per_second = 300,
    particles_per_length = 2,
    particle_max_num = 120,
    particle_spread = 0.8,
    particle_max_lifetime = 450,
    particle_max_initial_velocity = 12,
    particle_velocity_from_cursor = 0.3,
    particle_random_velocity = 60,
    particle_damping = 0.2,
    particle_gravity = -25,
  },
  config = function(_, opts)
    local smear = require 'smear_cursor'
    opts.cursor_color = mode_color(vim.api.nvim_get_mode().mode)
    -- The theme is transparent; tell smear the real background so trails blend.
    opts.normal_bg = palette().base
    smear.setup(opts)

    -- Smear and particles take the color of the mode being entered.
    vim.api.nvim_create_autocmd({ 'ModeChanged', 'ColorScheme' }, {
      group = vim.api.nvim_create_augroup('config-smear-mode-color', { clear = true }),
      callback = function()
        local color = mode_color(vim.api.nvim_get_mode().mode)
        if color and smear.cursor_color ~= color then
          smear.cursor_color = color
        end
      end,
    })
  end,
}
