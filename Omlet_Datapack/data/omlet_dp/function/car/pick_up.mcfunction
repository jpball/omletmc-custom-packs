# Runs as/at a car. Drops the car item again: the car's item (name, model) plus the
# same entity_data as loot_table/car/, so placing it makes the same car
summon item ~ ~0.5 ~ {Tags:["omlet.car_drop"],Item:{id:"minecraft:armor_stand"}}
data modify entity @n[type=item,tag=omlet.car_drop] Item set from entity @s item
data modify entity @n[type=item,tag=omlet.car_drop] Item.components."minecraft:entity_data" set value {id:"minecraft:armor_stand",Tags:["omlet.car_new"],Invisible:true}
data modify entity @n[type=item,tag=omlet.car_drop] Item.components."minecraft:entity_data".equipment.head set from entity @s item
tag @e[type=item,tag=omlet.car_drop] remove omlet.car_drop
playsound minecraft:entity.item.pickup neutral @a ~ ~ ~

execute on passengers if entity @s[type=interaction] run kill @s
kill @s
