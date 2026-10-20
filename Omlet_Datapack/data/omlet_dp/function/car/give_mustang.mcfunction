# Gives @s #count omlet.car Mustangs (recursive)
execute if score #count omlet.car matches ..0 run return 0
loot give @s loot omlet_dp:car/mustang
scoreboard players remove #count omlet.car 1
function omlet_dp:car/give_mustang
