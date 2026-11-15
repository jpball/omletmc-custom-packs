# Run as and at a lamp's interaction hitbox that was punched: break the lamp. Creative players don't get the item back
execute align xyz positioned ~.5 ~.5 ~.5 on attacker unless entity @s[gamemode=creative] run loot spawn ~ ~ ~ loot omlet_dp:industrial_light
execute align xyz positioned ~.5 ~.5 ~.5 run function omlet_dp:flickeringlight/remove
