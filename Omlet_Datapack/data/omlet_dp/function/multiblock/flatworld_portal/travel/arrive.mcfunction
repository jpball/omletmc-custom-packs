# Macro (see with_args), run as a player who has stood in a portal long enough to travel.
# Note: whole-number X/Z coordinates are read as block centres, which is where portal item frames sit;
# `align` snaps back to the block corner where a portal's anchor block is needed.

# Wait until the destination (blocks and entities) has loaded. Re-adding the forceload covers another
# player's cancelled trip having removed it
$execute in $(dim) positioned $(x) 0 $(z) unless loaded ~-2 0 ~-2 run return run function omlet_dp:multiblock/flatworld_portal/travel/forceload with storage omlet_dp:flatworld_portal args
$execute in $(dim) positioned $(x) 0 $(z) unless loaded ~2 0 ~2 run return run function omlet_dp:multiblock/flatworld_portal/travel/forceload with storage omlet_dp:flatworld_portal args

# The portal being left (the player is standing in it, so it's loaded)
$execute in $(src) positioned $(x) $(y) $(z) run tag @e[tag=omlet.portal,distance=..0.5,limit=1,type=glow_item_frame] add omlet.portal_src

# Destination: the portal in the same X/Z column closest to the target Y. This is the linked portal when it still exists
$execute in $(dim) run tag @e[tag=omlet.portal,x=$(x),y=-64,z=$(z),dx=0,dy=383,dz=0,type=glow_item_frame] add omlet.portal_candidate
$execute in $(dim) positioned $(x) $(target_y) $(z) run tag @e[tag=omlet.portal_candidate,sort=nearest,limit=1,type=glow_item_frame] add omlet.portal_dest
tag @e[tag=omlet.portal_candidate,type=glow_item_frame] remove omlet.portal_candidate

# Otherwise build a new portal at ground height, along the same axis as the one being left
$execute unless entity @e[tag=omlet.portal_dest,type=glow_item_frame] as @e[tag=omlet.portal_src,type=glow_item_frame] in $(dim) positioned $(x) 0 $(z) align xz positioned over motion_blocking_no_leaves positioned ~ ~1 ~ run function omlet_dp:multiblock/flatworld_portal/with_axis {run:"build"}

# Link both portals to each other so return trips come back to the same pair
scoreboard players operation @e[tag=omlet.portal_dest,type=glow_item_frame] omlet.portal_link = @s omlet.portal_y
execute store result score @e[tag=omlet.portal_src,type=glow_item_frame] omlet.portal_link run data get entity @e[tag=omlet.portal_dest,limit=1,type=glow_item_frame] Pos[1]

# Arrive standing on the destination portal's item frame, in the middle of the portal (keeping the player's rotation)
execute at @e[tag=omlet.portal_dest,limit=1,type=glow_item_frame] run tp @s ~ ~ ~
tag @e[tag=omlet.portal_dest,type=glow_item_frame] remove omlet.portal_dest
tag @e[tag=omlet.portal_src,type=glow_item_frame] remove omlet.portal_src
execute at @s run playsound minecraft:entity.enderman.teleport player @a ~ ~ ~ 0.8 0.8

tag @s add omlet.portal_cooldown
function omlet_dp:multiblock/flatworld_portal/travel/cancel
