# Run as a travelling player. Copies their travel scores into storage for the macro functions
execute store result storage omlet_dp:flatworld_portal args.x int 1 run scoreboard players get @s omlet.portal_x
execute store result storage omlet_dp:flatworld_portal args.z int 1 run scoreboard players get @s omlet.portal_z
execute store result storage omlet_dp:flatworld_portal args.src_y int 1 run scoreboard players get @s omlet.portal_y
execute store result storage omlet_dp:flatworld_portal args.y int 1 run scoreboard players get @s omlet.portal_link

data modify storage omlet_dp:flatworld_portal args.axis set value "x"
execute if score @s omlet.portal_axis matches 1 run data modify storage omlet_dp:flatworld_portal args.axis set value "z"

data modify storage omlet_dp:flatworld_portal args.dim set value "minecraft:overworld"
data modify storage omlet_dp:flatworld_portal args.src set value "omlet_dp:flatworld"
execute if score @s omlet.portal_dest matches 1 run data modify storage omlet_dp:flatworld_portal args.dim set value "omlet_dp:flatworld"
execute if score @s omlet.portal_dest matches 1 run data modify storage omlet_dp:flatworld_portal args.src set value "minecraft:overworld"
