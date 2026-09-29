# Drops and removes every page at index >= count
$execute unless data entity @s data.pages[$(count)] run return 0
$data modify storage omlet_dp:chest_upgrade tmp.drop_list set from entity @s data.pages[$(count)]
function omlet_dp:chest_upgrade/util/drop_list
$data remove entity @s data.pages[$(count)]
$function omlet_dp:chest_upgrade/chest/trim_pages {count:$(count)}
