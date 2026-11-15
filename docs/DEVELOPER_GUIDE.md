# Omlet Custom Packs — Developer Guide

This repository holds the datapack and resource pack for the Omlet Minecraft server. This guide explains every feature, what each file does, how the packs fit together, and how to install and work on them.

- **Target game version:** Minecraft Java 26.3
- **Datapack:** `Omlet_Datapack/` (namespace `omlet_dp`, pack formats 101–121)
- **Resource pack:** `Omlet_ResourcePack/` (namespace `omlet_rp`, pack formats 72–97.1)

The two packs are designed to be used together. The datapack adds the gameplay, and the resource pack supplies the sounds, textures and models that gameplay refers to. Without the resource pack the features still work, but custom paintings show the missing texture, custom sounds are silent, and the torch arrow, gun, industrial light and player saddle show their base items (arrow, carrot on a stick, item frame, leather chestplate) instead of their custom models.

---

## Contents

1. [Installation](#installation)
2. [Features](#features)
3. [Repository layout](#repository-layout)
4. [Datapack file reference](#datapack-file-reference)
5. [Resource pack file reference](#resource-pack-file-reference)
6. [Scoreboards, tags and storage](#scoreboards-tags-and-storage)
7. [Development workflow](#development-workflow)
8. [Gotchas for Minecraft 26.x](#gotchas-for-minecraft-26x)
9. [Known issues](#known-issues)

---

## Installation

### Single-player or a LAN world

1. **Datapack:** copy the `Omlet_Datapack` folder (or a zip of it) into `<.minecraft>/saves/<World Name>/datapacks/`.
2. **Resource pack:** copy the `Omlet_ResourcePack` folder (or a zip of it) into `<.minecraft>/resourcepacks/`, then enable it in *Options → Resource Packs*.
3. **Restart the world.** Exit to the title screen and reopen it. A plain `/reload` is **not** enough the first time, because the flatworld dimension is only registered when the world loads. After that, `/reload` picks up changes to functions, recipes, predicates and so on.
4. You should see **"Omlet Datapack loaded successfully!"** in light purple in chat, followed by the datapack version (e.g. `26.3_10.3`, set in `load.mcfunction`). If you don't, check `/datapack list` and the game log for errors. A single invalid JSON file can stop the whole datapack loading.

When creating a new world you can instead add the datapack from the *Data Packs* button on the world creation screen.

### Dedicated server

1. Stop the server.
2. Copy `Omlet_Datapack` into `<server>/<level-name>/datapacks/`. `level-name` is set in `server.properties` and is usually `world`.
3. Start the server. Confirm with `/datapack list` that `file/Omlet_Datapack` is enabled.
4. For the resource pack, either:
   - give players the zip to install themselves, or
   - host the zip somewhere with a direct download link and set `resource-pack=<url>` and `resource-pack-sha1=<sha1 of the zip>` in `server.properties`. Set `require-resource-pack=true` if it should be mandatory.

### Release zips

Locally built releases are kept in `versions/`. This folder is git-ignored, so new zips only exist on the machine that built them (the older `Omlet MC - Custom Packs v1.0.zip` was committed before the ignore rule). When zipping a pack yourself, `pack.mcmeta` must be at the **root** of the zip, not inside a subfolder.

`.github/workflows/release.yml` builds release zips automatically. When a pull request into `main` is opened or updated **from the `develop` branch**, it zips both packs (`omletsmp_datapack.zip`, `omletsmp_resourcepack.zip`) and uploads them to a **draft** GitHub release tagged `pr-<PR number>`, replacing the zips on each push. Publish the draft by hand once the PR is merged.

### Developer install with `reload-files.sh`

`reload-files.sh` copies both pack folders straight into a test world so you don't have to copy them by hand after every change:

```bash
./reload-files.sh
```

It replaces the destination folders completely, so deleted or renamed files don't linger. Then run `/reload` in-game and press F3+T to reload the resource pack.

The defaults are below. Override any of them in a `.env` file at the repo root, which is git-ignored, or as environment variables:

| Variable | Default |
|---|---|
| `MINECRAFT_DIR` | `$HOME/.minecraft` |
| `WORLD_NAME` | `Test World` |
| `DATAPACK_DEST` | `$MINECRAFT_DIR/saves/$WORLD_NAME/datapacks` |
| `RESOURCEPACK_DEST` | `$MINECRAFT_DIR/resourcepacks` |

```bash
WORLD_NAME="My Test World" ./reload-files.sh
```

---

## Features

### Day counter broadcast

Every N in-game days (default 5) everyone gets a chat message: **"In-game days passed: \<day\>"**.

- Change the interval: `/function omlet_dp:day_message_broadcast/set_broadcast_frequency {new_freq:<days>}`. The setting is kept across `/reload`.
- The day is worked out from `time query time ÷ 24000`. Since 26.1 there is no `/time query day`.
- A "new day" is any change to the day number, including `/time set`. Loading the pack never triggers a broadcast on its own.

### Custom paintings

There are 23 custom paintings. They are all in the `minecraft:placeable` painting tag, so they show up randomly when players place a normal painting.

- `/function omlet_dp:paintings/list` prints every painting in chat. Hover over one to preview it, or click it to receive it.
- Groups: standalone art, `commune_art/` (Soviet poster art used for roleplay) and `mcquarrie/` (Ralph McQuarrie concept art).
- `frog_dance` is animated (see its `.png.mcmeta`).

### Custom music disc — "National Anthem of USSR"

- **Recipe (shapeless):** jukebox + red dye + iron pickaxe.
- The result is a Pigstep disc item with its `jukebox_playable` component pointed at `omlet_dp:ussr_anthem`. It plays a streamed 224-second track and gives a comparator output of 8.

### Vine Boom goat horn

- **Recipe (shaped):** a goat horn surrounded by 8 TNT.
- Gives a goat horn with the instrument `omlet_dp:vboomhorn`, which plays the "vine boom" sound with a 256-block range.
- The instrument is also added to the `minecraft:goat_horns` instrument tag.

### Torch arrow

- **Recipe (shapeless):** arrow + torch → a "Torch Arrow". This is an arrow tagged with `custom_data {torch_arrow:true}` and using the `omlet_rp:torch_arrow` item model, which draws an arrow with a torch over it.
- When a fired torch arrow lands, it places a torch where it hit. It places a standing torch if there's ground below, otherwise a wall torch facing away from the block it hit. A xylophone note plays and the arrow is removed. If no torch can be placed there, the arrow stays as normal.

### Gun

- Get one with `/function omlet_dp:debug/give_gun`. It is a carrot on a stick tagged with `custom_data {omlet_gun:true}` and using the `omlet_rp:block_17` item model.
- Right-click to fire. Holding right-click fires automatically, about 5 shots a second. Each shot is instant (hitscan) with a range of 64 blocks, deals 6 damage to the first mob or player it hits, and leaves a trail of crit particles.
- Bullets pass through grass, flowers, torches and other non-solid blocks but stop at solid blocks. They ignore items, display entities, item frames and other non-mob entities.

### Industrial light (flickering lamp)

A ceiling/wall/floor lamp that gives off light level 15 and flickers at random.

- **Recipe (shaped):** 7 black concrete around a glowstone, with redstone in the bottom middle (`###` / `#G#` / `#R#`). Admins can use `/function omlet_dp:debug/give_industrial_light`.
- The item is an invisible, fixed item frame (tagged `omlet.industrial_light_placer`) with the `omlet_rp:industrial_light` model. Place it on any face of a block, like an item frame. On the next tick the frame is replaced by the lamp: a `light[level=15]` block (waterlogged if placed in water), an `item_display` showing the model rotated to match the surface, and an `interaction` hitbox. If the block space is already taken, the item is dropped back.
- **Flickering:** every 2–20 seconds the lamp goes dark for 1–6 ticks. Half the time it flickers again almost straight away, so flickers come in bursts.
- **Sneak + right-click** switches the lamp off (no light, no flickering) or back on.
- **Punch** to break it. It drops the item, except for players in creative. Placing a block into the lamp's space also breaks it and drops the item.

### Player saddle

A chestplate that lets another player ride on your back.

- **Recipe (shaped):** saddle top middle, leather chestplate in the centre, end rod bottom middle, leather in the other 6 slots (`#-#` / `#o#` / `#_#`).
- The result is a leather chestplate named "Player Saddle" with `custom_data {player_saddle:true}` and the `omlet_rp:player_saddle` model. It gives normal leather chestplate armour.
- While a (non-spectator) player wears it in the chest slot, an `interaction` hitbox (0.6 × 1.2) follows just behind them. Another player **right-clicks** it to sit on a seat (`item_display`) behind the wearer's shoulders. Sneak to get off.
- You can't ride your own saddle, ride one that's already taken, or mount while already riding something.
- The hitbox is removed as soon as the saddle is taken off or the wearer logs out, and the seat is removed once its rider gets off.

### Cat purr replacement (resource pack only)

The vanilla `entity.cat.purr` sound is replaced with `omlet_rp:mob/cat/cough_1`.

### "Nice." advancement

A hidden challenge advancement, awarded when a player kills an entity while at exactly experience level 69. It is announced in chat.

### Recipe unlocking

Every player has all the custom recipes unlocked in their recipe book. The invisible `omlet_dp:unlock_recipes` advancement is granted on the player's first tick in the world and unlocks them as its reward. `load.mcfunction` revokes it from everyone online on each load or `/reload`, so it fires again straight away and picks up any recipes added since. Players who were offline then get the new recipes after the next reload they're online for.

**When adding a recipe, add its id to `advancement/unlock_recipes.json`.**

### Letter banner patterns

There are 26 banner patterns, `omlet_dp:letter_a` to `omlet_dp:letter_z`, one for each letter.

- They are **always available in the loom**, with no banner pattern item needed, because they are in the `minecraft:no_item_required` tag.
- Names such as "Black Letter A" and "Light Blue Letter Q" come from the resource pack's `lang/en_us.json`. There is one entry per letter per dye colour, because the game adds the colour to the end of the translation key.
- Each letter is a blocky white pixel letter that the game tints with the dye colour. On banners it is 15×21 pixels in the middle of the flag. The back of the flag shows it mirrored, like vanilla patterns. On shields it is a smaller 8×14 version.

### Trash can multiblock

A block that deletes everything put into it.

- **Structure (top to bottom):** a glow item frame holding a **lava bucket**, on top of a **barrel**, with a **redstone lamp** directly under the barrel.
- When it's built, the item frame is tagged `omlet.trash_can` and **"Trash can created!"** is shown.
- While the redstone lamp is **lit**, the barrel's contents are cleared every tick and flame particles appear.
- If the structure is broken, the tag is removed and it stops working.

![Trash can](screenshots/trashcan-multiblock.png)

### Flatworld dimension and portal

The datapack adds a custom dimension, `omlet_dp:flatworld`. It is a superflat world with no features or lakes: a bedrock floor at Y = 0, 4 dirt and a grass layer on top, so you stand at Y = 6. Villages and abandoned camps can generate there. Its dimension type, `omlet_dp:flatworld_type`, builds from Y 0 to 2031 and turns off surface slime spawning.

**Building a portal**

1. Build an upright frame out of **coarse dirt**, facing along either the X or the Z axis:
   - bottom row: **5 blocks**, corners included
   - sides: 3 blocks tall each
   - top row: 3 blocks, and the top corners are optional
   - the opening is 3 wide by 3 tall and must be empty
2. Place a **glow item frame facing up** on the **middle block of the bottom row**, and put a **diamond block** in it.
3. The portal lights up and shows particles, and **"Flatworld portal activated!"** (green) appears in chat.

```
 . C C C .        C = coarse dirt   . = optional corner
 C       C
 C       C        (3 x 3 opening)
 C   F   C        F = glow item frame + diamond block (facing up)
 C C C C C
```

**Travelling**

- Stand in the portal for **2 seconds**. The action bar shows "Travelling to the Flatworld…" or "…Overworld…". Stepping out cancels the trip.
- You arrive in the other dimension at the **same X/Z**.
- If there's no portal there, one is **built automatically at ground height**, facing the same way as the portal you left, with the area in front and behind cleared so you can step off. The item frame on generated portals is fixed and invulnerable, so players can't take a free diamond block from it.
- The two portals are **linked**, so going back through takes you to the portal you came from.
- After arriving you must **step out** of the portal before it will take you back, the same as vanilla nether portals.
- Portals only work in the overworld and the flatworld.

**Breaking a portal**

Breaking any frame block, or taking the diamond block out, shuts the portal off. **"Flatworld portal broken!"** (red) appears in chat. The item frame of a generated portal is removed without dropping its diamond block.

**Admin commands**

| Command | What it does |
|---|---|
| `/function omlet_dp:multiblock/flatworld_portal/return_me` | Sends you from the flatworld to the overworld surface at the same X/Z |
| `/function omlet_dp:multiblock/flatworld_portal/return_players {targets:"<selector or name>"}` | Same, for other players, e.g. `{targets:"@a"}`. Only affects players who are in the flatworld |
| `/function omlet_dp:multiblock/flatworld_portal/disable_travel` | Stops portal travel **into** the flatworld. Leaving the flatworld always works |
| `/function omlet_dp:multiblock/flatworld_portal/enable_travel` | Turns it back on. On by default, and the setting is kept across `/reload` |
| `/function omlet_dp:debug/emergency_flatworld_evacuation {targets:"<selector or name>"}` | Shortcut for `return_players` |

`return_me` and `return_players` use `spreadplayers` to find a safe surface block within 32 blocks. If none is found (for example in open ocean), the player is left high up with Slow Falling.

---

## Repository layout

```
.
├── Omlet_Datapack/            The datapack (namespace omlet_dp)
├── Omlet_ResourcePack/        The resource pack (namespace omlet_rp)
├── .github/workflows/
│   └── release.yml            Builds draft release zips for PRs from develop into main
├── docs/
│   ├── DEVELOPER_GUIDE.md     This file
│   └── screenshots/           Images used in the docs/README
├── raw_assets/                Blockbench source models (.bbmodel), not part of either pack
├── versions/                  Release zips (git-ignored)
├── README.md                  Player-facing feature summary
├── reload-files.sh            Copies both packs into a test world
├── .env                       Local overrides for reload-files.sh (git-ignored)
└── .gitignore                 Ignores versions/ and *.env
```

---

## Datapack file reference

All paths below are relative to `Omlet_Datapack/`.

### Pack root

| File | Purpose |
|---|---|
| `pack.mcmeta` | Pack description and supported data pack formats (101–121) |
| `pack.png` | Icon shown in the datapack list |

### Vanilla tags — `data/minecraft/tags/`

| File | Purpose |
|---|---|
| `function/load.json` | Runs `omlet_dp:load` on world load and `/reload` |
| `function/tick.json` | Runs `omlet_dp:tick` every game tick |
| `instrument/goat_horns.json` | Adds the Vine Boom instrument to the goat horn instrument tag |
| `painting_variant/placeable.json` | Lets all custom paintings appear when placing a random painting. **Add new paintings here** |
| `banner_pattern/no_item_required.json` | Makes the letter banner patterns always available in the loom |

### Entry points — `data/omlet_dp/function/`

| File | Purpose |
|---|---|
| `load.mcfunction` | Runs each feature's `init`, revokes `unlock_recipes` so it re-fires, and prints the "loaded successfully" message |
| `tick.mcfunction` | Runs each feature's `tick` every game tick |

### Debug and admin shortcuts — `function/debug/`

| File | Purpose |
|---|---|
| `give_gun.mcfunction` | Gives the gun |
| `give_industrial_light.mcfunction` | Gives an industrial light |
| `list_paintings.mcfunction` | Same as `paintings/list` |
| `emergency_flatworld_evacuation.mcfunction` | Macro `{targets}`, same as `flatworld_portal/return_players` |

### Day counter — `function/day_message_broadcast/`

| File | Purpose |
|---|---|
| `init.mcfunction` | Creates the scoreboard, sets the default frequency (5) only if none is set, and clears `#last_day` so loading doesn't trigger a broadcast |
| `tick.mcfunction` | Works out the day (`time query time ÷ 24000`). When it differs from `#last_day`, records it and broadcasts the chat message if `day % frequency == 0` |
| `set_broadcast_frequency.mcfunction` | Macro `{new_freq}`, sets the broadcast interval in days |

### Paintings — `function/paintings/` and `painting_variant/`

| File | Purpose |
|---|---|
| `function/paintings/list.mcfunction` | Prints the clickable painting list. **Add an entry here when adding a painting** |
| `function/paintings/list_entry.mcfunction` | Macro `{id, title, size}`, prints one clickable and hoverable chat line that gives the painting |
| `painting_variant/*.json` (incl. `commune_art/`, `mcquarrie/`) | One file per painting: texture (`asset_id` → `omlet_rp:<name>`), size in blocks, title and author |

**To add a painting:**
1. Add the PNG at `Omlet_ResourcePack/assets/omlet_rp/textures/painting/<name>.png`. Use 16 px per block.
2. Add `painting_variant/<name>.json`.
3. Add it to `tags/painting_variant/placeable.json`.
4. Add a line to `paintings/list.mcfunction`.

### Music disc and goat horn

| File | Purpose |
|---|---|
| `jukebox_song/ussr_anthem.json` | Song definition: sound event, length (224 s), comparator output |
| `recipe/ussr_anthem.json` | Jukebox + red dye + iron pickaxe → the disc |
| `instrument/vboomhorn.json` | Goat horn instrument: sound event, 256 range, 2 s use duration |
| `recipe/vineboomhorn.json` | Goat horn + 8 TNT → Vine Boom horn |

### Torch arrow

| File | Purpose |
|---|---|
| `recipe/torch_arrow.json` | Arrow + torch → arrow with `custom_data {torch_arrow:true}` and the torch arrow model |
| `function/torch_arrow/tick.mcfunction` | Finds landed torch arrows (`inGround:1b`) and runs `place` at each one |
| `function/torch_arrow/place.mcfunction` | Places a standing or wall torch, plays a sound and removes the arrow. An arrow with nothing to attach a torch to is left alone |

### Gun — `function/gun/` and `tags/*/gun/`

| File | Purpose |
|---|---|
| `function/gun/init.mcfunction` | Creates the gun scoreboards |
| `function/gun/tick.mcfunction` | Counts down cooldowns and runs `try_shoot` for players who right-clicked a carrot on a stick |
| `function/gun/try_shoot.mcfunction` | Checks the player is holding the gun and isn't on cooldown, then fires |
| `function/gun/shoot.mcfunction` | Plays the muzzle sound and smoke, then starts `ray` from the player's eyes |
| `function/gun/ray.mcfunction` | Moves the bullet forward 0.25 blocks per step (recursive). Stops at a block not in `gun/passable` or inside an entity's hitbox |
| `function/gun/hit_block.mcfunction` / `hit_entity.mcfunction` | Impact effects. `hit_entity` deals 6 `minecraft:arrow` damage credited to the shooter |
| `tags/block/gun/passable.json` | Blocks bullets pass through: replaceable blocks (air, water, grass…), flowers, saplings, torches, buttons, rails, signs and similar non-solid blocks, plus cobwebs and barriers |
| `tags/entity_type/gun/not_targets.json` | Entities bullets pass through |

### Industrial light — `function/flickeringlight/`

A lamp is an `item_display` and an `interaction`, both tagged `omlet.industrial_light`, at a `light` block. Functions that take "the block centre" are run `align xyz positioned ~.5 ~.5 ~.5`.

| File | Purpose |
|---|---|
| `recipe/industrial_light.json`, `loot_table/industrial_light.json` | The lamp item (an invisible fixed item frame tagged `omlet.industrial_light_placer`). The loot table is used to drop and give it; keep the two in sync |
| `init.mcfunction` | Creates the `omlet.light_timer` scoreboard |
| `tick.mcfunction` | Turns placed item frames into lamps, handles right-clicks and punches on hitboxes, and runs `lamp_tick` for every lamp |
| `summon_light.mcfunction` | Run as a placed item frame at its block centre: places the light block, summons the display (rotated from the frame's facing) and hitbox (a thin slab on floors and ceilings, a cube on walls), then removes the frame. If the space is taken it drops the item back instead |
| `lamp_tick.mcfunction` | Breaks the lamp (dropping the item) if its light block was replaced, otherwise counts down and calls `light_off` / `light_on` |
| `light_off.mcfunction` | Turns the lamp dark (light level 0, keeping any water) for 1–6 ticks. Used for flickers and for switching off |
| `light_on.mcfunction` | Lights the lamp back up and sets the next flicker: 40–400 ticks away, or half the time 2–8 ticks, so flickers come in bursts. Used when a flicker ends and for switching on |
| `use.mcfunction` | Right-click on a hitbox: toggles the lamp only if the player is sneaking (`predicate/is_sneaking.json`) |
| `toggle.mcfunction` | Switches the lamp off (tag `omlet.light_disabled`, which stops the countdown) or back on |
| `hit.mcfunction` | Punch on a hitbox: drops the item unless the player is in creative, then `remove` |
| `remove.mcfunction` | Restores air or water and kills the lamp's entities |

### Player saddle — `function/player_saddle/`

Each player gets a unique `omlet.id`. The wearer's hitbox and seat carry the same id. Every tick all hitboxes and seats are tagged `omlet.stale`; the ones still in use have it removed, and the rest are killed.

| File | Purpose |
|---|---|
| `recipe/playersaddle.json` | The Player Saddle (leather chestplate with `custom_data {player_saddle:true}`) |
| `init.mcfunction` | Creates `omlet.id` |
| `tick.mcfunction` | Gives players an id, marks hitboxes and seats stale, runs `wearer_tick` for each wearer (rotated to their yaw with pitch 0), and kills whatever is still stale |
| `wearer_tick.mcfunction` | Moves the wearer's hitbox and seat behind them, or summons a hitbox if they don't have one |
| `init_hitbox.mcfunction` / `init_seat.mcfunction` | Tag a new hitbox or seat and give it the wearer's id |
| `hitbox_tick.mcfunction` | Keeps the hitbox 0.3 up and 0.4 behind the wearer, and calls `click` when it's right-clicked |
| `click.mcfunction` | Runs `mount` as the player who clicked |
| `mount.mcfunction` | Unless it's the wearer, the player is already riding, or the seat is taken: summons a seat 0.9 up and 0.4 behind the wearer and mounts the player on it |
| `seat_tick.mcfunction` | Keeps the seat in place. It stays alive only while it has a rider |

### Advancement

| File | Purpose |
|---|---|
| `advancement/nice.json` | Hidden "Nice." challenge advancement for killing an entity while at level 69 |
| `advancement/unlock_recipes.json` | Invisible (no `display`). `minecraft:tick` trigger whose reward unlocks every custom recipe. Revoked for online players in `load.mcfunction` so it re-fires. **Add new recipes here** |

### Banner patterns — `banner_pattern/`

| File | Purpose |
|---|---|
| `banner_pattern/letter_a.json` … `letter_z.json` | One pattern per letter: `asset_id` (texture `omlet_rp:letter_<letter>`) and `translation_key` (`block.omlet_dp.banner.letter_<letter>`) |

### Trash can — `function/multiblock/trash_can/` and `predicate/trash_can/`

| File | Purpose |
|---|---|
| `predicate/trash_can/valid.json` | True for a glow item frame holding a lava bucket, with a barrel under it and a redstone lamp under that |
| `tick.mcfunction` | Tags new trash cans, untags broken ones, and runs `activate_trashcan` while the lamp is lit |
| `create_trashcan.mcfunction` | Adds the `omlet.trash_can` tag and shows "Trash can created!" to players within 8 blocks |
| `activate_trashcan.mcfunction` | Clears the barrel's items and shows flame particles |

### Flatworld — `dimension/`, `predicate/flatworld_portal/` and `function/multiblock/flatworld_portal/`

Portals face along either the X or the Z axis. The portal's **anchor** is the middle bottom block of the opening, where the glow item frame sits, and all offsets are measured from there. Instead of separate `_x` and `_z` functions, the shape of each axis (the coordinate ranges of the opening, frame and cleared space, and the particle spread) is kept in `storage omlet_dp:flatworld_portal axis.x` / `axis.z`, and the shape-dependent functions are macros that take it.

| File | Purpose |
|---|---|
| `dimension/flatworld.json` | Defines `omlet_dp:flatworld`, a superflat generator (bedrock, 4 dirt and grass, no features or lakes, villages and abandoned camps allowed) |
| `dimension_type/flatworld_type.json` | The flatworld's dimension type: Y 0–2031, overworld sky, normal day cycle, no surface slimes |
| `predicate/flatworld_portal/frame_x.json`, `frame_z.json` | True if the 14 coarse dirt frame blocks around the anchor are intact |
| `predicate/flatworld_portal/empty_x.json`, `empty_z.json` | True if the 3×3 opening is all air. Used together with `frame_*` before activating |
| `predicate/flatworld_portal/has_key.json` | A glow item frame holding a diamond block |
| `predicate/flatworld_portal/in_portal.json` | Standing in `light[level=11]`, i.e. inside an active portal |
| `predicate/flatworld_portal/travel_blocked.json` | The player is heading to the flatworld while travel there is disabled |
| `init.mcfunction` | Creates the portal scoreboards, enables travel by default (without overwriting an existing setting), removes objectives from older versions, and stores the axis shapes |
| `tick.mcfunction` | The main loop: activation, portal upkeep, cooldowns, and travel |
| `with_axis.mcfunction` | Macro `{run}`, run as a portal's item frame: runs `flatworld_portal/<run>` with that portal's axis shape |
| `try_activate.mcfunction` | Run at an upward glow item frame holding a diamond block. Checks the frame and opening for both axes, and only works in the overworld or flatworld |
| `activate.mcfunction` | Macro (axis shape). Fills the opening with `light[level=11]`, tags the item frame `omlet.portal` and `omlet.portal_<axis>`, plays effects and shows the green message |
| `portal_tick.mcfunction` | Macro (axis shape), run for each active portal every tick: deactivates it if the diamond is gone or the frame is broken, refills emptied light blocks and shows particles |
| `deactivate.mcfunction` | Macro (axis shape). Removes the light blocks, shows the red "broken" message and untags the frame. Removes the item frame (without a drop) on generated portals |
| `build.mcfunction` | Macro (axis shape). Builds a complete active portal at the destination: clears space, places the frame and light, and summons a fixed glow item frame |
| `travel/start.mcfunction` | A player stepped into a portal: stores the portal's position, where it leads and the Y of its linked portal in the player's scores, checks whether travel is disabled, starts the timer and force-loads the destination |
| `travel/tick.mcfunction` | Runs each tick while a player waits: cancels if they step out, fails if travel is disabled or after 200 ticks, shows the action bar, and calls `arrive` from 40 ticks |
| `travel/with_args.mcfunction` | Macro `{run}`: copies the player's travel scores into `storage omlet_dp:flatworld_portal args` (`x`, `y`, `z`, `target_y`, `src`, `dim`) and runs `travel/<run>` with them |
| `travel/arrive.mcfunction` | Macro (travel args). Waits until the destination is loaded, then picks the portal in the same X/Z column closest to the target Y, otherwise builds one at ground height. Then links both portals, teleports the player and sets their cooldown |
| `travel/forceload.mcfunction`, `travel/unforceload.mcfunction` | Macros (travel args) that add or remove a force-load on the 5×5 blocks around the destination |
| `travel/cancel.mcfunction` | Stops a trip: releases the force-load and removes the travel tag |
| `travel/fail.mcfunction` | Macro `{message}`: shows the reason in red on the action bar, sets the cooldown so it doesn't repeat every tick, and cancels the trip |
| `enable_travel.mcfunction`, `disable_travel.mcfunction` | Admin toggles for travel into the flatworld |
| `return_me.mcfunction`, `return_players.mcfunction` | Admin commands to send yourself or other players back to the overworld |
| `return/player.mcfunction` | Cancels any trip in progress and stores the player's X/Z for `teleport` |
| `return/teleport.mcfunction` | Macro. Teleports into the overworld, then `spreadplayers` onto a safe surface block. Falls back to Slow Falling |

**How a trip works**

1. A player standing in `light[level=11]`, with an active portal item frame within 4 blocks and no cooldown, runs `travel/start`.
2. Over the next 40 ticks the destination chunks are force-loaded.
3. `travel/arrive` waits for `execute if loaded`, which covers both blocks and entities. It then finds or builds the destination portal, stores each portal's Y in the other's `omlet.portal_link` score, and teleports the player onto the destination item frame. A new portal is built along the same axis as the one being left.
4. The player gets `omlet.portal_cooldown`, which is removed once they are no longer standing in portal light.

Linked portals always share X/Z, so a link only needs the other portal's Y.

---

## Resource pack file reference

All paths below are relative to `Omlet_ResourcePack/`.

| File | Purpose |
|---|---|
| `pack.mcmeta` | Pack description and supported resource pack formats (72–97.1) |
| `pack.png` | Icon shown in the resource pack list |
| `assets/minecraft/sounds.json` | Replaces the vanilla `entity.cat.purr` sound with the cat cough |
| `assets/omlet_rp/sounds.json` | Defines `item.goat_horn.sound.vboom` and `music_disc.ussr_anthem` (streamed) |
| `assets/omlet_rp/sounds/vboom.ogg` | Vine Boom horn sound |
| `assets/omlet_rp/sounds/records/ussr_anthem.ogg` | Music disc track |
| `assets/omlet_rp/sounds/mob/cat/cough_1.ogg` | Replacement cat purr sound |
| `assets/omlet_rp/textures/entity/banner/letter_*.png` | Banner textures for the 26 letter patterns (64×64; front face at x1–20, y1–40, mirrored copy on the back face at x22–41) |
| `assets/omlet_rp/textures/entity/shield/letter_*.png` | Shield textures for the 26 letter patterns (64×64; face at x2–11, y2–21) |
| `assets/omlet_rp/lang/en_us.json` | English names for the letter banner patterns, e.g. `block.omlet_dp.banner.letter_a.black` → "Black Letter A" (16 colours × 26 letters) |
| `assets/omlet_rp/items/torch_arrow.json` | Item model for the torch arrow: the vanilla arrow with a torch model drawn over it |
| `assets/omlet_rp/items/block_17.json` | Item model for the gun (`omlet_rp:block_17`) |
| `assets/omlet_rp/models/item/block_17.json`, `textures/item/block_17_tex.png` | The gun's Blockbench model and texture |
| `assets/omlet_rp/items/industrial_light.json`, `models/block/industrial_lamp.json`, `textures/block/industrial_lamp.png` | The industrial light's item model, Blockbench model and texture |
| `assets/omlet_rp/items/player_saddle.json`, `models/item/player_saddle.json`, `textures/item/player_saddle.png` | The player saddle's item model, flat item model and texture |
| `assets/omlet_rp/textures/painting/**/*.png` | One texture per painting variant, matching the datapack's `asset_id`s |
| `assets/omlet_rp/textures/painting/frog_dance.png.mcmeta` | Makes the Frog Dance painting animate (1 tick per frame) |

---

## Scoreboards, tags and storage

**Scoreboards**

| Objective | Holder | Meaning |
|---|---|---|
| `omlet.day` | fake players | `#day` (current day), `#last_day` (day seen on the previous tick), `#frequency` (broadcast interval in days), `#ticks_per_day` (24000), `#mod` (`day % frequency`, temporary) |
| `omlet.portal` | fake players | `#travel_enabled` (1/0), and temporary values such as `#dest_y` and `#ok` |
| `omlet.portal_x/y/z` | players | Position of the portal the player is travelling from |
| `omlet.portal_dest` | players | 1 = going to the flatworld, 0 = going to the overworld |
| `omlet.portal_target` | players | The Y to look for the destination portal at: the linked portal's Y if there is one, otherwise the source portal's Y |
| `omlet.portal_timer` | players | Ticks spent waiting in the portal |
| `omlet.portal_link` | portal item frames | The Y of the linked portal in the other dimension |
| `omlet.gun_used` | players | Right-clicks with a carrot on a stick since the last tick (`minecraft.used` stat) |
| `omlet.gun_cooldown` | players | Ticks until the gun can fire again |
| `omlet.gun` | fake players | `#steps` (bullet steps left), `#2` and `#mod`, temporary |
| `omlet.light_timer` | lamp item_displays | Ticks until the lamp next flickers off or back on |
| `omlet.id` | players, saddle hitboxes and seats | Unique player id; hitboxes and seats carry their wearer's. `#next` (last id given out), `#id` and `#found`, temporary |

**Entity tags**

| Tag | On | Meaning |
|---|---|---|
| `omlet.trash_can` | glow item frame | An active trash can |
| `omlet.portal`, `omlet.portal_x` / `omlet.portal_z` | glow item frame | An active flatworld portal and the axis it faces |
| `omlet.portal_generated` | glow item frame | The portal was built automatically, so its frame is fixed and is removed when the portal breaks |
| `omlet.portal_travel` | player | Currently waiting in a portal |
| `omlet.portal_cooldown` | player | Must step out of portal light before travelling again |
| `omlet.portal_src`, `omlet.portal_dest`, `omlet.portal_candidate` | glow item frame | Temporary markers used inside a single function call |
| `omlet.gun_shooter` | player | The player firing, only during a single shot |
| `omlet.industrial_light_placer` | item frame | A just-placed industrial light, turned into a lamp on the next tick |
| `omlet.industrial_light` | item_display / interaction | A lamp's model and its hitbox |
| `omlet.light_off` | lamp item_display | Currently dark (in a flicker, or switched off) |
| `omlet.light_disabled` | lamp item_display | Switched off by a player |
| `omlet.saddle_hitbox`, `omlet.saddle_seat` | interaction / item_display | A player saddle's click hitbox and seat |
| `omlet.stale`, `omlet.new_seat` | various | Temporary, only during a single tick or function call |

**Storage**

`omlet_dp:flatworld_portal` holds `axis.x` / `axis.z` (portal shape per axis, set in `init`), `args` (travel macro arguments) and `return` (X/Z for the return commands).

---

## Development workflow

1. Edit the files in this repo.
2. Run `./reload-files.sh` to copy both packs into your test world.
3. In-game, run `/reload` for the datapack and press F3+T for the resource pack. Changes to `dimension/` need the world to be reopened.
4. Watch the log for errors. Function errors show up as "Failed to load function". A bad JSON file (predicate, recipe, dimension, advancement…) can stop the **entire** datapack loading, and on a dedicated server it can stop the server starting.

**Testing on a headless server:** a throwaway vanilla 26.3 server driven over RCON is a quick way to test without the game client. 26.3 needs Java 25. Set `enable-rcon=true` and `pause-when-empty-seconds=-1` in `server.properties`; otherwise an empty server pauses and tick functions stop running. There is no player on such a server, so test player-facing functions by running them directly with `execute as` a temporary entity.

**Conventions**

- Each feature lives in its own folder with an `init` (called from `load.mcfunction`) and a `tick` (called from `tick.mcfunction`).
- Start each function file with a comment saying who it runs **as** and **at**, and what arguments it takes if it's a macro.
- Prefix scoreboards and tags by feature, e.g. `omlet.portal_*` or `omlet.gun_*`.
- Update `README.md` (for players) and this guide (for developers) when adding a feature.

---

## Gotchas for Minecraft 26.x

- **Loot conditions and predicates** use `"type"` as the dispatch key, not `"condition"`.
- **Advancement trigger fields** such as `player` and `location` take one condition object. Combine several with `{"type": "minecraft:all_of", "terms": [...]}`.
- **There is no `minecraft:reference` condition.** To combine saved predicates, chain them in the command: `execute if predicate a if predicate b`.
- **`/time query day` no longer exists.** Use `time query time` and divide by 24000.
- **Whole-number X/Z in commands are block centres.** `positioned 10 64 10` is (10.5, 64, 10.5). Use `align xyz` (or `align xz`) to snap to the block corner.
- **`dx/dy/dz` volume selectors** don't match zero-size entities such as markers that sit exactly on the bottom face of the box. Use `distance=..0.5` from the entity's exact position instead.
- **Custom dimensions** are only loaded when the world starts, not on `/reload`.
- **Summoning an item frame without `block_pos`** logs "Block-attached entity at invalid position: null". It's harmless, and the frame still attaches.
- **`recipe_crafted` advancements** take the recipe as `"recipes": "<id>"`, not `recipe_id`. A wrong key stops the whole datapack (and a fresh server) from loading.
- **Loot table functions** are now `"modifier"`: one object keyed by `"type"` (e.g. `"modifier": {"type": "minecraft:set_components", ...}`). The old `"functions": [{"function": ...}]` list loads without error but is silently ignored.

---

## Known issues

- **Force-loading:** portal travel adds and then removes a force-load on the destination chunks. If an admin had force-loaded those exact chunks with `/forceload`, a trip will remove that force-load.
- **Tall flatworld portals:** `travel/arrive` only looks for existing portals between Y −64 and 319, but the flatworld goes up to Y 2031. A flatworld portal built above Y 319 is never found as a destination, so trips from the overworld build a new portal at ground level instead of linking to it.
