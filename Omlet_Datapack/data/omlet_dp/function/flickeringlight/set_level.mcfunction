# Run at a lamp's block centre with {level:<0-15>}: change the light block's level, keeping any water in it
$execute if block ~ ~ ~ minecraft:light[waterlogged=true] run setblock ~ ~ ~ minecraft:light[level=$(level),waterlogged=true]
$execute if block ~ ~ ~ minecraft:light[waterlogged=false] run setblock ~ ~ ~ minecraft:light[level=$(level)]
