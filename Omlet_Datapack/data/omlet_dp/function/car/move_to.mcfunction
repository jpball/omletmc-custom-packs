# Runs as a car, at where it's trying to move to. A wall (2 blocks high) stops it, a 1-block step lifts it
execute unless block ~ ~ ~ #omlet_dp:car/passable unless block ~ ~1 ~ #omlet_dp:car/passable run return run scoreboard players set @s omlet.car_speed 0
execute unless block ~ ~ ~ #omlet_dp:car/passable align y run return run tp @s ~ ~1 ~
tp @s ~ ~ ~
