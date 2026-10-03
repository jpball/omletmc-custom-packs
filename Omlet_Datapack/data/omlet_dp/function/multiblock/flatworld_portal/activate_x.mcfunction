# Run as a glow item frame holding a diamond block, positioned at the anchor of an empty, valid portal frame
fill ~-1 ~ ~ ~1 ~2 ~ minecraft:light[level=11]
tag @s add omlet.portal
tag @s add omlet.portal_x

playsound minecraft:block.end_portal.spawn block @a ~0.5 ~1.5 ~0.5 0.6 1.2
particle minecraft:happy_villager ~0.5 ~1.5 ~0.5 0.8 0.8 0 0 30
tellraw @a[distance=..8] {"text":"Flatworld portal activated!","color":"green","bold":true}
