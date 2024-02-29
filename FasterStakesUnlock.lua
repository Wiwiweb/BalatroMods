--- STEAMODDED HEADER
--- MOD_NAME: Faster Stakes Unlock
--- MOD_ID: FasterStakesUnlock
--- MOD_AUTHOR: [Wiwiweb]
--- MOD_DESCRIPTION: Winning a run with a stake unlocks the stake 2 levels below for all decks. Example: If you have a 4th stake win on any deck, the 2nd stake will be available for all decks. Does not change your save file, mod can be uninstalled safely.

----------------------------------------------
------------MOD CODE -------------------------

-- Modify NB_RANKS_BELOW_WIN_TO_UNLOCK as you want. 
-- Default is 2, so winning with the 4th stake unlocks 2nd stake for all decks.
-- Set to -1 to have the same stakes unlocked for all decks, so winning with the 4th stake unlocks the 5th stake for all decks.
local NB_RANKS_BELOW_WIN_TO_UNLOCK = 2

local function get_min_stake_available()
  local highest_win, _lowest_win = get_deck_win_stake()
  return highest_win - NB_RANKS_BELOW_WIN_TO_UNLOCK
end

local function get_max_stake_for_deck(deck_key)
  local win_stake = get_deck_win_stake(deck_key)
  local min_stake = get_min_stake_available()
  local max_stake = math.max(win_stake+1, min_stake)
  if G.PROFILES[G.SETTINGS.profile].all_unlocked then max_stake = 8 end
  return max_stake
end

local deck_stake_column_ref = G.UIDEF.deck_stake_column
function G.UIDEF.deck_stake_column(_deck_key)
  local output = deck_stake_column_ref(_deck_key)

  local min_stake = get_min_stake_available()
  for _, node in ipairs(output.nodes) do
    if node.config.id and node.config.id <= min_stake then
      node.config.minw = 0.45
      node.nodes[1].config.minh = 0.17
      node.nodes[1].config.minw = 0.37
    end
  end
  return output
end

function G.UIDEF.stake_option(_type)
  local middle = {n=G.UIT.R, config={align = "cm", minh = 1.7, minw = 7.3}, nodes={
    {n=G.UIT.O, config={id = nil, func = 'RUN_SETUP_check_stake2', object = Moveable()}},
    }}

  local max_stake = get_max_stake_for_deck(G.GAME.viewed_back.effect.center.key)
  local stake_options = {}
  for i = 1, math.min(max_stake, 8) do
    stake_options[i] = i
  end

  return  {n=G.UIT.ROOT, config={align = "tm", colour = G.C.CLEAR, minh = 2.03, minw = 8.3}, nodes={_type == 'Continue' and middle or create_option_cycle({options = 
  stake_options,
  opt_callback = 'change_stake', current_option = G.viewed_stake, colour = G.C.RED, w = 6, mid = middle
  })
}}
end

function G.UIDEF.viewed_stake_option()
  G.viewed_stake = G.viewed_stake or 1
  local max_stake = get_max_stake_for_deck(G.GAME.viewed_back.effect.center.key)
  if G.PROFILES[G.SETTINGS.profile].all_unlocked then max_stake = 8 end

  G.viewed_stake = math.min(max_stake, G.viewed_stake)
  if _type ~= 'Continue' then G.PROFILES[G.SETTINGS.profile].MEMORY.stake = G.viewed_stake end

  local stake_sprite = get_stake_sprite(G.viewed_stake)

  return  {n=G.UIT.ROOT, config={align = "cm", colour = G.C.BLACK, r = 0.1}, nodes={
    {n=G.UIT.C, config={align = "cm", padding = 0}, nodes={
      {n=G.UIT.T, config={text = localize('k_stake'), scale = 0.4, colour = G.C.L_BLACK, vert = true}}
    }},
    {n=G.UIT.C, config={align = "cm", padding = 0.1}, nodes={
      {n=G.UIT.C, config={align = "cm", padding = 0}, nodes={
        {n=G.UIT.O, config={colour = G.C.BLUE, object = stake_sprite, hover = true, can_collide = false}},
      }},
      G.UIDEF.stake_description(G.viewed_stake)
    }}
  }}
end


----------------------------------------------
------------MOD CODE END----------------------
