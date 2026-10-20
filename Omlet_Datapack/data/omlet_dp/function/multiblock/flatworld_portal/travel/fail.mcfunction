# Macro {message:"<reason>"}, run as a player whose travel can't go ahead.
# The cooldown stops them retrying every tick until they step out of the portal
$title @s actionbar {"text":"$(message)","color":"red"}
tag @s add omlet.portal_cooldown
execute if entity @s[tag=omlet.portal_travel] run function omlet_dp:multiblock/flatworld_portal/travel/cancel
