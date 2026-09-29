# Run as and at an upgraded chest's marker every tick
execute unless block ~ ~ ~ minecraft:chest run return run function omlet_dp:chest_upgrade/chest/broken

# A chest was placed next to this one and merged into a double chest
execute unless block ~ ~ ~ minecraft:chest[type=single] run function omlet_dp:chest_upgrade/chest/normalize

# A button/lock went missing (player clicked it, or a hopper took it)
execute store result score #ui omlet.chest if items block ~ ~ ~ container.* *[minecraft:custom_data~{omlet_ui:1b}]
execute unless score #ui omlet.chest = @s omlet.chest_ui run function omlet_dp:chest_upgrade/chest/on_change
