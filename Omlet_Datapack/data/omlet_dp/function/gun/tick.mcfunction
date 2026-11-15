scoreboard players remove @a[scores={omlet.gun_cooldown=1..}] omlet.gun_cooldown 1
execute as @a[scores={omlet.gun_used=1..}] at @s run function omlet_dp:gun/try_shoot
