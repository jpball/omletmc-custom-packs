# Runs as/at a car with a driver. Pitch goes from 0.5 (idle) to 1.4 (top speed); reversing counts as slow
execute if score @s omlet.car_speed matches -5..5 run playsound minecraft:block.note_block.basedrum neutral @a ~ ~ ~ 0.5 0.5
execute if score @s omlet.car_speed matches 6..25 run playsound minecraft:block.note_block.basedrum neutral @a ~ ~ ~ 0.6 0.7
execute if score @s omlet.car_speed matches ..-6 run playsound minecraft:block.note_block.basedrum neutral @a ~ ~ ~ 0.6 0.7
execute if score @s omlet.car_speed matches 26..45 run playsound minecraft:block.note_block.basedrum neutral @a ~ ~ ~ 0.7 0.9
execute if score @s omlet.car_speed matches 46..60 run playsound minecraft:block.note_block.basedrum neutral @a ~ ~ ~ 0.8 1.15
execute if score @s omlet.car_speed matches 61.. run playsound minecraft:block.note_block.basedrum neutral @a ~ ~ ~ 0.9 1.4
