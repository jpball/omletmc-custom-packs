# Macro, run as a player. Moves them into the overworld, then onto the highest safe block nearby
$execute in minecraft:overworld run tp @s $(x) 320 $(z)
$execute store success score #ok omlet.portal in minecraft:overworld run spreadplayers $(x) $(z) 0 32 false @s
execute if score #ok omlet.portal matches 0 run effect give @s minecraft:slow_falling 60 0 true
tellraw @s {"text":"Returned to the Overworld","color":"green"}
