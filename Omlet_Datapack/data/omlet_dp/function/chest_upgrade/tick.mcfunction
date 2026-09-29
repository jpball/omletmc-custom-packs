execute as @e[type=marker,tag=omlet.chest] at @s run function omlet_dp:chest_upgrade/chest/tick

# Page buttons and locked-slot panes must never leave the chest
execute as @e[type=item] if items entity @s contents *[minecraft:custom_data~{omlet_ui:1b}] run kill @s
clear @a *[minecraft:custom_data~{omlet_ui:1b}]
