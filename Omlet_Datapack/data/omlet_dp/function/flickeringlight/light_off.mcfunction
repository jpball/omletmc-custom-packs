# Run as and at a lamp display: go dark (keeping any water in the light block). A flicker lasts 1-6 ticks;
# a lamp switched off by a player (omlet.light_disabled) stays dark until switched back on
tag @s add omlet.light_off
execute if block ~ ~ ~ minecraft:light[waterlogged=true] run setblock ~ ~ ~ minecraft:light[level=0,waterlogged=true]
execute if block ~ ~ ~ minecraft:light[waterlogged=false] run setblock ~ ~ ~ minecraft:light[level=0]
data remove entity @s brightness
execute store result score @s omlet.light_timer run random value 1..6
