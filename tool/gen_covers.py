"""Generate stylized book cover PNG assets for the Perpus Digital app.

Run: python3 tool/gen_covers.py
Outputs to assets/covers/ and assets/images/.
"""
import os
from PIL import Image, ImageDraw, ImageFont

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
COVERS = os.path.join(ROOT, "assets", "covers")
IMAGES = os.path.join(ROOT, "assets", "images")
os.makedirs(COVERS, exist_ok=True)
os.makedirs(IMAGES, exist_ok=True)

FONT_BOLD = "/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf"
FONT_REG = "/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf"
FONT_SERIF = "/usr/share/fonts/truetype/dejavu/DejaVuSerif-Bold.ttf"

W, H = 600, 900  # 2:3 cover ratio


def lerp(a, b, t):
    return tuple(int(a[i] + (b[i] - a[i]) * t) for i in range(3))


def gradient(top, bottom):
    img = Image.new("RGB", (W, H), top)
    draw = ImageDraw.Draw(img)
    for y in range(H):
        draw.line([(0, y), (W, y)], fill=lerp(top, bottom, y / H))
    return img


def wrap(draw, text, font, max_w):
    words = text.split()
    lines, cur = [], ""
    for w in words:
        trial = (cur + " " + w).strip()
        if draw.textlength(trial, font=font) <= max_w:
            cur = trial
        else:
            if cur:
                lines.append(cur)
            cur = w
    if cur:
        lines.append(cur)
    return lines


def make_cover(filename, title, author, top, bottom, accent):
    img = gradient(top, bottom)
    draw = ImageDraw.Draw(img)

    # subtle top accent bar
    draw.rectangle([0, 0, W, 14], fill=accent)
    # decorative circle
    draw.ellipse([W - 220, -120, W + 120, 220], fill=accent + (60,) if False else lerp(top, accent, 0.35))

    # inner border frame
    margin = 40
    draw.rectangle([margin, margin, W - margin, H - margin], outline=(255, 255, 255), width=3)

    title_font = ImageFont.truetype(FONT_SERIF, 64)
    author_font = ImageFont.truetype(FONT_REG, 34)
    brand_font = ImageFont.truetype(FONT_BOLD, 26)

    # title (wrapped, centered vertically-ish)
    lines = wrap(draw, title.upper(), title_font, W - 2 * margin - 40)
    line_h = 76
    total_h = line_h * len(lines)
    y = (H - total_h) // 2 - 40
    for ln in lines:
        tw = draw.textlength(ln, font=title_font)
        draw.text(((W - tw) / 2, y), ln, font=title_font, fill=(255, 255, 255))
        y += line_h

    # divider
    dy = y + 20
    draw.line([(W / 2 - 70, dy), (W / 2 + 70, dy)], fill=accent, width=4)

    # author
    aw = draw.textlength(author, font=author_font)
    draw.text(((W - aw) / 2, dy + 26), author, font=author_font, fill=(240, 240, 240))

    # brand at bottom
    brand = "PERPUS DIGITAL"
    bw = draw.textlength(brand, font=brand_font)
    draw.text(((W - bw) / 2, H - margin - 44), brand, font=brand_font, fill=(255, 255, 255))

    img.save(os.path.join(COVERS, filename), "PNG")
    print("wrote", filename)


BOOKS = [
    ("laskar_pelangi.png", "Laskar Pelangi", "Andrea Hirata", (0x1E, 0x40, 0xAF), (0x0F, 0x76, 0x6E), (0xF5, 0xC5, 0x18)),
    ("filosofi_teras.png", "Filosofi Teras", "Henry Manampiring", (0x11, 0x82, 0x7A), (0x0B, 0x4A, 0x45), (0xE5, 0xB5, 0x0A)),
    ("bumi_manusia.png", "Bumi Manusia", "Pramoedya A. Toer", (0x7C, 0x2D, 0x12), (0x45, 0x1A, 0x03), (0xF5, 0x9E, 0x0B)),
    ("dilan_1990.png", "Dilan 1990", "Pidi Baiq", (0x3B, 0x0A, 0x45), (0x86, 0x19, 0x8A), (0xF9, 0xA8, 0xD4)),
    ("hujan.png", "Hujan", "Tere Liye", (0x0C, 0x4A, 0x6E), (0x1E, 0x88, 0xC5), (0xBA, 0xE6, 0xFD)),
    ("pulang.png", "Pulang", "Tere Liye", (0x14, 0x53, 0x2D), (0x16, 0xA3, 0x4A), (0xD9, 0xF9, 0x9D)),
    ("negeri_5_menara.png", "Negeri 5 Menara", "Ahmad Fuadi", (0x78, 0x35, 0x0F), (0xB4, 0x53, 0x09), (0xFE, 0xF0, 0x8A)),
    ("sapiens.png", "Sapiens", "Yuval N. Harari", (0x1F, 0x29, 0x37), (0x37, 0x41, 0x51), (0xEF, 0x44, 0x44)),
    ("atomic_habits.png", "Atomic Habits", "James Clear", (0x0B, 0x3D, 0x5C), (0x11, 0x6A, 0x8A), (0xFB, 0xBF, 0x24)),
    ("perahu_kertas.png", "Perahu Kertas", "Dee Lestari", (0x4C, 0x1D, 0x95), (0x7C, 0x3A, 0xED), (0xFD, 0xE0, 0x47)),
    ("cosmos.png", "Cosmos", "Carl Sagan", (0x0B, 0x10, 0x2A), (0x1E, 0x3A, 0x8A), (0x93, 0xC5, 0xFD)),
    ("brief_history_time.png", "Sejarah Singkat Waktu", "Stephen Hawking", (0x0A, 0x0A, 0x0A), (0x1F, 0x29, 0x37), (0x60, 0xA5, 0xFA)),
    ("homo_deus.png", "Homo Deus", "Yuval N. Harari", (0x44, 0x1A, 0x03), (0x92, 0x40, 0x0E), (0xFD, 0xBA, 0x74)),
    ("rich_dad.png", "Rich Dad Poor Dad", "Robert Kiyosaki", (0x14, 0x53, 0x2D), (0x05, 0x96, 0x69), (0xFD, 0xE0, 0x47)),
    ("mariposa.png", "Mariposa", "Luluk HF", (0x83, 0x18, 0x43), (0xDB, 0x27, 0x77), (0xFB, 0xCF, 0xE8)),
    ("garis_waktu.png", "Garis Waktu", "Fiersa Besari", (0x1E, 0x3A, 0x34), (0x0F, 0x76, 0x6E), (0x99, 0xF6, 0xE4)),
]

for args in BOOKS:
    make_cover(*args)


def make_avatar():
    size = 400
    img = gradient((0x0F, 0x76, 0x6E), (0x11, 0x82, 0x7A))
    img = img.resize((size, size))
    draw = ImageDraw.Draw(img)
    font = ImageFont.truetype(FONT_BOLD, 170)
    text = "BS"
    tw = draw.textlength(text, font=font)
    bbox = draw.textbbox((0, 0), text, font=font)
    th = bbox[3] - bbox[1]
    draw.text(((size - tw) / 2, (size - th) / 2 - bbox[1]), text, font=font, fill=(255, 255, 255))
    img.save(os.path.join(IMAGES, "avatar.png"), "PNG")
    print("wrote avatar.png")


make_avatar()
print("all done")
