# Run as a lamp display, positioned at its block centre
tag @s remove omlet.light_disabled
function omlet_dp:flickeringlight/set_level {level:15}
data merge entity @s {brightness:{sky:15,block:15}}
function omlet_dp:flickeringlight/next_flicker
playsound minecraft:block.copper_bulb.turn_on block @a ~ ~ ~
