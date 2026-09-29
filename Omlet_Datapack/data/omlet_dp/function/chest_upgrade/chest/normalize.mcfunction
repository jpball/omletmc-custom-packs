# Run at a chest block. Turns it into a single (unmerged) plain chest, keeping its facing and items.
# Upgraded chests are always plain single chests underneath the tier overlay.
data modify storage omlet_dp:chest_upgrade tmp.norm_items set value []
data modify storage omlet_dp:chest_upgrade tmp.norm_items set from block ~ ~ ~ Items

execute if block ~ ~ ~ minecraft:chest[facing=north] run setblock ~ ~ ~ minecraft:chest[facing=north,type=single]
execute if block ~ ~ ~ minecraft:chest[facing=south] run setblock ~ ~ ~ minecraft:chest[facing=south,type=single]
execute if block ~ ~ ~ minecraft:chest[facing=east] run setblock ~ ~ ~ minecraft:chest[facing=east,type=single]
execute if block ~ ~ ~ minecraft:chest[facing=west] run setblock ~ ~ ~ minecraft:chest[facing=west,type=single]

data modify block ~ ~ ~ Items set from storage omlet_dp:chest_upgrade tmp.norm_items
