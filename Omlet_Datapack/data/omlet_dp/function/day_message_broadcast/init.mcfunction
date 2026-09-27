scoreboard objectives add omlet_dp.prev_day dummy
scoreboard objectives add omlet_dp.curr_day dummy
scoreboard objectives add omlet_dp.curr_day.mod_freq dummy
scoreboard objectives add omlet_dp.config.day_msg_frequency dummy
scoreboard players set #ticks_per_day omlet_dp.curr_day 24000

# Default to broadcasting every 5 days, without overwriting a frequency set via set_broadcast_frequency
execute unless score #omlet_dp omlet_dp.config.day_msg_frequency matches 1.. run scoreboard players set #omlet_dp omlet_dp.config.day_msg_frequency 5

# Start tracking from the current day so loading the pack doesn't trigger a broadcast
function omlet_dp:day_message_broadcast/query_day
scoreboard players operation #omlet_dp omlet_dp.prev_day = #omlet_dp omlet_dp.curr_day
