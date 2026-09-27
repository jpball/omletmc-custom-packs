# Tag newly built trash cans and untag broken ones
execute as @e[type=glow_item_frame,tag=!is_trashcan,predicate=omlet_dp:is_trashcan] at @s run function omlet_dp:trash_can/create_trashcan
execute as @e[type=glow_item_frame,tag=is_trashcan,predicate=!omlet_dp:is_trashcan] run tag @s remove is_trashcan

execute as @e[type=glow_item_frame,tag=is_trashcan] at @s run function omlet_dp:trash_can/activate_trashcan
