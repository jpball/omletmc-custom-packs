# Run as and at a lamp display: go dark for 1-6 ticks
tag @s add omlet.light_off
function omlet_dp:flickeringlight/set_level {level:0}
data remove entity @s brightness
execute store result score @s omlet.light_timer run random value 1..6
