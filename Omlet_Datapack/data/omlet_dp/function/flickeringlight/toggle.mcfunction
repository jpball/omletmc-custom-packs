# Run as and at a lamp display that a sneaking player right-clicked: switch it off, or back on
execute if entity @s[tag=omlet.light_disabled] run playsound minecraft:block.copper_bulb.turn_on block @a ~ ~ ~
execute if entity @s[tag=omlet.light_disabled] run return run function omlet_dp:flickeringlight/light_on

tag @s add omlet.light_disabled
function omlet_dp:flickeringlight/light_off
playsound minecraft:block.copper_bulb.turn_off block @a ~ ~ ~
