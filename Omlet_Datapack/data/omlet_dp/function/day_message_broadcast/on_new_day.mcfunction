scoreboard players operation #previous omlet.day = #current omlet.day

# Broadcast when the current day is a multiple of the configured frequency
scoreboard players operation #mod omlet.day = #current omlet.day
scoreboard players operation #mod omlet.day %= #frequency omlet.day
execute if score #mod omlet.day matches 0 run function omlet_dp:day_message_broadcast/broadcast_day_count
