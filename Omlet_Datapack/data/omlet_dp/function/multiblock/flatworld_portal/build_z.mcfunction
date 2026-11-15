# Run positioned at the anchor of a new portal in the destination dimension, one block above the ground.
# Builds an active portal with room to step off either side
fill ~-1 ~-1 ~-2 ~1 ~3 ~2 minecraft:air destroy
fill ~ ~-1 ~-2 ~ ~3 ~2 minecraft:coarse_dirt
fill ~ ~ ~-1 ~ ~2 ~1 minecraft:light[level=11]
summon minecraft:glow_item_frame ~0.5 ~ ~0.5 {Facing:1b,Fixed:1b,Invulnerable:1b,Item:{id:"minecraft:diamond_block",count:1},Tags:["omlet.portal","omlet.portal_z","omlet.portal_generated","omlet.portal_dest"]}
