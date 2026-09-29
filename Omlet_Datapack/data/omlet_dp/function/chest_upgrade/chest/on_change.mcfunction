# Run as and at a chest marker whose UI items no longer match the layout
scoreboard players set #dir omlet.chest 0

# A button counts as clicked only if a nearby player is now holding it
scoreboard players set #held omlet.chest 0
execute unless items block ~ ~ ~ container.26 *[minecraft:custom_data~{omlet_ui_action:"next"}] store result score #held omlet.chest run clear @a[distance=..8] *[minecraft:custom_data~{omlet_ui_action:"next"}] 0
execute if score #held omlet.chest matches 1.. run scoreboard players set #dir omlet.chest 1

scoreboard players set #held omlet.chest 0
execute unless items block ~ ~ ~ container.18 *[minecraft:custom_data~{omlet_ui_action:"prev"}] store result score #held omlet.chest run clear @a[distance=..8] *[minecraft:custom_data~{omlet_ui_action:"prev"}] 0
execute if score #held omlet.chest matches 1.. run scoreboard players set #dir omlet.chest -1

function omlet_dp:chest_upgrade/chest/save

# Turn the page, wrapping around at either end
function omlet_dp:chest_upgrade/chest/calc
scoreboard players operation @s omlet.chest_page += #dir omlet.chest
execute if score @s omlet.chest_page matches ..-1 run scoreboard players operation @s omlet.chest_page = #last omlet.chest
execute if score @s omlet.chest_page > #last omlet.chest run scoreboard players set @s omlet.chest_page 0

function omlet_dp:chest_upgrade/chest/render

execute unless score #dir omlet.chest matches 0 run playsound minecraft:item.book.page_turn block @a ~ ~ ~ 1 1

# A hopper underneath may have pulled a UI item out
execute if block ~ ~-1 ~ minecraft:hopper run data remove block ~ ~-1 ~ Items[{components:{"minecraft:custom_data":{omlet_ui:1b}}}]
