execute if block ~ ~ ~ #omlet_dp:tier_chest_placeholder align xyz positioned ~0.5 ~0.5 ~0.5 run return run function omlet_dp:chest_upgrade/place/setup
scoreboard players add #ray omlet.chest 1
execute if score #ray omlet.chest matches ..80 positioned ^ ^ ^0.1 run function omlet_dp:chest_upgrade/place/ray
