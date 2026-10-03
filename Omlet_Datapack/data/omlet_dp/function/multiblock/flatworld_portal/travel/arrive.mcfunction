# Macro, run as a player who has stood in a portal long enough to travel.
# Note: whole-number X/Z coordinates are read as block centres, which is where portal item frames sit;
# `align` snaps back to the block corner where a portal's anchor block is needed.
# Wait until the destination (blocks and entities) has loaded
$execute in $(dim) positioned $(x) 0 $(z) unless loaded ~-2 0 ~-2 run return run function omlet_dp:multiblock/flatworld_portal/travel/forceload with storage omlet_dp:flatworld_portal args
$execute in $(dim) positioned $(x) 0 $(z) unless loaded ~2 0 ~2 run return run function omlet_dp:multiblock/flatworld_portal/travel/forceload with storage omlet_dp:flatworld_portal args

# 1. The linked portal, if this portal has one and it still exists
$execute if score @s omlet.portal_linked matches 1 in $(dim) positioned $(x) $(y) $(z) run tag @e[type=glow_item_frame,tag=omlet.portal,distance=..0.5,limit=1] add omlet.portal_dest

# 2. Otherwise, any portal in the same X/Z column, closest to the target Y
$execute unless entity @e[type=glow_item_frame,tag=omlet.portal_dest] in $(dim) run tag @e[type=glow_item_frame,tag=omlet.portal,x=$(x),y=-64,z=$(z),dx=0,dy=383,dz=0] add omlet.portal_candidate
$execute unless entity @e[type=glow_item_frame,tag=omlet.portal_dest] in $(dim) positioned $(x) $(y) $(z) run tag @e[type=glow_item_frame,tag=omlet.portal_candidate,sort=nearest,limit=1] add omlet.portal_dest
tag @e[type=glow_item_frame,tag=omlet.portal_candidate] remove omlet.portal_candidate

# 3. Otherwise build a new portal at ground height
$execute unless entity @e[type=glow_item_frame,tag=omlet.portal_dest] in $(dim) positioned $(x) 0 $(z) align xz positioned over motion_blocking_no_leaves positioned ~ ~1 ~ run function omlet_dp:multiblock/flatworld_portal/build_$(axis)

# Link both portals to each other so return trips come back to the same pair
scoreboard players operation @e[type=glow_item_frame,tag=omlet.portal_dest] omlet.portal_link = @s omlet.portal_y
execute store result score #dest_y omlet.portal run data get entity @e[type=glow_item_frame,tag=omlet.portal_dest,limit=1] Pos[1]
$execute in $(src) positioned $(x) $(src_y) $(z) run scoreboard players operation @e[type=glow_item_frame,tag=omlet.portal,distance=..0.5] omlet.portal_link = #dest_y omlet.portal

# Arrive standing on the destination portal's item frame, in the middle of the portal
execute at @e[type=glow_item_frame,tag=omlet.portal_dest,limit=1] run tp @s ~ ~ ~
tag @e[type=glow_item_frame,tag=omlet.portal_dest] remove omlet.portal_dest
execute at @s run playsound minecraft:entity.enderman.teleport player @a ~ ~ ~ 0.8 0.8

tag @s add omlet.portal_cooldown
function omlet_dp:multiblock/flatworld_portal/travel/cancel
