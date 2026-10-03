# Macro: keep the chunks around the destination column loaded until the player arrives
$execute in $(dim) positioned $(x) 0 $(z) run forceload add ~-2 ~-2 ~2 ~2
