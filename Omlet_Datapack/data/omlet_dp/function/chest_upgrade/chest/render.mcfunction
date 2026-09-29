# Run as and at a chest marker. Loads data.pages[page] into the chest and places the
# page buttons and locked slots. Call chest/save first so nothing is overwritten.
function omlet_dp:chest_upgrade/chest/calc

execute if score @s omlet.chest_page > #last omlet.chest run scoreboard players operation @s omlet.chest_page = #last omlet.chest
execute if score @s omlet.chest_page matches ..-1 run scoreboard players set @s omlet.chest_page 0
execute store result entity @s data.page int 1 run scoreboard players get @s omlet.chest_page

# Make data.pages exactly #pages long (drops items from pages that no longer exist)
execute store result storage omlet_dp:chest_upgrade tmp.args.page int 1 run scoreboard players get @s omlet.chest_page
execute store result storage omlet_dp:chest_upgrade tmp.args.last int 1 run scoreboard players get #last omlet.chest
execute store result storage omlet_dp:chest_upgrade tmp.args.count int 1 run scoreboard players get #pages omlet.chest
function omlet_dp:chest_upgrade/chest/fit_pages with storage omlet_dp:chest_upgrade tmp.args

function omlet_dp:chest_upgrade/chest/load_page with storage omlet_dp:chest_upgrade tmp.args

# Page numbers shown on the buttons
scoreboard players operation #display omlet.chest = @s omlet.chest_page
scoreboard players add #display omlet.chest 1
execute store result storage omlet_dp:chest_upgrade tmp.page_info.display int 1 run scoreboard players get #display omlet.chest
execute store result storage omlet_dp:chest_upgrade tmp.page_info.pages int 1 run scoreboard players get #pages omlet.chest

function omlet_dp:chest_upgrade/layout/build
data modify storage omlet_dp:chest_upgrade tmp.layout set from entity @s data.layout
function omlet_dp:chest_upgrade/layout/apply_loop

execute store result score @s omlet.chest_ui run data get entity @s data.layout
