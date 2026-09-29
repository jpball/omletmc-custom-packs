# Run as the player, positioned at the center of the placeholder block they placed
execute if block ~ ~ ~ minecraft:infested_stone run scoreboard players set #tier omlet.chest 1
execute if block ~ ~ ~ minecraft:infested_cobblestone run scoreboard players set #tier omlet.chest 2
execute if block ~ ~ ~ minecraft:infested_stone_bricks run scoreboard players set #tier omlet.chest 3
execute if block ~ ~ ~ minecraft:infested_deepslate run scoreboard players set #tier omlet.chest 4

# Swap it for a chest facing the player
execute if entity @s[y_rotation=-45..45] run setblock ~ ~ ~ minecraft:chest[facing=north]
execute if block ~ ~ ~ #omlet_dp:tier_chest_placeholder if entity @s[y_rotation=45..135] run setblock ~ ~ ~ minecraft:chest[facing=east]
execute if block ~ ~ ~ #omlet_dp:tier_chest_placeholder if entity @s[y_rotation=-135..-45] run setblock ~ ~ ~ minecraft:chest[facing=west]
execute if block ~ ~ ~ #omlet_dp:tier_chest_placeholder run setblock ~ ~ ~ minecraft:chest[facing=south]

function omlet_dp:chest_upgrade/place/create
