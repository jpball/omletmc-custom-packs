# Run as a chest marker. Works out the chest's layout from its tier and the config:
#   #cap       total usable slots
#   #per       usable slots per page (27 for one page, 25 when page buttons are needed)
#   #pages     number of pages
#   #last      index of the last page
#   #used_last usable slots on the last page (the rest are locked)
scoreboard players set #cap omlet.chest 27
execute if score @s omlet.chest_tier matches 1.. run scoreboard players operation #cap omlet.chest += #iron_extra omlet.chest
execute if score @s omlet.chest_tier matches 2.. run scoreboard players operation #cap omlet.chest += #gold_extra omlet.chest
execute if score @s omlet.chest_tier matches 3.. run scoreboard players operation #cap omlet.chest += #diamond_extra omlet.chest
execute if score @s omlet.chest_tier matches 4.. run scoreboard players operation #cap omlet.chest += #netherite_extra omlet.chest
execute if score #cap omlet.chest matches ..0 run scoreboard players set #cap omlet.chest 1

scoreboard players set #per omlet.chest 27
scoreboard players set #pages omlet.chest 1
execute if score #cap omlet.chest matches 28.. run scoreboard players set #per omlet.chest 25
# pages = ceil(cap / per)
execute if score #cap omlet.chest matches 28.. run scoreboard players operation #pages omlet.chest = #cap omlet.chest
execute if score #cap omlet.chest matches 28.. run scoreboard players add #pages omlet.chest 24
execute if score #cap omlet.chest matches 28.. run scoreboard players operation #pages omlet.chest /= #per omlet.chest

scoreboard players operation #last omlet.chest = #pages omlet.chest
scoreboard players remove #last omlet.chest 1

scoreboard players operation #before_last omlet.chest = #last omlet.chest
scoreboard players operation #before_last omlet.chest *= #per omlet.chest
scoreboard players operation #used_last omlet.chest = #cap omlet.chest
scoreboard players operation #used_last omlet.chest -= #before_last omlet.chest
