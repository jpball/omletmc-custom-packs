# Runs as/at a torch arrow that has landed. Places a torch on the block below, or else on the first solid
# side found, then removes the arrow. With nothing to attach to, the arrow is left as it is
execute unless block ~ ~ ~ #minecraft:air run return 0
execute unless block ~ ~-1 ~ #minecraft:replaceable run setblock ~ ~ ~ minecraft:torch
execute if block ~ ~ ~ #minecraft:air unless block ~ ~ ~1 #minecraft:replaceable run setblock ~ ~ ~ minecraft:wall_torch[facing=north]
execute if block ~ ~ ~ #minecraft:air unless block ~ ~ ~-1 #minecraft:replaceable run setblock ~ ~ ~ minecraft:wall_torch[facing=south]
execute if block ~ ~ ~ #minecraft:air unless block ~1 ~ ~ #minecraft:replaceable run setblock ~ ~ ~ minecraft:wall_torch[facing=west]
execute if block ~ ~ ~ #minecraft:air unless block ~-1 ~ ~ #minecraft:replaceable run setblock ~ ~ ~ minecraft:wall_torch[facing=east]
execute if block ~ ~ ~ #minecraft:air run return 0

playsound block.note_block.xylophone master @a ~ ~ ~
kill @s
