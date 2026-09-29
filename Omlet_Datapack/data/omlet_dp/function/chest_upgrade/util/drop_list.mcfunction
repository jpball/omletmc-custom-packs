# Drops every item in tmp.drop_list
execute unless data storage omlet_dp:chest_upgrade tmp.drop_list[0] run return 0
data modify storage omlet_dp:chest_upgrade tmp.drop_item set from storage omlet_dp:chest_upgrade tmp.drop_list[0]
function omlet_dp:chest_upgrade/util/drop_item
data remove storage omlet_dp:chest_upgrade tmp.drop_list[0]
function omlet_dp:chest_upgrade/util/drop_list
