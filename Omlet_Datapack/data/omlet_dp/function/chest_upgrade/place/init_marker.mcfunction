scoreboard players operation @s omlet.chest_tier = #tier omlet.chest
execute store result entity @s data.tier int 1 run scoreboard players get @s omlet.chest_tier
scoreboard players set @s omlet.chest_page 0
scoreboard players set @s omlet.chest_ui 0

function omlet_dp:chest_upgrade/chest/render
function omlet_dp:chest_upgrade/chest/apply_visuals
