data modify entity @s data.pages append value []
$execute unless data entity @s data.pages[$(last)] run function omlet_dp:chest_upgrade/chest/grow_pages {last:$(last)}
