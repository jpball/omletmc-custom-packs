# Runs as a player who just crafted recipe/mustang. The recipe can only give a placeholder item,
# so swap every placeholder they have for the real car from loot_table/car/mustang
advancement revoke @s only omlet_dp:car/crafted_mustang
execute store result score #count omlet.car run clear @s minecraft:armor_stand[minecraft:custom_data~{omlet_car_recipe:true}]
function omlet_dp:car/give_mustang
