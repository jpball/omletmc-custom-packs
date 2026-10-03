# Run as the glow item frame of a portal whose frame was broken or whose diamond block was taken
fill ~-1 ~ ~ ~1 ~2 ~ minecraft:air replace minecraft:light[level=11]
playsound minecraft:block.beacon.deactivate block @a ~0.5 ~1.5 ~0.5
tellraw @a[distance=..8] {"text":"Flatworld portal broken!","color":"red","bold":true}
tag @s remove omlet.portal
tag @s remove omlet.portal_x

# Generated portals' item frames can't be taken apart, so remove them (without dropping the diamond block)
execute if entity @s[tag=omlet.portal_generated] run item replace entity @s contents with minecraft:air
execute if entity @s[tag=omlet.portal_generated] run kill @s
