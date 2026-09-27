# Sets how many in-game days pass between day count broadcasts.
# Usage: /function omlet_dp:day_message_broadcast/set_broadcast_frequency {new_freq:3}
$scoreboard players set #omlet_dp omlet_dp.config.day_msg_frequency $(new_freq)
