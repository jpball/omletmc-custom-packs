# Lists every car. Click an entry to spawn that car where you're standing.
# Usage: /function omlet_dp:car/list
# To add a car: add its item definition to Omlet_ResourcePack/assets/omlet_rp/items/ and a loot table to loot_table/car/
# (copy mustang.json), then copy an entry line below, changing the name and the loot table name
tellraw @s {"text":"Cars (click to spawn):","color":"gold","bold":true}
tellraw @s {"text":"- Ford Mustang","color":"green","click_event":{"action":"run_command","command":"/function omlet_dp:car/create {car:\"mustang\"}"}}
