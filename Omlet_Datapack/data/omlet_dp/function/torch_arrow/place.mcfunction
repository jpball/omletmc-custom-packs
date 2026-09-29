
execute unless block ~ ~ ~ #minecraft:air run return 0
execute unless block ~ ~-1 ~ #minecraft:replaceable run setblock ~ ~ ~ minecraft:torch

execute if block ~ ~ ~ #minecraft:air unless block ~ ~ ~1 #minecraft:replaceable run setblock ~ ~ ~ minecraft:wall_torch[facing=north]
execute if block ~ ~ ~ #minecraft:air unless block ~ ~ ~-1 #minecraft:replaceable run setblock ~ ~ ~ minecraft:wall_torch[facing=south]
execute if block ~ ~ ~ #minecraft:air unless block ~1 ~ ~ #minecraft:replaceable run setblock ~ ~ ~ minecraft:wall_torch[facing=west]
execute if block ~ ~ ~ #minecraft:air unless block ~-1 ~ ~ #minecraft:replaceable run setblock ~ ~ ~ minecraft:wall_torch[facing=east]
execute unless block ~ ~ ~ #minecraft:air run playsound block.note_block.xylophone master @a ~ ~ ~
execute unless block ~ ~ ~ #minecraft:air run kill @s
