# Drops every item on every page in tmp.drop_pages
execute unless data storage omlet_dp:chest_upgrade tmp.drop_pages[0] run return 0
data modify storage omlet_dp:chest_upgrade tmp.drop_list set from storage omlet_dp:chest_upgrade tmp.drop_pages[0]
function omlet_dp:chest_upgrade/util/drop_list
data remove storage omlet_dp:chest_upgrade tmp.drop_pages[0]
function omlet_dp:chest_upgrade/util/drop_pages
