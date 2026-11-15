# Macro {dimension, x, y, z, up}, run as a player. Whole-number X/Z are block centres
$execute in $(dimension) positioned $(x) $(y) $(z) run tp @s ~ ~$(up) ~
tellraw @s {"text":"Returned from the Flatworld","color":"green"}
