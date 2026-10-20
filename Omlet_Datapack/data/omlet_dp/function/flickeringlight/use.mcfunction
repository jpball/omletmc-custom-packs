# Run as and at a lamp's interaction hitbox that was right-clicked. Only a sneaking player switches it
data remove entity @s interaction
scoreboard players set #sneaking omlet.light 0
execute store success score #sneaking omlet.light on target if predicate omlet_dp:is_sneaking
execute if score #sneaking omlet.light matches 1 align xyz positioned ~.5 ~.5 ~.5 as @e[type=minecraft:item_display,tag=omlet.industrial_light,distance=..0.6,limit=1] run function omlet_dp:flickeringlight/toggle
