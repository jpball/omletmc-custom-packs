# /function omlet_dp:multiblock/flatworld_portal/return_me
# Sends you from the flatworld to the overworld surface at the same X/Z
execute at @s unless dimension omlet_dp:flatworld run return run tellraw @s {"text":"You are not in the Flatworld","color":"red"}
function omlet_dp:multiblock/flatworld_portal/return/player
