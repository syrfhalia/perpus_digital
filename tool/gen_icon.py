"""Generate the Perpus Digital app launcher icon and web logos.

Draws a flat open-book mark on a teal rounded square. Outputs a 1024x1024
master icon used by flutter_launcher_icons, plus a maskable/adaptive
foreground and a transparent book mark for the web.

Run: python3 tool/gen_icon.py
"""
import os
from PIL import Image, ImageDraw

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
ICONS = os.path.join(ROOT, "assets", "icon")
os.makedirs(ICONS, exist_ok=True)

TEAL = (0x15, 0xA1, 0x96)
TEAL_DARK = (0x0F, 0x76, 0x6E)
WHITE = (0xFF, 0xFF, 0xFF)

S = 1024


def lerp(a, b, t):
    return tuple(int(a[i] + (b[i] - a[i]) * t) for i in range(3))


def gradient_bg(size, top, bottom):
    img = Image.new("RGB", (size, size), top)
    d = ImageDraw.Draw(img)
    for y in range(size):
        d.line([(0, y), (size, y)], fill=lerp(top, bottom, y / size))
    return img


def draw_book(draw, cx, cy, scale, page=WHITE, ink=None):
    """Draw a centered open book. Coordinates scaled around (cx, cy)."""
    ink = ink or TEAL

    def p(dx, dy):
        return (cx + dx * scale, cy + dy * scale)

    # Left and right pages (open-book: outer edges high, center fold low).
    left = [p(-340, -200), p(0, -150), p(0, 230), p(-340, 180)]
    right = [p(340, -200), p(0, -150), p(0, 230), p(340, 180)]
    draw.polygon(left, fill=page)
    draw.polygon(right, fill=page)

    # Spine.
    draw.line([p(0, -150), p(0, 230)], fill=ink, width=int(16 * scale))

    # Text lines on each page.
    for i, dy in enumerate((-70, 0, 70)):
        w = int((8 - i) * scale)
        draw.line([p(-300, dy - 40), p(-40, dy + 5)], fill=ink,
                  width=max(6, int(14 * scale)))
        draw.line([p(300, dy - 40), p(40, dy + 5)], fill=ink,
                  width=max(6, int(14 * scale)))
        _ = w


def rounded_mask(size, radius):
    mask = Image.new("L", (size, size), 0)
    ImageDraw.Draw(mask).rounded_rectangle(
        [0, 0, size, size], radius=radius, fill=255)
    return mask


def make_master():
    bg = gradient_bg(S, TEAL, TEAL_DARK).convert("RGBA")
    d = ImageDraw.Draw(bg)
    draw_book(d, S // 2, S // 2 - 10, 1.0)
    # Rounded corners for the master too (Android will re-mask anyway).
    out = Image.new("RGBA", (S, S), (0, 0, 0, 0))
    out.paste(bg, (0, 0), rounded_mask(S, 210))
    path = os.path.join(ICONS, "app_icon.png")
    out.save(path)
    print("wrote", path)


def make_foreground():
    """Adaptive-icon foreground: book on transparent, with safe padding."""
    img = Image.new("RGBA", (S, S), (0, 0, 0, 0))
    d = ImageDraw.Draw(img)
    draw_book(d, S // 2, S // 2 - 10, 0.62)
    path = os.path.join(ICONS, "app_icon_foreground.png")
    img.save(path)
    print("wrote", path)


def make_web_mark():
    """White book on teal circle for the web favicon / PWA icon."""
    for size in (192, 512):
        img = Image.new("RGBA", (size, size), (0, 0, 0, 0))
        d = ImageDraw.Draw(img)
        d.ellipse([0, 0, size, size], fill=TEAL)
        draw_book(d, size // 2, size // 2 - int(size * 0.01),
                  size / S * 1.05)
        path = os.path.join(ICONS, f"web_icon_{size}.png")
        img.save(path)
        print("wrote", path)


make_master()
make_foreground()
make_web_mark()
print("done")
