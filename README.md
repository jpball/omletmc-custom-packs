# Custom Datapack and Resource Pack for the Omlet Minecraft Server

---
## Datapack Functionality
- Day Counter Broadcast
    - Every 5 in-game days, the chat receives a message indicating the total days elapsed.
    - Change the interval with `/function omlet_dp:day_message_broadcast/set_broadcast_frequency {new_freq:<days>}`

- Custom music discs!

- Custom Paintings!
    - Featuring all sorts of art used for roleplay
    - And more!
    - Run `/function omlet_dp:paintings/list` to list them in chat; click one to receive it

- Trash Can Multiblock
    - Build a trash can to incinerate all items transferred into the chest
    - Place a glow item frame holding a lava bucket on top of a trapped chest, with a redstone lamp beneath the chest
    - The trash can only burns items while the redstone lamp is powered

- Chest Upgrades
    - Craft a tier chest by surrounding the previous tier's chest with 8 of the tier's material
        - Chest → Iron Chest (iron ingots) → Gold Chest (gold ingots) → Diamond Chest (diamonds) → Netherite Chest (netherite ingots)
    - Each tier is recolored and adds more storage, split into pages; click the arrows in the bottom corners to change page
    - Breaking a tier chest drops all its pages and the tier chest itself
    - Change how many slots each tier adds in `function/chest_upgrade/config.mcfunction`, then `/reload`
    - Recolor a tier by editing its palette in `scripts/generate_chest_textures.py` and re-running it
