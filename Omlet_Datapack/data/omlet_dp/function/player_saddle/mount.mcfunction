# The wearer can't ride their own saddle
execute if score @s omlet.id = #id omlet.id run return fail

# Already riding something
execute on vehicle run return fail

# Saddle already occupied
execute as @e[type=item_display,tag=omlet.saddle_seat] if score @s omlet.id = #id omlet.id run return fail

execute positioned ^ ^0.9 ^-0.4 summon item_display run function omlet_dp:player_saddle/init_seat
ride @s mount @n[type=item_display,tag=omlet.new_seat]

tag @e[type=item_display,tag=omlet.new_seat] remove omlet.new_seat