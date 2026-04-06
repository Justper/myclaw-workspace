---
name: image-cog
description: "Generate and edit images. Text-to-image, image-to-image, consistent characters, product photography, style transfer, batch generation, vector illustrations, SVG icons, transparent backgrounds, photo editing. Multiple AI models for raster, vector, and icon generation. Use for any image creation or editing task. Outputs: PNG, JPG, WebP, SVG. Powered by CellCog."
metadata:
  openclaw:
    emoji: "🎨"
    os: [darwin, linux, windows]
author: CellCog
homepage: https://cellcog.ai
dependencies: [cellcog]
---

# Image Cog - AI Image Generation & Editing

Generate and edit images across every style and format — raster, vector, SVG, icons, transparent backgrounds.

---

## Prerequisites

This skill requires the `cellcog` skill for SDK setup and API calls.

```bash
clawhub install cellcog
```

**Read the cellcog skill first** for SDK setup. This skill shows you what's possible.

**OpenClaw agents (fire-and-forget — recommended for long tasks):**
```python
result = client.create_chat(
    prompt="[your task prompt]",
    notify_session_key="agent:main:main",  # OpenClaw only
    task_label="my-task",
    chat_mode="agent",  # See cellcog skill for all modes
)
```

**All other agents (blocks until done):**
```python
result = client.create_chat(
    prompt="[your task prompt]",
    task_label="my-task",
    chat_mode="agent",
)
```

See the **cellcog** mothership skill for complete SDK API reference — delivery modes, timeouts, file handling, and more.

---

## What CellCog Has Internally

1. **Raster Image Generation (Gemini 3.1 Flash)** — Text-to-image with Google Search Grounding, native world knowledge, advanced text rendering. 12+ aspect ratios, 4 sizes (512/1K/2K/4K). Thread memory for character consistency across multiple images.
2. **Transparent Image Generation (gpt-image-1.5)** — PNG output with transparent backgrounds for logos, stickers, overlays. 3 aspect ratios (3:2, 1:1, 2:3).
3. **Vector Illustration Generation** — Text-to-SVG with 23 styles (bold_stroke, line_art, editorial, seamless, vivid_shapes, etc.). Custom color palettes. Infinitely scalable.
4. **Icon Generation** — Text-to-SVG icons optimized for small sizes. 11 styles (outline, colored_outline, pictogram, doodle_fill, etc.).
5. **Reference Image Support** — Pass existing images to guide generation. Face-critical protocol re-passes references for face fidelity.

---

## What Images You Can Create

- Illustrations, concept art, product photography, social media visuals
- Character-consistent image sets (same character across multiple scenes)
- Vector illustrations and SVG graphics (infinitely scalable)
- Icons and UI elements (SVG, optimized for small sizes)
- Transparent background images (logos, stickers, overlays)
- Photo editing: style transfer, enhancement, background changes
- Batch generation of themed image sets

---

## Output Specifications

| Format | Model | Best For |
|--------|-------|----------|
| PNG/JPG/WebP | Gemini 3.1 Flash | Raster images, photos, illustrations |
| PNG (transparent) | gpt-image-1.5 | Logos, stickers, overlays |
| SVG (illustrations) | Vector model | Scalable graphics, print |
| SVG (icons) | Icon model | UI elements, app icons |

---

## Chat Mode

| Scenario | Recommended Mode |
|----------|------------------|
| Single images, icons, quick edits | `"agent"` |
| Multi-image projects, brand visual systems | `"agent team"` |

---

## Related Skills

- **brand-cog** — Complete brand identities (logos, palettes, guidelines)
- **meme-cog** — Meme generation with humor curation
- **banana-cog** — 10-20 coherent images with Nano Banana model
- **3d-cog** — 3D models from images or text
- **gif-cog** — Animated GIFs from images
- **sticker-cog** — Sticker packs with transparent backgrounds
