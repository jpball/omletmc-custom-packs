$data modify entity @s data.pages[$(page)] set value []
$data modify entity @s data.pages[$(page)] set from block ~ ~ ~ Items
$data remove entity @s data.pages[$(page)][{components:{"minecraft:custom_data":{omlet_ui:1b}}}]
