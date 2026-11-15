# Macro (axis shape, see init), run positioned at the anchor of a new portal in the destination dimension,
# one block above the ground. Builds an active portal with room to step off either side.
# The new item frame is tagged omlet.portal_dest so travel/arrive can find it
$fill $(clearance) minecraft:air destroy
$fill $(frame) minecraft:coarse_dirt
$fill $(interior) minecraft:light[level=11]
$summon minecraft:glow_item_frame ~0.5 ~ ~0.5 {Facing:1b,Fixed:1b,Invulnerable:1b,Item:{id:"minecraft:diamond_block",count:1},Tags:["omlet.portal","omlet.portal_$(axis)","omlet.portal_generated","omlet.portal_dest"]}
