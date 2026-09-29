# Run as and at a chest marker whose chest is gone.
# The block already dropped the page it was showing; drop every other page.
execute store result storage omlet_dp:chest_upgrade tmp.args.page int 1 run scoreboard players get @s omlet.chest_page
function omlet_dp:chest_upgrade/chest/forget_page with storage omlet_dp:chest_upgrade tmp.args
data modify storage omlet_dp:chest_upgrade tmp.drop_pages set from entity @s data.pages
function omlet_dp:chest_upgrade/util/drop_pages

# The block dropped a plain chest named after its tier; turn it back into the tier chest item
execute store result storage omlet_dp:chest_upgrade tmp.args.tier int 1 run scoreboard players get @s omlet.chest_tier
function omlet_dp:chest_upgrade/util/lookup_tier with storage omlet_dp:chest_upgrade tmp.args
function omlet_dp:chest_upgrade/chest/convert_drop with storage omlet_dp:chest_upgrade tmp.tier

kill @e[type=item_display,tag=omlet.chest.display,distance=..0.1]
scoreboard players reset @s
kill @s
