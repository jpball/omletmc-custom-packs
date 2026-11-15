# Fake players: #day (current day), #last_day (day seen last tick), #frequency (days between broadcasts), #mod (temporary)
scoreboard objectives add omlet.day dummy
scoreboard players set #ticks_per_day omlet.day 24000

# Default to every 5 days, without overwriting a frequency set with set_broadcast_frequency
execute unless score #frequency omlet.day matches 1.. run scoreboard players set #frequency omlet.day 5

# Forget the last day seen, so the first tick after loading only records the day instead of broadcasting
scoreboard players reset #last_day omlet.day
