# Tag newly built trash cans
execute as @e[type=glow_item_frame,tag=!is_trashcan,predicate=omlet_dp:is_trashcan] at @s run function omlet_dp:multiblock/trash_can/create_trashcan

# Remove the trash can tag from any no longer valid
execute as @e[type=glow_item_frame,tag=is_trashcan,predicate=!omlet_dp:is_trashcan] run tag @s remove is_trashcan

# Trigger the trashcan logic only while the redstone lamp below the chest is powered
execute as @e[type=glow_item_frame,tag=is_trashcan] at @s if block ~ ~-2 ~ minecraft:redstone_lamp[lit=true] run function omlet_dp:multiblock/trash_can/activate_trashcan
