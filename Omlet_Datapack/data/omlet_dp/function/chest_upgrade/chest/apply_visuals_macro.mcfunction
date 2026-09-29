$data modify block ~ ~ ~ CustomName set value {text:"$(name)",color:"$(color)"}
$data modify entity @e[type=item_display,tag=omlet.chest.display,distance=..0.1,limit=1] item.components."minecraft:item_model" set value "omlet_rp:chest/$(id)"
