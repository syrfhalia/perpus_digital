# 📚 Perpus Digital — Panduan Lengkap

## 📋 Isi Folder Ini
```
perpus_digital/
├── lib/          → Source code Flutter (Dart)
├── assets/       → Gambar cover buku & ikon
├── android/      → Konfigurasi Android
├── web/          → Konfigurasi Flutter Web
├── pubspec.yaml  → Dependensi app
└── README.md     → Panduan ini
```

---

## 🚀 LANGKAH 1 — Install Flutter (Sekali Saja)

Kalau belum punya Flutter, install dulu:
- Download: https://flutter.dev/get-started
- Pilih OS kamu (Windows / Mac / Linux)
- Ikuti petunjuk instalasinya

Cek instalasi berhasil:
```
flutter doctor
```

---

## 📱 BUILD FILE APK (Android)

Buka terminal di folder ini, lalu jalankan satu per satu:

```bash
# 1. Install dependensi
flutter pub get

# 2. Build APK release
flutter build apk --release
```

File APK siap diinstall ada di:
```
build/app/outputs/flutter-apk/app-release.apk
```

Install ke HP Android:
- Copy file APK ke HP
- Buka file APK di HP → Izinkan install dari sumber tidak dikenal → Install

---

## 🌐 JALANKAN DI WEB (VS Code / Browser)

```bash
# 1. Install dependensi
flutter pub get

# 2. Jalankan di browser
flutter run -d chrome
```

Atau build untuk hosting:
```bash
flutter build web
# Hasil ada di folder: build/web/
```

---

## 🎨 Fitur Tema Warna
Buka app → tab **Profil** → **Pengaturan** → pilih **Tema Warna**
Tersedia: Teal, Ungu, Biru, Oranye, Hijau, Merah, Indigo

## 📚 Koleksi Buku
Total 41 buku (16 asli + 25 baru) dari berbagai kategori:
Fiksi, Sains, Bisnis, Sejarah, Motivasi

---
Selamat mencoba! 🎉
