# One step of the bullet's path; recurses forward until it hits something or runs out of range
execute unless block ~ ~ ~ #omlet_dp:gun/passable run return run function omlet_dp:gun/hit_block

# Hit an entity only if this point is inside its hitbox: overlapping both the 1x1x1 box ending here
# and the one starting here means the hitbox spans this point on every axis
execute positioned ~-1 ~-1 ~-1 as @e[dx=0,dy=0,dz=0,tag=!omlet.gun_shooter,type=!#omlet_dp:gun/not_targets,limit=1] positioned ~1 ~1 ~1 if entity @s[dx=0,dy=0,dz=0] unless entity @s[gamemode=spectator] run return run function omlet_dp:gun/hit_entity

# Tracer every other step (every half block)
scoreboard players operation #mod omlet.gun = #steps omlet.gun
scoreboard players operation #mod omlet.gun %= #2 omlet.gun
execute if score #mod omlet.gun matches 0 run particle minecraft:crit ~ ~ ~ 0 0 0 0 1

scoreboard players remove #steps omlet.gun 1
execute if score #steps omlet.gun matches 1.. positioned ^ ^ ^0.25 run function omlet_dp:gun/ray
