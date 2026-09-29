# Run at the center of a freshly placed tier chest. #tier = its tier.
summon minecraft:marker ~ ~ ~ {Tags:["omlet.chest"],data:{page:0,pages:[[]],layout:[]}}
summon minecraft:item_display ~ ~ ~ {Tags:["omlet.chest.display"],item:{id:"minecraft:chest",count:1},item_display:"none",transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[1f,1f,1f]}}

# Face the overlay the same way as the chest
execute if block ~ ~ ~ minecraft:chest[facing=south] run data modify entity @e[type=item_display,tag=omlet.chest.display,distance=..0.1,limit=1] Rotation set value [0f,0f]
execute if block ~ ~ ~ minecraft:chest[facing=west] run data modify entity @e[type=item_display,tag=omlet.chest.display,distance=..0.1,limit=1] Rotation set value [90f,0f]
execute if block ~ ~ ~ minecraft:chest[facing=north] run data modify entity @e[type=item_display,tag=omlet.chest.display,distance=..0.1,limit=1] Rotation set value [180f,0f]
execute if block ~ ~ ~ minecraft:chest[facing=east] run data modify entity @e[type=item_display,tag=omlet.chest.display,distance=..0.1,limit=1] Rotation set value [270f,0f]

execute as @e[type=marker,tag=omlet.chest,distance=..0.1,limit=1] run function omlet_dp:chest_upgrade/place/init_marker
