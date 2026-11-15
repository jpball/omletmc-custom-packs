# Give each player an ID
execute as @a unless score @s omlet.id matches 1.. store result score @s omlet.id run scoreboard players add #next omlet.id 1

# Mark every saddle hitbox as "stale" (assumed unused until proven otherwise this tick)
tag @e[type=interaction,tag=omlet.saddle_hitbox] add omlet.stale
# Mark every saddle seat as "stale" in the same way
tag @e[type=item_display,tag=omlet.saddle_seat] add omlet.stale

# For each non-spectator player wearing the Player Saddle in the chest slot:
# run wearer_tick as that player, at their position, facing their direction with pitch flattened to 0.
# wearer_tick removes the "stale" tag from that player's hitbox and from their seat if it has a rider.
execute as @a[gamemode=!spectator] if items entity @s armor.chest *[minecraft:custom_data~{player_saddle:true}] at @s rotated ~ 0 run function omlet_dp:player_saddle/wearer_tick

# Delete hitboxes still marked stale (their wearer took the saddle off or logged out)
kill @e[type=interaction,tag=omlet.stale]
# Delete seats still marked stale (wearer gone, or the rider dismounted)
kill @e[type=item_display,tag=omlet.stale]