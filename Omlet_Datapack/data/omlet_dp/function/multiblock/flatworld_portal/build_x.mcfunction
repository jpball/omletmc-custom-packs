# Run positioned at the anchor of a new portal in the destination dimension, one block above the ground.
# Builds an active portal standing on top of a layer of smooth stone, with room to step off either side
fill ~-2 ~-1 ~-1 ~2 ~3 ~1 minecraft:air destroy
fill ~-2 ~-1 ~ ~2 ~3 ~ minecraft:coarse_dirt
fill ~-1 ~ ~ ~1 ~2 ~ minecraft:light[level=11]
summon minecraft:glow_item_frame ~0.5 ~ ~0.5 {Facing:1b,Fixed:1b,Invulnerable:1b,Item:{id:"minecraft:diamond_block",count:1},Tags:["omlet.portal","omlet.portal_x","omlet.portal_generated","omlet.portal_dest"]}
