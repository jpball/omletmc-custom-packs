# Temporary values (fake players), and whether travel to the flatworld is enabled
scoreboard objectives add omlet.portal dummy
execute unless score #travel_enabled omlet.portal matches 0..1 run scoreboard players set #travel_enabled omlet.portal 1

# Per player: the portal they are travelling from, and how long they've stood in it
scoreboard objectives add omlet.portal_x dummy
scoreboard objectives add omlet.portal_y dummy
scoreboard objectives add omlet.portal_z dummy
scoreboard objectives add omlet.portal_axis dummy
scoreboard objectives add omlet.portal_dest dummy
scoreboard objectives add omlet.portal_timer dummy

# Per portal item frame: Y of the linked portal in the other dimension (linked portals share X/Z).
# Per player: the Y of the destination portal, and whether it is a known link (1) or just a guess (0)
scoreboard objectives add omlet.portal_link dummy
scoreboard objectives add omlet.portal_linked dummy
