# Run as and at a player who just stepped into a portal
tag @e[type=glow_item_frame,tag=omlet.portal,distance=..4,sort=nearest,limit=1] add omlet.portal_src
execute store result score @s omlet.portal_x run data get entity @e[type=glow_item_frame,tag=omlet.portal_src,limit=1] Pos[0]
execute store result score @s omlet.portal_y run data get entity @e[type=glow_item_frame,tag=omlet.portal_src,limit=1] Pos[1]
execute store result score @s omlet.portal_z run data get entity @e[type=glow_item_frame,tag=omlet.portal_src,limit=1] Pos[2]
execute store success score @s omlet.portal_axis if entity @e[type=glow_item_frame,tag=omlet.portal_src,tag=omlet.portal_z]
execute store success score @s omlet.portal_dest if dimension minecraft:overworld

# Head for the linked portal if there is one, otherwise search near this portal's Y
scoreboard players operation @s omlet.portal_link = @s omlet.portal_y
execute store success score @s omlet.portal_linked if entity @e[type=glow_item_frame,tag=omlet.portal_src,scores={omlet.portal_link=-2147483648..}]
execute if score @s omlet.portal_linked matches 1 run scoreboard players operation @s omlet.portal_link = @e[type=glow_item_frame,tag=omlet.portal_src,limit=1] omlet.portal_link
tag @e[type=glow_item_frame,tag=omlet.portal_src] remove omlet.portal_src

execute if score @s omlet.portal_dest matches 1 unless score #travel_enabled omlet.portal matches 1 run return run function omlet_dp:multiblock/flatworld_portal/travel/blocked

scoreboard players set @s omlet.portal_timer 0
tag @s add omlet.portal_travel
playsound minecraft:block.portal.trigger ambient @s ~ ~ ~ 0.4 1.4

# Start loading the destination now so it's ready when the player arrives
function omlet_dp:multiblock/flatworld_portal/travel/load_args
function omlet_dp:multiblock/flatworld_portal/travel/forceload with storage omlet_dp:flatworld_portal args
