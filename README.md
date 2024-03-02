# Wiwiweb's Balatro mods

## Install
1) Install the SteamMod Balatro Mod loader [(Follow the install instructions here)](https://github.com/Steamopollys/Steamodded/tree/main?tab=readme-ov-file#installation)
2) Click on the lua file for the mod you want from this repository.
3) Download the lua file by clicking the "Download raw file" button:
   
![image](https://github.com/Wiwiweb/BalatroMods/assets/4723472/554dd94d-54c6-4c64-836b-4060f2f8be20)

4) Put the lua file in your mods folder (`%appdata%\Balatro\Mods`)

### FasterStakesUnlock

<img src="https://github.com/Wiwiweb/BalatroMods/assets/4723472/a574cb65-d7bf-433b-a86f-e08511d7aca8" width="320">
<img src="https://github.com/Wiwiweb/BalatroMods/assets/4723472/bfa74929-e425-437c-8320-5e7030007ee4" width="320">

Easy stakes make you bored but you want to try different decks? Reduce the grind with this mod. If you have a win with a stake on any deck, the stake 2 levels below will be available for *all* decks.

Example in the pictures: I have a win with the Black stake on Ghost deck (First picture). Now the Red stake is available for all decks (Second picture).

Note that the squares for the stakes only become colored when you actually have a win for that stake. So in the second picture, the White stake square is still grey and not white. This is the same behaviour as the vanilla "Unlock all" button.

This mod does not touch your save file at all, it calculates available stakes on the fly, so you can remove it any time and it will be back to normal.

You can modify the `NB_RANKS_BELOW_WIN_TO_UNLOCK = 2` line at the top to customize. If you just want stake unlocks to be shared by all decks, set it to `-1`.

### HoldForFinalHandScore

https://github.com/Wiwiweb/BalatroMods/assets/4723472/933f5a99-38a1-4c7f-a3ad-ff1e9bbbd902

The hand score goes away too fast in vanilla, especially for big hands that increase the game speed a lot. Not only can you not see your score, which may be important for decisions, but it's also very anticlimactic to spend so much time building up the score and not spend a second seeing your result.

Details:
* Resets game speed acceleration right before the final Chip X Mult.
* Pauses 1.5 seconds (affected by game speed) for the final Chip X Mult, before it turns into the final hand score.
* Pauses for the final hand score before it gets added to the round score. It waits for the flames to die down, or if there are no flames, it waits 1 second.

I quite like the dramatic reveal of the hand score as the flames goes down. I didn't do that on purpose but it's cool.
