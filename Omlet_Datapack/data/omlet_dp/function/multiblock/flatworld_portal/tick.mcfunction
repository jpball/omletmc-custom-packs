# Activate a frame when an upward-facing glow item frame holding a diamond block is placed on the middle of its bottom
execute as @e[type=glow_item_frame,tag=!omlet.portal] if items entity @s contents minecraft:diamond_block if entity @s[nbt={Facing:1b}] at @s run function omlet_dp:multiblock/flatworld_portal/try_activate

# Keep active portals lit, and shut down any whose frame was broken or whose diamond block was taken
execute as @e[type=glow_item_frame,tag=omlet.portal,tag=omlet.portal_x] at @s align xyz run function omlet_dp:multiblock/flatworld_portal/portal_tick_x
execute as @e[type=glow_item_frame,tag=omlet.portal,tag=omlet.portal_z] at @s align xyz run function omlet_dp:multiblock/flatworld_portal/portal_tick_z

# Players must step out of a portal before they can use one again
execute as @a[tag=omlet.portal_cooldown] at @s unless block ~ ~ ~ minecraft:light[level=11] run tag @s remove omlet.portal_cooldown

execute as @a[tag=omlet.portal_travel] at @s run function omlet_dp:multiblock/flatworld_portal/travel/tick
execute as @a[tag=!omlet.portal_travel,tag=!omlet.portal_cooldown] at @s if block ~ ~ ~ minecraft:light[level=11] if entity @e[type=glow_item_frame,tag=omlet.portal,distance=..4] run function omlet_dp:multiblock/flatworld_portal/travel/start
