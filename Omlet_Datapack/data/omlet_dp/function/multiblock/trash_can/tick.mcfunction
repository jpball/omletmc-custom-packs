# Tag newly built trash cans
execute as @e[tag=!omlet.trash_can,predicate=omlet_dp:trash_can/valid,type=glow_item_frame] at @s run function omlet_dp:multiblock/trash_can/create_trashcan

# Remove the trash can tag from any no longer valid
execute as @e[tag=omlet.trash_can,predicate=!omlet_dp:trash_can/valid,type=glow_item_frame] run tag @s remove omlet.trash_can

# Trigger the trashcan logic only while the redstone lamp below the barrel is powered
execute as @e[tag=omlet.trash_can,type=glow_item_frame] at @s if block ~ ~-2 ~ minecraft:redstone_lamp[lit=true] run function omlet_dp:multiblock/trash_can/activate_trashcan
