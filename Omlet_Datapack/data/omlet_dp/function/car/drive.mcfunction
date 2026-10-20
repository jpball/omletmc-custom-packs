# Runs as/at each car every tick. The driver (riding the car's seat) uses their keys (W/S/A/D, space = handbrake) to set its speed and direction
scoreboard players set #throttle omlet.car 0
scoreboard players set #steer omlet.car 0
scoreboard players set #brake omlet.car 0
scoreboard players set #horn omlet.car 0
scoreboard players set #driver omlet.car 0

execute on passengers on passengers if entity @s[type=player] run function omlet_dp:car/read_controls

# Accelerate, brake/reverse, or coast to a stop
execute if score #throttle omlet.car matches 1 run scoreboard players add @s omlet.car_speed 2
execute if score #throttle omlet.car matches -1 run scoreboard players remove @s omlet.car_speed 3
execute if score #throttle omlet.car matches 0 if score @s omlet.car_speed matches 1.. run scoreboard players remove @s omlet.car_speed 1
execute if score #throttle omlet.car matches 0 if score @s omlet.car_speed matches ..-1 run scoreboard players add @s omlet.car_speed 1
# Handbrake: skid sound if going faster than a crawl, then stop
execute if score #brake omlet.car matches 1 unless score @s omlet.car_speed matches -19..19 run playsound minecraft:block.grindstone.use neutral @a ~ ~ ~ 1 0.6
execute if score #brake omlet.car matches 1 run scoreboard players set @s omlet.car_speed 0
# Top speed 0.7 blocks/tick forwards (14 blocks/s), 0.25 in reverse
execute if score @s omlet.car_speed matches 71.. run scoreboard players set @s omlet.car_speed 70
execute if score @s omlet.car_speed matches ..-26 run scoreboard players set @s omlet.car_speed -25

# Engine: a short bass drum every 2 ticks while someone's driving, higher pitched the faster the car goes
execute if score #driver omlet.car matches 1 if score #cycle omlet.car matches 0 run function omlet_dp:car/engine_sound
execute if score #driver omlet.car matches 1 if score #cycle omlet.car matches 2 run function omlet_dp:car/engine_sound
# Horn (sprint key), repeating while held
execute if score #horn omlet.car matches 1 if score #cycle omlet.car matches 0 run playsound minecraft:block.note_block.didgeridoo neutral @a ~ ~ ~ 1.5 1.2

# Steer only while moving; in reverse the same key turns the other way, like a real car
execute if score @s omlet.car_speed matches 1.. if score #steer omlet.car matches 1 run rotate @s ~-5 ~
execute if score @s omlet.car_speed matches 1.. if score #steer omlet.car matches -1 run rotate @s ~5 ~
execute if score @s omlet.car_speed matches ..-1 if score #steer omlet.car matches 1 run rotate @s ~5 ~
execute if score @s omlet.car_speed matches ..-1 if score #steer omlet.car matches -1 run rotate @s ~-5 ~
# Gravity: fall half a block per tick, landing on top of the block below
execute if block ~ ~-0.01 ~ #omlet_dp:car/passable if block ~ ~-0.5 ~ #omlet_dp:car/passable run tp @s ~ ~-0.5 ~
execute if block ~ ~-0.01 ~ #omlet_dp:car/passable unless block ~ ~-0.5 ~ #omlet_dp:car/passable align y run tp @s ~ ~ ~

execute if score @s omlet.car_speed matches 0 run return 0
execute store result storage omlet_dp:car step double 0.01 run scoreboard players get @s omlet.car_speed
execute at @s rotated ~ 0 run function omlet_dp:car/move with storage omlet_dp:car
