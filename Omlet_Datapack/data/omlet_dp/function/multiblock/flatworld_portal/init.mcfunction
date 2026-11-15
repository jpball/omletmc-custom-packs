# Temporary values (fake players), and whether travel to the flatworld is enabled
scoreboard objectives add omlet.portal dummy
execute unless score #travel_enabled omlet.portal matches 0..1 run scoreboard players set #travel_enabled omlet.portal 1

# Per travelling player: the portal they're leaving (X/Y/Z), whether it leads to the flatworld (1) or overworld (0),
# the Y to look for the destination portal at, and how long they've stood in the portal
scoreboard objectives add omlet.portal_x dummy
scoreboard objectives add omlet.portal_y dummy
scoreboard objectives add omlet.portal_z dummy
scoreboard objectives add omlet.portal_dest dummy
scoreboard objectives add omlet.portal_target dummy
scoreboard objectives add omlet.portal_timer dummy

# Per portal item frame: Y of the linked portal in the other dimension (linked portals share X/Z)
scoreboard objectives add omlet.portal_link dummy

# Left over from older versions
scoreboard objectives remove omlet.portal_axis
scoreboard objectives remove omlet.portal_linked

# The shape of a portal along each axis, passed to the macro functions (see with_axis).
# Offsets are from the portal's anchor: the bottom-middle interior block, where the item frame sits.
#   interior:  the 3x3 opening filled with light blocks
#   frame:     the plane the coarse dirt frame is built in
#   clearance: the space cleared when building a portal, leaving room to step off either side
#   spread:    particle spread across the opening
data modify storage omlet_dp:flatworld_portal axis.x set value {axis:"x", interior:"~-1 ~ ~ ~1 ~2 ~", frame:"~-2 ~-1 ~ ~2 ~3 ~", clearance:"~-2 ~-1 ~-1 ~2 ~3 ~1", spread:"0.8 0.8 0"}
data modify storage omlet_dp:flatworld_portal axis.z set value {axis:"z", interior:"~ ~ ~-1 ~ ~2 ~1", frame:"~ ~-1 ~-2 ~ ~3 ~2", clearance:"~-1 ~-1 ~-2 ~1 ~3 ~2", spread:"0 0.8 0.8"}
