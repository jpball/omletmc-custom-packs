# Fake players: #current and #previous day, #frequency (days between broadcasts), and constants/temporary values
scoreboard objectives add omlet.day dummy
scoreboard players set #ticks_per_day omlet.day 24000

# Carry over a frequency set in older versions, then remove their objectives
execute if score #omlet_dp omlet_dp.config.day_msg_frequency matches 1.. run scoreboard players operation #frequency omlet.day = #omlet_dp omlet_dp.config.day_msg_frequency
scoreboard objectives remove omlet_dp.prev_day
scoreboard objectives remove omlet_dp.curr_day
scoreboard objectives remove omlet_dp.curr_day.mod_freq
scoreboard objectives remove omlet_dp.config.day_msg_frequency

# Default to broadcasting every 5 days, without overwriting a frequency set via set_broadcast_frequency
execute unless score #frequency omlet.day matches 1.. run scoreboard players set #frequency omlet.day 5

# Start tracking from the current day so loading the pack doesn't trigger a broadcast
function omlet_dp:day_message_broadcast/query_day
scoreboard players operation #previous omlet.day = #current omlet.day
