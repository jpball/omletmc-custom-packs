# Try to activate a frame when an upward-facing (pitch -90) glow item frame holding a diamond block is placed in it
execute as @e[tag=!omlet.portal,x_rotation=-90,predicate=omlet_dp:flatworld_portal/has_key,type=glow_item_frame] at @s run function omlet_dp:multiblock/flatworld_portal/try_activate

# Keep active portals lit, and shut down any whose frame was broken or whose diamond block was taken
execute as @e[tag=omlet.portal,type=glow_item_frame] at @s align xyz run function omlet_dp:multiblock/flatworld_portal/with_axis {run:"portal_tick"}

# Players must step out of a portal before they can use one again
tag @a[tag=omlet.portal_cooldown,predicate=!omlet_dp:flatworld_portal/in_portal] remove omlet.portal_cooldown

execute as @a[tag=omlet.portal_travel] at @s run function omlet_dp:multiblock/flatworld_portal/travel/tick
execute as @a[tag=!omlet.portal_travel,tag=!omlet.portal_cooldown,predicate=omlet_dp:flatworld_portal/in_portal] at @s if entity @e[tag=omlet.portal,distance=..4,type=glow_item_frame] run function omlet_dp:multiblock/flatworld_portal/travel/start
