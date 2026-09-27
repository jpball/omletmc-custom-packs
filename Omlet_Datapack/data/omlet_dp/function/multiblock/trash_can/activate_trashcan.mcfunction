# Run as and at an active trash can's glow item frame every tick
particle minecraft:flame ~ ~ ~ 0.2 0.2 0.3 0 1 normal

# Destroy everything in the chest below
data merge block ~ ~-1 ~ {Items:[]}
