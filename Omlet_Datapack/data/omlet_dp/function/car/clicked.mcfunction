# Runs as a car's hitbox when a player right-clicks it: they sit in the car's seat, unless someone is already driving.
# "on target" reads the click record, so the record is only cleared at the end
execute on vehicle on passengers if entity @s[tag=omlet.car_seat] run tag @s add omlet.car_this
execute on vehicle on passengers on passengers if entity @s[type=player] run tag @e[tag=omlet.car_this] remove omlet.car_this
execute as @e[tag=omlet.car_this] at @s run playsound minecraft:block.iron_door.close neutral @a ~ ~ ~ 0.8 1.2
execute on target run ride @s mount @e[tag=omlet.car_this,limit=1,type=interaction]
tag @e[tag=omlet.car_this] remove omlet.car_this
data remove entity @s interaction
