# Stores the current in-game day in #current omlet.day.
# Since 26.1, /time no longer has a "query day" form, so derive it from the default clock's elapsed ticks.
execute store result score #current omlet.day run time query time
scoreboard players operation #current omlet.day /= #ticks_per_day omlet.day
