# Macro {run:"<function>"}, run as a portal's item frame.
# Runs flatworld_portal/<function> as a macro with the shape of that portal's axis (see init)
$execute if entity @s[tag=omlet.portal_x] run function omlet_dp:multiblock/flatworld_portal/$(run) with storage omlet_dp:flatworld_portal axis.x
$execute if entity @s[tag=omlet.portal_z] run function omlet_dp:multiblock/flatworld_portal/$(run) with storage omlet_dp:flatworld_portal axis.z
