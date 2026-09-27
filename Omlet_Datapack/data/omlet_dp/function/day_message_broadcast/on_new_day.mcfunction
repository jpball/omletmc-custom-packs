scoreboard players operation #omlet_dp omlet_dp.prev_day = #omlet_dp omlet_dp.curr_day

# Broadcast when the current day is a multiple of the configured frequency
scoreboard players operation #omlet_dp omlet_dp.curr_day.mod_freq = #omlet_dp omlet_dp.curr_day
scoreboard players operation #omlet_dp omlet_dp.curr_day.mod_freq %= #omlet_dp omlet_dp.config.day_msg_frequency
execute if score #omlet_dp omlet_dp.curr_day.mod_freq matches 0 run function omlet_dp:day_message_broadcast/broadcast_day_count
