# Runs as the entity hit, at the point of impact
damage @s 6 minecraft:arrow by @e[tag=omlet.gun_shooter,limit=1]
particle minecraft:damage_indicator ~ ~ ~ 0.1 0.1 0.1 0.1 3
playsound minecraft:entity.arrow.hit_player player @a[tag=omlet.gun_shooter] ~ ~ ~ 0.8 1.2
