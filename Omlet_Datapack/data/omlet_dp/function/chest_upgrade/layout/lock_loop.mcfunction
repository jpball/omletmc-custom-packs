# Locks usable slot #i through #per - 1. With page buttons, usable slot 18 onward
# shifts right by one to skip the "previous" button in chest slot 18.
execute if score #i omlet.chest >= #per omlet.chest run return 0

scoreboard players operation #slot omlet.chest = #i omlet.chest
execute if score #per omlet.chest matches 25 if score #i omlet.chest matches 18.. run scoreboard players add #slot omlet.chest 1
data modify storage omlet_dp:chest_upgrade tmp.entry set value {kind:"lock"}
execute store result storage omlet_dp:chest_upgrade tmp.entry.slot int 1 run scoreboard players get #slot omlet.chest
data modify entity @s data.layout append from storage omlet_dp:chest_upgrade tmp.entry

scoreboard players add #i omlet.chest 1
function omlet_dp:chest_upgrade/layout/lock_loop
