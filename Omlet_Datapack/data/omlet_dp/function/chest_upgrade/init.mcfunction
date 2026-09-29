scoreboard objectives add omlet.chest dummy
scoreboard objectives add omlet.chest_tier dummy
scoreboard objectives add omlet.chest_page dummy
scoreboard objectives add omlet.chest_ui dummy

# Tier lookup table, indexed by tier number (0 = plain chest).
# Each tier chest item uses a survival-unobtainable block as its item id so crafting
# recipes can tell the tiers apart; placing one swaps it for a real chest (see place/).
# Keep these items in sync with the results in recipe/chest_upgrade/.
data modify storage omlet_dp:chest_upgrade tiers set value [\
    {id:"none",name:"Chest",color:"white"},\
    {id:"iron",name:"Iron Chest",color:"#D8D8D8",item:{id:"minecraft:infested_stone",count:1,components:{"minecraft:item_name":{text:"Iron Chest",color:"#D8D8D8"},"minecraft:item_model":"omlet_rp:chest/iron","minecraft:custom_data":{omlet_tier_chest:{tier:1}}}}},\
    {id:"gold",name:"Gold Chest",color:"#FAD64A",item:{id:"minecraft:infested_cobblestone",count:1,components:{"minecraft:item_name":{text:"Gold Chest",color:"#FAD64A"},"minecraft:item_model":"omlet_rp:chest/gold","minecraft:custom_data":{omlet_tier_chest:{tier:2}}}}},\
    {id:"diamond",name:"Diamond Chest",color:"#4AEDD9",item:{id:"minecraft:infested_stone_bricks",count:1,components:{"minecraft:item_name":{text:"Diamond Chest",color:"#4AEDD9"},"minecraft:item_model":"omlet_rp:chest/diamond","minecraft:custom_data":{omlet_tier_chest:{tier:3}}}}},\
    {id:"netherite",name:"Netherite Chest",color:"#8A7F8A",item:{id:"minecraft:infested_deepslate",count:1,components:{"minecraft:item_name":{text:"Netherite Chest",color:"#8A7F8A"},"minecraft:item_model":"omlet_rp:chest/netherite","minecraft:custom_data":{omlet_tier_chest:{tier:4}}}}}\
]

function omlet_dp:chest_upgrade/config

# Apply any config changes to chests that are currently loaded
execute as @e[type=marker,tag=omlet.chest] at @s if block ~ ~ ~ minecraft:chest run function omlet_dp:chest_upgrade/chest/refresh
