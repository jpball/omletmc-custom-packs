# Advancement reward: run as a player who just placed a tier chest item
advancement revoke @s only omlet_dp:chest_upgrade/place_tier_chest

# Find the block they just placed
scoreboard players set #ray omlet.chest 0
execute anchored eyes positioned ^ ^ ^ anchored feet run function omlet_dp:chest_upgrade/place/ray
