# Places the UI item for each entry in tmp.layout
execute unless data storage omlet_dp:chest_upgrade tmp.layout[0] run return 0
data modify storage omlet_dp:chest_upgrade tmp.entry set from storage omlet_dp:chest_upgrade tmp.layout[0]
data modify storage omlet_dp:chest_upgrade tmp.entry merge from storage omlet_dp:chest_upgrade tmp.page_info
function omlet_dp:chest_upgrade/slot/apply with storage omlet_dp:chest_upgrade tmp.entry
data remove storage omlet_dp:chest_upgrade tmp.layout[0]
function omlet_dp:chest_upgrade/layout/apply_loop
