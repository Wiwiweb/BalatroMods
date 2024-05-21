--- STEAMODDED HEADER
--- MOD_NAME: Hold For Final Hand Score
--- MOD_ID: HoldForFinalHandScore
--- MOD_AUTHOR: [Wiwiweb]
--- MOD_DESCRIPTION: <WARNING: BUGGY!> Pauses a moment for the final Chip X Mult count, and another moment for the final hand chip total. Especially noticeable on big hands that trigger flames.

---------------------------------------------------------------------------------------------------------------------------------------
---BEWARE, THIS MOD IS BUGGY AND I UNFORTUNATELY DON'T HAVE THE TIME TO TRY AND FIX IT!
---Known issues:
--- * Prevents the special effects from the Anaglyph and Plasma decks.
--- * Softlocks the game if you get a naneinf score.
---------------------------------------------------------------------------------------------------------------------------------------

----------------------------------------------
------------MOD CODE -------------------------

-- Those values are affected by your Game Speed settings. So 1 second at 2x gamespeed will only last 0.5 seconds.
local SECONDS_PAUSED_ON_FINAL_CHIP_X_MULT = 1.5
local MIN_SECONDS_PAUSED_ON_HAND_CHIP_TOTAL = 1 -- This delay is only for hands without flames. Otherwise the pause just waits for flames to die down.


-- Pause on final chip*mult.
-- Ugly place to hook, but it's the best method triggered just *before* the "update_hand_text" call we are targetting.
local back_trigger_effects_ref = Back.trigger_effect
function Back:trigger_effect(args)
  if args.context == 'final_scoring_step' then
    G.E_MANAGER:add_event(Event({
      trigger = 'before',
      delay = SECONDS_PAUSED_ON_FINAL_CHIP_X_MULT,
      func = function()
        G.ACC = 0 -- Reset acceleration
        return true
      end
    }))
  end
  return back_trigger_effects_ref(args)
end

-- Pause on hand chip total.
-- Also an ugly place to hook, but it's the best method triggered just *after* the "update_hand_text" call we are targetting.
local check_and_set_high_score_ref = check_and_set_high_score
function check_and_set_high_score(score, amt)
  if score == 'hand' then
    G.E_MANAGER:add_event(Event({
      trigger = 'before',
      delay = MIN_SECONDS_PAUSED_ON_HAND_CHIP_TOTAL, -- Minimum delay
      func = function()
        G.ACC = 0 -- Reset acceleration again just in case
        -- Wait until flames die down so total hand chips is visible (also makes for a dramatic pause after a big hand)
        return G.ARGS.chip_flames.real_intensity < 0.5
      end
    }))
  end
  return check_and_set_high_score_ref(score, amt)
end

----------------------------------------------
------------MOD CODE END----------------------
