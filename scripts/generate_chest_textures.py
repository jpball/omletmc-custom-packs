#!/usr/bin/env python3
"""Generates the tiered chest textures, models and item definitions for the resource pack.

Tweak a tier's palette in TIERS and re-run:
    python3 scripts/generate_chest_textures.py
"""
import json
import random
from pathlib import Path

from PIL import Image

ASSETS = Path(__file__).resolve().parent.parent / "Omlet_ResourcePack" / "assets" / "omlet_rp"

# id: (highlight, base, shade, dark outline)
TIERS = {
    "iron":      ("#FFFFFF", "#D8D8D8", "#A0A0A0", "#4A4A4A"),
    "gold":      ("#FFF6A8", "#FAD64A", "#DBA213", "#7A5208"),
    "diamond":   ("#D1FFF8", "#4AEDD9", "#2BC7AC", "#0F5C55"),
    "netherite": ("#7A717A", "#4D494D", "#3A353A", "#161316"),
}


def rgb(hex_color):
    return tuple(int(hex_color[i:i + 2], 16) for i in (1, 3, 5)) + (255,)


def blank():
    return Image.new("RGBA", (16, 16), (0, 0, 0, 0))


def panel(palette, seed, top, seam=None):
    """A 14x14 metal panel at x 1..14, y top..top+13 (the region the model's UVs sample),
    with plank-like stripes, a rim, and an optional dark lid seam `seam` rows down."""
    hi, base, shade, dark = map(rgb, palette)
    rnd = random.Random(seed)
    img = blank()
    for dy in range(14):
        for dx in range(14):
            x, y = 1 + dx, top + dy
            if dx in (0, 13) or dy in (0, 13) or dy == seam:
                color = dark
            elif dx == 1 or dy == 1:
                color = hi
            elif rnd.random() < 0.06:
                color = hi
            else:
                color = shade if (dy // 3) % 2 else base
            img.putpixel((x, y), color)
    return img


def side_texture(palette, seed):
    # Side faces use UV [1,2,15,16]; the lid (5 px) sits above the seam
    return panel(palette, seed, top=2, seam=5)


def top_texture(palette, seed):
    hi, base, shade, dark = map(rgb, palette)
    img = panel(palette, seed, top=1)
    for x, y in ((3, 3), (11, 3), (3, 11), (11, 11)):
        img.putpixel((x, y), hi)
        img.putpixel((x + 1, y + 1), dark)
    return img


def latch_texture(palette):
    hi, base, shade, dark = map(rgb, palette)
    img = Image.new("RGBA", (16, 16), dark)
    for y in range(4, 12):
        for x in range(4, 12):
            img.putpixel((x, y), hi if (x + y) % 5 == 0 else shade)
    return img


def write_json(path, data):
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(data, indent=2) + "\n")


def main():
    tex_block = ASSETS / "textures" / "block" / "chest"
    tex_block.mkdir(parents=True, exist_ok=True)

    for seed, (tier, palette) in enumerate(TIERS.items()):
        side_texture(palette, seed * 10 + 1).save(tex_block / f"{tier}_front.png")
        side_texture(palette, seed * 10 + 2).save(tex_block / f"{tier}_side.png")
        top_texture(palette, seed * 10 + 3).save(tex_block / f"{tier}_top.png")
        panel(palette, seed * 10 + 4, top=1).save(tex_block / f"{tier}_bottom.png")
        latch_texture(palette).save(tex_block / f"{tier}_latch.png")

        write_json(ASSETS / "models" / "block" / "chest" / f"{tier}.json", {
            "parent": "omlet_rp:block/chest/template",
            "textures": {name: f"omlet_rp:block/chest/{tier}_{name}"
                         for name in ("front", "side", "top", "bottom", "latch")},
        })
        # Used by both the placed chest's overlay and the tier chest item
        write_json(ASSETS / "items" / "chest" / f"{tier}.json",
                   {"model": {"type": "minecraft:model", "model": f"omlet_rp:block/chest/{tier}"}})

    print(f"Generated {len(TIERS)} chest tiers in {ASSETS}")


if __name__ == "__main__":
    main()
