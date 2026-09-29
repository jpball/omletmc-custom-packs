# Drops a real (non-UI) item out of chest slot $(slot)
$execute unless items block ~ ~ ~ container.$(slot) * run return 0
$execute if items block ~ ~ ~ container.$(slot) *[minecraft:custom_data~{omlet_ui:1b}] run return 0
$data modify storage omlet_dp:chest_upgrade tmp.drop_item set from block ~ ~ ~ Items[{Slot:$(slot)b}]
function omlet_dp:chest_upgrade/util/drop_item
$item replace block ~ ~ ~ container.$(slot) with minecraft:air
