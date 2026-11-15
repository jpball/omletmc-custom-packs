# Runs as/at an armor stand just placed from a car item (see loot_table/car/), and replaces it with the car:
# an item_display showing the head item, with an interaction hitbox and a seat riding it. The display is in "fixed"
# mode, so the model's display.fixed (in the resource pack) sets its position, size and rotation.
# Placed armor stands face the player, so the car faces away, ready to drive
summon item_display ~ ~ ~ {Tags:["omlet.car","omlet.car_new_part"],teleport_duration:1,item_display:"fixed"}
execute rotated ~180 0 run rotate @n[type=item_display,tag=omlet.car_new_part] ~ ~
data modify entity @n[type=item_display,tag=omlet.car_new_part] item set from entity @s equipment.head
scoreboard players set @n[type=item_display,tag=omlet.car_new_part] omlet.car_speed 0

summon interaction ~ ~ ~ {Tags:["omlet.car_hitbox","omlet.car_new_part"],width:2.0f,height:1.2f}
ride @n[type=interaction,tag=omlet.car_hitbox,tag=omlet.car_new_part] mount @n[type=item_display,tag=omlet.car_new_part]
# The driver rides the seat, sitting at its height above the car's base. Raise or lower the player with height, matching
# the seat cushion in the model (with its display.fixed). Width 0 means it can't be clicked, so clicks reach the hitbox
summon interaction ~ ~ ~ {Tags:["omlet.car_seat","omlet.car_new_part"],width:0.0f,height:0.55f}
ride @n[type=interaction,tag=omlet.car_seat,tag=omlet.car_new_part] mount @n[type=item_display,tag=omlet.car_new_part]
tag @e[tag=omlet.car_new_part] remove omlet.car_new_part
kill @s
