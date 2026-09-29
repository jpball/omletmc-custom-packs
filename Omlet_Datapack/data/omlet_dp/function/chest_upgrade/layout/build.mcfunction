# Run as a chest marker after chest/calc. Fills data.layout with the reserved slots of the
# current page: [{slot:<n>,kind:"prev"|"next"|"lock"}, ...]
data modify entity @s data.layout set value []
execute if score #pages omlet.chest matches 2.. run data modify entity @s data.layout append value {slot:18,kind:"prev"}
execute if score #pages omlet.chest matches 2.. run data modify entity @s data.layout append value {slot:26,kind:"next"}

# Only the last page has locked slots
execute unless score @s omlet.chest_page = #last omlet.chest run return 0
scoreboard players operation #i omlet.chest = #used_last omlet.chest
function omlet_dp:chest_upgrade/layout/lock_loop
