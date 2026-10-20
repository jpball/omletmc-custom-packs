function omlet_dp:day_message_broadcast/query_day

# A new day starts whenever the day count changes (including via /time set)
execute unless score #current omlet.day = #previous omlet.day run function omlet_dp:day_message_broadcast/on_new_day
