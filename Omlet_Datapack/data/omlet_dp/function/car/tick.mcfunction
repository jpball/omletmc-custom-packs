# Counts 0-3 over and over, used to space out repeating car sounds
scoreboard players add #cycle omlet.car 1
execute if score #cycle omlet.car matches 4.. run scoreboard players set #cycle omlet.car 0

execute as @e[type=armor_stand,tag=omlet.car_new] at @s run function omlet_dp:car/setup
execute as @e[type=interaction,tag=omlet.car_hitbox] if data entity @s interaction run function omlet_dp:car/clicked
execute as @e[type=interaction,tag=omlet.car_hitbox] if data entity @s attack run function omlet_dp:car/punched
execute as @e[type=item_display,tag=omlet.car] at @s run function omlet_dp:car/drive

# Hitboxes and seats left behind by a car that was killed some other way
kill @e[type=interaction,tag=omlet.car_hitbox,predicate=!omlet_dp:car/in_car]
kill @e[type=interaction,tag=omlet.car_seat,predicate=!omlet_dp:car/in_car]
