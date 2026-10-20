# Run as and at a lamp's interaction hitbox that was punched. Creative players don't get the item back
scoreboard players set #creative omlet.light 0
execute store success score #creative omlet.light on attacker if entity @s[gamemode=creative]
execute if score #creative omlet.light matches 1 align xyz positioned ~.5 ~.5 ~.5 run return run function omlet_dp:flickeringlight/remove
execute align xyz positioned ~.5 ~.5 ~.5 run function omlet_dp:flickeringlight/break
