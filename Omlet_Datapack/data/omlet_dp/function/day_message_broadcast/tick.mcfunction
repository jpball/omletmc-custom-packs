function omlet_dp:day_message_broadcast/query_day

# A new day starts whenever the day count changes (including via /time set)
execute unless score #omlet_dp omlet_dp.curr_day = #omlet_dp omlet_dp.prev_day run function omlet_dp:day_message_broadcast/on_new_day
