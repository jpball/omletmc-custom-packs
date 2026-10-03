# Run as and at a player in the flatworld
execute if entity @s[tag=omlet.portal_travel] run function omlet_dp:multiblock/flatworld_portal/travel/cancel
execute store result storage omlet_dp:flatworld_portal return.x int 1 run data get entity @s Pos[0]
execute store result storage omlet_dp:flatworld_portal return.z int 1 run data get entity @s Pos[2]
function omlet_dp:multiblock/flatworld_portal/return/teleport with storage omlet_dp:flatworld_portal return
