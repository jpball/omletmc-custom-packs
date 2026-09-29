# Drops any real item sitting in a reserved slot listed in tmp.layout
execute unless data storage omlet_dp:chest_upgrade tmp.layout[0] run return 0
function omlet_dp:chest_upgrade/slot/eject with storage omlet_dp:chest_upgrade tmp.layout[0]
data remove storage omlet_dp:chest_upgrade tmp.layout[0]
function omlet_dp:chest_upgrade/layout/eject_loop
