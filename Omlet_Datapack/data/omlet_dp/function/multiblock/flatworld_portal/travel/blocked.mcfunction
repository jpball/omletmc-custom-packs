# Run as a player trying to enter the flatworld while travel there is disabled.
# The cooldown stops this repeating every tick until they step out of the portal
title @s actionbar {"text":"Travel to the Flatworld is currently disabled","color":"red"}
tag @s add omlet.portal_cooldown
