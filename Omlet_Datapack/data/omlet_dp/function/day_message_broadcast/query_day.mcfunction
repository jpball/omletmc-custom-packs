# Stores the current in-game day in omlet_dp.curr_day.
# Since 26.1, /time no longer has a "query day" form, so derive it from the default clock's elapsed ticks.
execute store result score #omlet_dp omlet_dp.curr_day run time query time
scoreboard players operation #omlet_dp omlet_dp.curr_day /= #ticks_per_day omlet_dp.curr_day
