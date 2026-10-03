# Run as and at a player standing in a portal, waiting to travel
scoreboard players add @s omlet.portal_timer 1
execute unless block ~ ~ ~ minecraft:light[level=11] run return run function omlet_dp:multiblock/flatworld_portal/travel/cancel
execute if score @s omlet.portal_timer matches 200.. run return run function omlet_dp:multiblock/flatworld_portal/travel/cancel
execute if score @s omlet.portal_dest matches 1 unless score #travel_enabled omlet.portal matches 1 run function omlet_dp:multiblock/flatworld_portal/travel/cancel
execute if score @s omlet.portal_dest matches 1 unless score #travel_enabled omlet.portal matches 1 run return run function omlet_dp:multiblock/flatworld_portal/travel/blocked

execute if score @s omlet.portal_dest matches 1 run title @s actionbar {"text":"Travelling to the Flatworld...","color":"green"}
execute if score @s omlet.portal_dest matches 0 run title @s actionbar {"text":"Travelling to the Overworld...","color":"green"}
execute if score @s omlet.portal_timer matches ..39 run return 0

function omlet_dp:multiblock/flatworld_portal/travel/load_args
function omlet_dp:multiblock/flatworld_portal/travel/arrive with storage omlet_dp:flatworld_portal args
