# Omlet Custom Packs — Developer Guide

This repository holds the datapack and resource pack for the Omlet Minecraft server. This guide explains every feature, what each file does, how the packs fit together, and how to install and work on them.

- **Target game version:** Minecraft Java 26.3
- **Datapack:** `Omlet_Datapack/` (namespace `omlet_dp`, pack formats 101–121)
- **Resource pack:** `Omlet_ResourcePack/` (namespace `omlet_rp`, pack formats 69–97)

The two packs are designed to be used together. The datapack adds the gameplay, and the resource pack supplies the sounds, textures and models that gameplay refers to. Without the resource pack the features still work, but custom paintings show the missing texture, custom sounds are silent and the torch arrow looks like a normal arrow.

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
4. You should see **"Omlet Datapack loaded successfully!"** in green in chat. If you don't, check `/datapack list` and the game log for errors. A single invalid JSON file can stop the whole datapack loading.

When creating a new world you can instead add the datapack from the *Data Packs* button on the world creation screen.

### Dedicated server

1. Stop the server.
2. Copy `Omlet_Datapack` into `<server>/<level-name>/datapacks/`. `level-name` is set in `server.properties` and is usually `world`.
3. Start the server. Confirm with `/datapack list` that `file/Omlet_Datapack` is enabled.
4. For the resource pack, either:
   - give players the zip to install themselves, or
   - host the zip somewhere with a direct download link and set `resource-pack=<url>` and `resource-pack-sha1=<sha1 of the zip>` in `server.properties`. Set `require-resource-pack=true` if it should be mandatory.

### Release zips

Packaged releases are kept in `versions/`, for example `Omlet_Datapack_26.3_v1.1.zip` and `Omlet_ResourcePack_26.3_v1.1.zip`. This folder is git-ignored, so the zips only exist on the machine that built them. When zipping a pack yourself, `pack.mcmeta` must be at the **root** of the zip, not inside a subfolder.

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

### Cat purr replacement (resource pack only)

The vanilla `entity.cat.purr` sound is replaced with `omlet_rp:mob/cat/cough_1`.

### "Nice." advancement

A hidden challenge advancement, awarded when a player kills an entity while at exactly experience level 69. It is announced in chat.

### Letter banner patterns

There are 26 banner patterns, `omlet_dp:letter_a` to `omlet_dp:letter_z`, one for each letter.

- They are **always available in the loom**, with no banner pattern item needed, because they are in the `minecraft:no_item_required` tag.
- Names such as "Black Letter A" and "Light Blue Letter Q" come from the resource pack's `lang/en_us.json`. There is one entry per letter per dye colour, because the game adds the colour to the end of the translation key.
- Each letter is a blocky white pixel letter that the game tints with the dye colour. On banners it is 15×21 pixels in the middle of the flag. The back of the flag shows it mirrored, like vanilla patterns. On shields it is a smaller 8×14 version.

### Trash can multiblock

A block that deletes everything put into it.

- **Structure (top to bottom):** a glow item frame holding a **lava bucket**, on top of a **barrel**, with a **redstone lamp** directly under the barrel.
- When it's built, the item frame is tagged `is_trashcan` and **"Trash can created!"** is shown.
- While the redstone lamp is **lit**, the barrel's contents are cleared every tick and flame particles appear.
- If the structure is broken, the tag is removed and it stops working.

![Trash can](screenshots/trashcan-multiblock.png)

### Flatworld dimension and portal

The datapack adds a custom dimension, `omlet_dp:flatworld`. It is a superflat world with no features or lakes: a bedrock floor, 3 dirt and a grass layer on top (the grass surface is at Y = −60). Villages and abandoned camps can generate there.

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
- If there's no portal there, one is **built automatically at ground height**: the frame stands on a 5×3 layer of **smooth stone**, with the area in front and behind cleared so you can step off. The item frame on generated portals is fixed and invulnerable, so players can't take a free diamond block from it.
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

`return_me` and `return_players` use `spreadplayers` to find a safe surface block within 32 blocks. If none is found (for example in open ocean), the player is left high up with Slow Falling.

---

## Repository layout

```
.
├── Omlet_Datapack/            The datapack (namespace omlet_dp)
├── Omlet_ResourcePack/        The resource pack (namespace omlet_rp)
├── docs/
│   ├── DEVELOPER_GUIDE.md     This file
│   └── screenshots/           Images used in the docs/README
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
| `load.mcfunction` | Runs each feature's `init` and prints the "loaded successfully" message |
| `tick.mcfunction` | Runs each feature's `tick` every game tick |

### Day counter — `function/day_message_broadcast/`

| File | Purpose |
|---|---|
| `init.mcfunction` | Creates the scoreboards, sets the default frequency (5) only if none is set, and records the current day so loading doesn't trigger a broadcast |
| `tick.mcfunction` | Updates the current day each tick and calls `on_new_day` when it changes |
| `query_day.mcfunction` | Stores `time query time ÷ 24000` in `omlet_dp.curr_day` |
| `on_new_day.mcfunction` | Records the new day and broadcasts if `day % frequency == 0` |
| `broadcast_day_count.mcfunction` | The chat message |
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
| `function/torch_arrow/place.mcfunction` | Places a standing or wall torch, plays a sound and removes the arrow |

### Gun — `function/gun/` and `tags/*/gun/`

| File | Purpose |
|---|---|
| `function/gun/init.mcfunction` | Creates the gun scoreboards |
| `function/gun/tick.mcfunction` | Counts down cooldowns and runs `try_shoot` for players who right-clicked a carrot on a stick |
| `function/gun/try_shoot.mcfunction` | Checks the player is holding the gun and isn't on cooldown, then fires |
| `function/gun/shoot.mcfunction` | Plays the muzzle sound and smoke, then starts `ray` from the player's eyes |
| `function/gun/ray.mcfunction` | Moves the bullet forward 0.25 blocks per step (recursive). Stops at a block not in `gun/passable` or inside an entity's hitbox |
| `function/gun/hit_block.mcfunction` / `hit_entity.mcfunction` | Impact effects. `hit_entity` deals 6 `minecraft:arrow` damage credited to the shooter |
| `function/debug/give_gun.mcfunction` | Gives the gun |
| `tags/block/gun/passable.json` | Blocks bullets pass through |
| `tags/entity_type/gun/not_targets.json` | Entities bullets pass through |

### Advancement

| File | Purpose |
|---|---|
| `advancement/nice.json` | Hidden "Nice." challenge advancement for killing an entity while at level 69 |

### Banner patterns — `banner_pattern/`

| File | Purpose |
|---|---|
| `banner_pattern/letter_a.json` … `letter_z.json` | One pattern per letter: `asset_id` (texture `omlet_rp:letter_<letter>`) and `translation_key` (`block.omlet_dp.banner.letter_<letter>`) |

### Trash can — `function/multiblock/trash_can/` and `predicate/is_trashcan.json`

| File | Purpose |
|---|---|
| `predicate/is_trashcan.json` | True for a glow item frame holding a lava bucket, with a barrel under it and a redstone lamp under that |
| `tick.mcfunction` | Tags new trash cans, untags broken ones, and runs `activate_trashcan` while the lamp is lit |
| `create_trashcan.mcfunction` | Adds the `is_trashcan` tag and shows "Trash can created!" |
| `activate_trashcan.mcfunction` | Clears the barrel's items and shows flame particles |

### Flatworld — `dimension/`, `predicate/flatworld_portal/` and `function/multiblock/flatworld_portal/`

Many portal files come in `_x` and `_z` pairs, for portals facing along the X or the Z axis. The portal's **anchor** is the middle bottom block of the opening, where the glow item frame sits. All offsets are measured from there.

| File | Purpose |
|---|---|
| `dimension/flatworld.json` | Defines `omlet_dp:flatworld`, a superflat generator (bedrock, dirt and grass, no features or lakes, villages and abandoned camps allowed) |
| `predicate/flatworld_portal/frame_x.json`, `frame_z.json` | True if the 14 coarse dirt frame blocks around the anchor are intact |
| `predicate/flatworld_portal/empty_x.json`, `empty_z.json` | True if the 3×3 opening is all air. Used together with `frame_*` before activating |
| `init.mcfunction` | Creates the portal scoreboards. Enables travel by default, without overwriting an existing setting |
| `tick.mcfunction` | The main loop: activation, portal upkeep, clean-up of old-design portals and stray portal light, cooldowns, and travel |
| `try_activate.mcfunction` | Run at an upward glow item frame holding a diamond block. Checks the frame and opening for both axes, and only works in the overworld or flatworld |
| `activate_x/z.mcfunction` | Fills the opening with `light[level=11]`, tags the item frame as a portal, plays effects and shows the green message |
| `portal_tick_x/z.mcfunction` | Run for each active portal every tick: deactivates it if the diamond is gone or the frame is broken, refills emptied light blocks and shows particles |
| `deactivate_x/z.mcfunction` | Removes the light blocks, shows the red "broken" message and untags the frame. Removes the item frame (without a drop) on generated portals |
| `build_x/z.mcfunction` | Builds a complete active portal at the destination: clears space, lays the smooth stone layer, frame and light, and summons a fixed glow item frame |
| `travel/start.mcfunction` | A player stepped into a portal: reads the portal's position, axis and link into the player's scores, checks whether travel is disabled, starts the timer and force-loads the destination |
| `travel/tick.mcfunction` | Runs each tick while a player waits: cancels if they step out or after 200 ticks, shows the action bar, and calls `arrive` after 40 ticks |
| `travel/load_args.mcfunction` | Copies the player's travel scores into `storage omlet_dp:flatworld_portal args` for the macro functions |
| `travel/arrive.mcfunction` | Macro. Waits until the destination is loaded, then finds the destination portal: the linked one first, then any portal in the same X/Z column, otherwise builds one at ground height. Then links both portals, teleports the player and sets their cooldown |
| `travel/forceload.mcfunction`, `travel/unforceload.mcfunction` | Macros that add or remove a force-load on the 5×5 blocks around the destination |
| `travel/cancel.mcfunction` | Stops a trip: releases the force-load and removes the travel tag |
| `travel/blocked.mcfunction` | Action-bar message when travel to the flatworld is disabled. Also sets the cooldown so it doesn't repeat every tick |
| `enable_travel.mcfunction`, `disable_travel.mcfunction` | Admin toggles for travel into the flatworld |
| `return_me.mcfunction`, `return_players.mcfunction` | Admin commands to send yourself or other players back to the overworld |
| `return/player.mcfunction` | Cancels any trip in progress and stores the player's X/Z for `teleport` |
| `return/teleport.mcfunction` | Macro. Teleports into the overworld, then `spreadplayers` onto a safe surface block. Falls back to Slow Falling |

**How a trip works**

1. A player standing in `light[level=11]`, with an active portal item frame within 4 blocks and no cooldown, runs `travel/start`.
2. Over the next 40 ticks the destination chunks are force-loaded.
3. `travel/arrive` waits for `execute if loaded`, which covers both blocks and entities. It then finds or builds the destination portal, stores each portal's Y in the other's `omlet.portal_link` score, and teleports the player onto the destination item frame.
4. The player gets `omlet.portal_cooldown`, which is removed once they are no longer standing in portal light.

Linked portals always share X/Z, so a link only needs the other portal's Y.

---

## Resource pack file reference

All paths below are relative to `Omlet_ResourcePack/`.

| File | Purpose |
|---|---|
| `pack.mcmeta` | Pack description and supported resource pack formats (69–97) |
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
| `assets/omlet_rp/textures/painting/**/*.png` | One texture per painting variant, matching the datapack's `asset_id`s |
| `assets/omlet_rp/textures/painting/frog_dance.png.mcmeta` | Makes the Frog Dance painting animate (1 tick per frame) |

---

## Scoreboards, tags and storage

**Scoreboards**

| Objective | Holder | Meaning |
|---|---|---|
| `omlet_dp.prev_day`, `omlet_dp.curr_day` | `#omlet_dp` | Last seen day and current day. `#ticks_per_day` holds 24000 |
| `omlet_dp.curr_day.mod_freq` | `#omlet_dp` | `day % frequency`, temporary |
| `omlet_dp.config.day_msg_frequency` | `#omlet_dp` | Broadcast interval in days |
| `omlet.portal` | fake players | `#travel_enabled` (1/0), and temporary values such as `#dest_y` and `#ok` |
| `omlet.portal_x/y/z` | players | Position of the portal the player is travelling from |
| `omlet.portal_axis` | players | 0 = X axis, 1 = Z axis |
| `omlet.portal_dest` | players | 1 = going to the flatworld, 0 = going to the overworld |
| `omlet.portal_timer` | players | Ticks spent waiting in the portal |
| `omlet.portal_link` | portal item frames / players | On a portal: the Y of its linked portal. On a player: the Y to look for at the destination |
| `omlet.portal_linked` | players | 1 if the source portal had a link |
| `omlet.gun_used` | players | Right-clicks with a carrot on a stick since the last tick (`minecraft.used` stat) |
| `omlet.gun_cooldown` | players | Ticks until the gun can fire again |
| `omlet.gun` | fake players | `#steps` (bullet steps left), `#2` and `#mod`, temporary |

**Entity tags**

| Tag | On | Meaning |
|---|---|---|
| `is_trashcan` | glow item frame | An active trash can |
| `omlet.portal`, `omlet.portal_x` / `omlet.portal_z` | glow item frame | An active flatworld portal and the axis it faces |
| `omlet.portal_generated` | glow item frame | The portal was built automatically, so its frame is fixed and is removed when the portal breaks |
| `omlet.portal_travel` | player | Currently waiting in a portal |
| `omlet.portal_cooldown` | player | Must step out of portal light before travelling again |
| `omlet.portal_src`, `omlet.portal_dest`, `omlet.portal_candidate` | glow item frame | Temporary markers used inside a single function call |
| `omlet.gun_shooter` | player | The player firing, only during a single shot |

**Storage**

`omlet_dp:flatworld_portal` holds `args` (travel macro arguments) and `return` (X/Z for the return commands).

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
- Prefix scoreboards and tags by feature, e.g. `omlet.portal_*` or `omlet_dp.*`.
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

---

## Known issues

- **Force-loading:** portal travel adds and then removes a force-load on the destination chunks. If an admin had force-loaded those exact chunks with `/forceload`, a trip will remove that force-load.
