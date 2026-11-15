# Run as and at a lamp display every tick. Someone placed a block into the (replaceable) light block: break the lamp
execute unless block ~ ~ ~ minecraft:light run return run function omlet_dp:flickeringlight/break

# Switched off: no flickering
execute if entity @s[tag=omlet.light_disabled] run return 0

scoreboard players remove @s omlet.light_timer 1
execute if score @s omlet.light_timer matches ..0 if entity @s[tag=omlet.light_off] run return run function omlet_dp:flickeringlight/turn_on
execute if score @s omlet.light_timer matches ..0 run function omlet_dp:flickeringlight/turn_off
