# Run as and at an upward-facing glow item frame holding a diamond block.
# It must sit on the middle block of the bottom of an intact frame (frame_*) with an empty 3x3 interior (empty_*)
execute unless dimension minecraft:overworld unless dimension omlet_dp:flatworld run return 0
execute align xyz if predicate omlet_dp:flatworld_portal/frame_x if predicate omlet_dp:flatworld_portal/empty_x run return run function omlet_dp:multiblock/flatworld_portal/activate_x
execute align xyz if predicate omlet_dp:flatworld_portal/frame_z if predicate omlet_dp:flatworld_portal/empty_z run return run function omlet_dp:multiblock/flatworld_portal/activate_z
