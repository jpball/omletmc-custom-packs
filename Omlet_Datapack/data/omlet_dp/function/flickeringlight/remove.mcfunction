# Run at a lamp's block centre
execute if block ~ ~ ~ minecraft:light[waterlogged=true] run setblock ~ ~ ~ minecraft:water
execute if block ~ ~ ~ minecraft:light run setblock ~ ~ ~ minecraft:air
kill @e[tag=omlet.industrial_light,distance=..0.6]
playsound minecraft:block.copper_bulb.break block @a ~ ~ ~
