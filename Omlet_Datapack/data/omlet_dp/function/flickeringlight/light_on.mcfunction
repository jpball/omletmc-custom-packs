# Run as and at a dark lamp display (flickered or switched off): light back up (keeping any water in the light block)
tag @s remove omlet.light_off
tag @s remove omlet.light_disabled
execute if block ~ ~ ~ minecraft:light[waterlogged=true] run setblock ~ ~ ~ minecraft:light[level=15,waterlogged=true]
execute if block ~ ~ ~ minecraft:light[waterlogged=false] run setblock ~ ~ ~ minecraft:light[level=15]
data merge entity @s {brightness:{sky:15,block:15}}
playsound minecraft:block.copper_bulb.turn_on block @a ~ ~ ~ 0.3 1.8

# Next flicker in 2-20 seconds, or half the time almost straight away, so flickers come in bursts
execute store result score @s omlet.light_timer run random value 40..400
execute if predicate {type:"minecraft:random_chance",chance:0.5} store result score @s omlet.light_timer run random value 2..8
