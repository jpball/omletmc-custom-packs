# Runs as/at the player firing
playsound minecraft:entity.generic.explode player @a ~ ~ ~ 0.4 1.9
playsound minecraft:entity.firework_rocket.blast player @a ~ ~ ~ 1 0.6
execute anchored eyes positioned ^-0.35 ^-0.15 ^0.8 run particle minecraft:smoke ~ ~ ~ 0.02 0.02 0.02 0.01 3

# Trace up to 64 blocks in 0.25-block steps. The tag stops the shooter hitting themselves
tag @s add omlet.gun_shooter
scoreboard players set #steps omlet.gun 256
execute anchored eyes positioned ^ ^ ^ anchored feet run function omlet_dp:gun/ray
tag @s remove omlet.gun_shooter
