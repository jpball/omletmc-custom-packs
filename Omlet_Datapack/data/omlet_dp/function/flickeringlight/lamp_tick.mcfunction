# Run as and at a lamp display every tick

# Someone placed a block into the (replaceable) light block: break the lamp
execute unless block ~ ~ ~ minecraft:light run loot spawn ~ ~ ~ loot omlet_dp:industrial_light
execute unless block ~ ~ ~ minecraft:light run return run function omlet_dp:flickeringlight/remove

# Switched off: no flickering
execute if entity @s[tag=omlet.light_disabled] run return 0

# Count down to the next flicker, or to the end of the current one
scoreboard players remove @s omlet.light_timer 1
execute if score @s omlet.light_timer matches 1.. run return 0
execute if entity @s[tag=omlet.light_off] run return run function omlet_dp:flickeringlight/light_on
function omlet_dp:flickeringlight/light_off
