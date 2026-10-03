# Run as a portal's glow item frame, positioned at the portal's anchor
execute unless items entity @s contents minecraft:diamond_block run return run function omlet_dp:multiblock/flatworld_portal/deactivate_z
execute unless predicate omlet_dp:flatworld_portal/frame_z run return run function omlet_dp:multiblock/flatworld_portal/deactivate_z

# Refill any interior blocks that were emptied
fill ~ ~ ~-1 ~ ~2 ~1 minecraft:light[level=11] replace #minecraft:air
particle minecraft:portal ~0.5 ~1.5 ~0.5 0 0.8 0.8 0.3 4
