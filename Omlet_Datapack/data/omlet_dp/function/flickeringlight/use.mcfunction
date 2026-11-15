# Run as and at a lamp's interaction hitbox that was right-clicked. Only a sneaking player switches it
execute align xyz positioned ~.5 ~.5 ~.5 on target if predicate omlet_dp:is_sneaking as @n[type=minecraft:item_display,tag=omlet.industrial_light,distance=..0.6] at @s run function omlet_dp:flickeringlight/toggle
data remove entity @s interaction
