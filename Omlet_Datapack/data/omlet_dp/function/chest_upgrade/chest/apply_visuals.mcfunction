# Run as and at a chest marker. Names the chest and recolors its overlay for its tier.
execute store result storage omlet_dp:chest_upgrade tmp.args.tier int 1 run scoreboard players get @s omlet.chest_tier
function omlet_dp:chest_upgrade/util/lookup_tier with storage omlet_dp:chest_upgrade tmp.args
function omlet_dp:chest_upgrade/chest/apply_visuals_macro with storage omlet_dp:chest_upgrade tmp.tier
