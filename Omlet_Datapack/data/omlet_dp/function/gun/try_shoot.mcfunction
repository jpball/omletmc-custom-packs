# Runs as/at a player who just right-clicked a carrot on a stick
scoreboard players reset @s omlet.gun_used
execute unless items entity @s weapon.* minecraft:carrot_on_a_stick[minecraft:custom_data~{omlet_gun:true}] run return 0
execute if score @s omlet.gun_cooldown matches 1.. run return 0

# Holding right-click repeats every 20 ticks, so this is also the automatic fire rate
scoreboard players set @s omlet.gun_cooldown 20
function omlet_dp:gun/shoot
