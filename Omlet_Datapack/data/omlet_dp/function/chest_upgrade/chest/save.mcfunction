# Run as and at a chest marker. Stores the chest's current contents into data.pages[page].
# Anything a player swapped into a button/locked slot is dropped first so it isn't lost.
data modify storage omlet_dp:chest_upgrade tmp.layout set from entity @s data.layout
function omlet_dp:chest_upgrade/layout/eject_loop

execute store result storage omlet_dp:chest_upgrade tmp.args.page int 1 run scoreboard players get @s omlet.chest_page
function omlet_dp:chest_upgrade/chest/save_page with storage omlet_dp:chest_upgrade tmp.args
