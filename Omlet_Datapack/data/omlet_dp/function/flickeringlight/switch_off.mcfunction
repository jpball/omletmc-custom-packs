# Run as a lamp display, positioned at its block centre
tag @s add omlet.light_disabled
tag @s remove omlet.light_off
function omlet_dp:flickeringlight/set_level {level:0}
data remove entity @s brightness
playsound minecraft:block.copper_bulb.turn_off block @a ~ ~ ~
