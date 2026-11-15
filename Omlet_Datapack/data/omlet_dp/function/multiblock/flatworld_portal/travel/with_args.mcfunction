# Macro {run:"<function>"}, run as a travelling player.
# Copies their travel scores into storage, then runs travel/<function> as a macro with them:
#   x, y, z:  the portal being left (whole X/Z read as block centres, where portal item frames sit)
#   target_y: the Y to look for the destination portal at
#   src, dim: the dimension being left, and the one being travelled to
execute store result storage omlet_dp:flatworld_portal args.x int 1 run scoreboard players get @s omlet.portal_x
execute store result storage omlet_dp:flatworld_portal args.y int 1 run scoreboard players get @s omlet.portal_y
execute store result storage omlet_dp:flatworld_portal args.z int 1 run scoreboard players get @s omlet.portal_z
execute store result storage omlet_dp:flatworld_portal args.target_y int 1 run scoreboard players get @s omlet.portal_target
execute if score @s omlet.portal_dest matches 0 run data modify storage omlet_dp:flatworld_portal args merge value {src:"omlet_dp:flatworld", dim:"minecraft:overworld"}
execute if score @s omlet.portal_dest matches 1 run data modify storage omlet_dp:flatworld_portal args merge value {src:"minecraft:overworld", dim:"omlet_dp:flatworld"}

$function omlet_dp:multiblock/flatworld_portal/travel/$(run) with storage omlet_dp:flatworld_portal args
