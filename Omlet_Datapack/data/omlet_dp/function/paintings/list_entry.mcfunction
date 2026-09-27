# Prints one clickable painting entry. Hovering shows the painting's tooltip; clicking gives it.
# Macro arguments: id (painting variant ID), title, size (e.g. "5x3")
$tellraw @s {"text":" • $(title) ","color":"aqua","click_event":{"action":"run_command","command":"give @s minecraft:painting[minecraft:painting/variant='$(id)']"},"hover_event":{"action":"show_item","id":"minecraft:painting","components":{"minecraft:painting/variant":"$(id)"}},"extra":[{"text":"[$(size)]","color":"gray"}]}
