# The current day. Since 26.1 /time has no "query day", so divide the elapsed ticks
execute store result score #day omlet.day run time query time
scoreboard players operation #day omlet.day /= #ticks_per_day omlet.day

# Nothing to do until the day changes (including via /time set)
execute unless score #last_day omlet.day matches -2147483648.. run scoreboard players operation #last_day omlet.day = #day omlet.day
execute if score #day omlet.day = #last_day omlet.day run return 0
scoreboard players operation #last_day omlet.day = #day omlet.day

# Broadcast on every day that's a multiple of the frequency
scoreboard players operation #mod omlet.day = #day omlet.day
scoreboard players operation #mod omlet.day %= #frequency omlet.day
execute if score #mod omlet.day matches 0 run tellraw @a {"text":"In-game days passed: ","color":"yellow","bold":true,"extra":[{"score":{"name":"#day","objective":"omlet.day"},"color":"gold"}]}
