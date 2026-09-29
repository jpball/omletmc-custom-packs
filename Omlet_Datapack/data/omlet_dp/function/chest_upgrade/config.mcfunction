# ============================================================
#  Chest Upgrade Configuration
# ============================================================
# A plain chest holds 27 slots. Each value below is how many
# slots that tier ADDS on top of the tier before it.
#
# Once a chest needs more than 27 slots it gets split into pages
# of 25 slots each (2 slots per page hold the page buttons). Any
# slots past the chest's capacity on the last page are locked.
#
# After changing these, run /reload. Loaded chests update right
# away; others update the next time they're used. If a tier
# shrinks, items that no longer fit drop on top of the chest.
# ============================================================

# Iron:      27 + 27 = 54 slots
scoreboard players set #iron_extra omlet.chest 27
# Gold:      54 + 27 = 81 slots
scoreboard players set #gold_extra omlet.chest 27
# Diamond:   81 + 27 = 108 slots
scoreboard players set #diamond_extra omlet.chest 27
# Netherite: 108 + 27 = 135 slots
scoreboard players set #netherite_extra omlet.chest 27
