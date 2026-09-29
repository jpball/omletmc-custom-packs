# Drops tmp.drop_item on top of the current position
data remove storage omlet_dp:chest_upgrade tmp.drop_item.Slot
summon minecraft:item ~ ~0.6 ~ {Tags:["omlet.chest.drop"],Item:{id:"minecraft:stone",count:1},PickupDelay:10s}
data modify entity @e[type=item,tag=omlet.chest.drop,limit=1] Item set from storage omlet_dp:chest_upgrade tmp.drop_item
tag @e[type=item,tag=omlet.chest.drop] remove omlet.chest.drop
