# Run as a lamp display, positioned at its block centre
execute if entity @s[tag=omlet.light_disabled] run return run function omlet_dp:flickeringlight/switch_on
function omlet_dp:flickeringlight/switch_off
