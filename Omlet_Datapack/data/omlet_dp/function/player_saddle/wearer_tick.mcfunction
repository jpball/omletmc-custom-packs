scoreboard players operation #id omlet.id = @s omlet.id
scoreboard players set #found omlet.id 0
execute as @e[type=interaction,tag=omlet.saddle_hitbox] if score @s omlet.id = #id omlet.id run function omlet_dp:player_saddle/hitbox_tick
execute if score #found omlet.id matches 0 positioned ^ ^0.3 ^-0.4 summon interaction run function omlet_dp:player_saddle/init_hitbox
execute as @e[type=item_display,tag=omlet.saddle_seat] if score @s omlet.id = #id omlet.id run function omlet_dp:player_saddle/seat_tick