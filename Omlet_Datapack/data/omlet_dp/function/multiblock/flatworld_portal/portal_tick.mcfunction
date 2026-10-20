# Macro (axis shape, see init), run as a portal's glow item frame, positioned at the portal's anchor
$execute unless predicate omlet_dp:flatworld_portal/has_key run return run function omlet_dp:multiblock/flatworld_portal/deactivate with storage omlet_dp:flatworld_portal axis.$(axis)
$execute unless predicate omlet_dp:flatworld_portal/frame_$(axis) run return run function omlet_dp:multiblock/flatworld_portal/deactivate with storage omlet_dp:flatworld_portal axis.$(axis)

# Refill any interior blocks that were emptied
$fill $(interior) minecraft:light[level=11] replace #minecraft:air
$particle minecraft:portal ~0.5 ~1.5 ~0.5 $(spread) 0.3 4
