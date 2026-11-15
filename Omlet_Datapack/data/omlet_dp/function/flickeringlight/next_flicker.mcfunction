# Run as a lamp display that is fully on: wait 2-20 seconds before the next flicker
scoreboard players set @s omlet.light_timer 0
execute store result score @s omlet.light_timer run random value 40..400
