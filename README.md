# 🍳 ResepKu - Aplikasi Resep Makanan (TheMealDB API)

Aplikasi mobile berbasis Flutter yang menyajikan daftar resep masakan berbasis kategori dinamis menggunakan data dari **TheMealDB API**. Aplikasi ini mengimplementasikan manajemen sesi pengguna (Register & Login), penyimpanan data lokal untuk fitur bookmark resep favorit dengan **Hive DB**, dan navigasi modern.

Projek ini dibuat untuk memenuhi tugas **Praktikum Teknologi Pemrograman Mobile (TPM)**.

---

## 👤 Identitas Mahasiswa

| Detail Mahasiswa | Informasi |
| --- | --- |
| **Nama** | Muhammad Syahrial Abidin |
| **NIM** | 123230027 |
| **Kelas** | Praktikum TPM IF-E |
| **Semester** | 6 (Enam) |
| **Tugas** | Tugas 2 (Daftar Resep & Kategori, Detail Resep, Bookmark/Favorit, Login/Register) |

---

## 🚀 Fitur Utama Aplikasi

1. **Authentication (Register, Login, & Session Management)**:
   - **Registrasi & Login**: Pengguna dapat mendaftarkan akun baru dan melakukan autentikasi masuk menggunakan data yang tersimpan secara lokal.
   - **Session Persistence**: Menggunakan `SharedPreferences` untuk mengingat sesi login pengguna sehingga pengguna tidak perlu login kembali saat membuka aplikasi, kecuali memilih opsi *Logout*.
   - **Validasi Input**: Validasi kecocokan password saat registrasi dan pengecekan form kosong.

2. **Dashboard / Daftar Resep Makanan (Home)**:
   - Menampilkan daftar resep makanan dalam kategori **Chicken** secara dinamis yang diambil secara *real-time* dari API **TheMealDB**.
   - Tata letak grid dua kolom yang responsif (`GridView.builder`) dengan tampilan kartu visual yang estetik.

3. **Detail Resep Makanan**:
   - Informasi lengkap masakan yang mencakup **Gambar Makanan**, **Nama Menu**, **Kategori Hidangan**, **Negara Asal**, **Daftar Bahan & Takaran**, serta **Langkah-langkah Memasak (Instructions)** yang lengkap.
   - Tombol interaktif untuk menambahkan atau menghapus resep tersebut dari daftar favorit secara instan.

4. **Bookmark & Favorit (Hive Local Database)**:
   - Menyimpan resep favorit pengguna ke dalam basis data lokal **Hive Box** agar dapat diakses kapan saja secara offline.
   - Menggunakan `ValueListenableBuilder` untuk mendengarkan perubahan data secara langsung (*reactive state*) di tab **Favorit**.
   - Menyediakan tombol hapus cepat (ikon silang `X`) langsung pada kartu resep di tab Favorit untuk mempermudah manajemen resep.

---

## 🛠️ Tech Stack & Dependensi

Projek ini didukung oleh paket-paket Flutter berikut:

- **[http](https://pub.dev/packages/http)**: Digunakan untuk melakukan *HTTP request* ke server API TheMealDB guna mengambil data kategori masakan serta detail menu.
- **[shared_preferences](https://pub.dev/packages/shared_preferences)**: Digunakan untuk menyimpan sesi login (`isLoggedIn`) dan kredensial dasar pengguna secara lokal.
- **[hive](https://pub.dev/packages/hive)** & **[hive_flutter](https://pub.dev/packages/hive_flutter)**: Database NoSQL lokal yang sangat cepat dan ringan untuk menyimpan koleksi resep favorit pengguna dalam bentuk objek data.
- **[hive_generator](https://pub.dev/packages/hive_generator)** & **[build_runner](https://pub.dev/packages/build_runner)**: Digunakan saat fase *development* untuk men-generate file adaptor data Hive (`favorite.g.dart`) secara otomatis.

---

## 📂 Struktur Folder Projek

Berikut adalah struktur folder kode utama di dalam direktori `lib/`:

```text
lib/
├── main.dart             # Titik masuk aplikasi, inisialisasi Hive, & pengecekan sesi login
├── models/
│   ├── favorite.dart     # Model data Hive untuk item resep favorit
│   └── favorite.g.dart   # File generator Hive TypeAdapter (auto-generated)
├── services/
│   └── mealdb_service.dart # Logika HTTP Client untuk integrasi API TheMealDB
└── view/
    ├── login_view.dart   # Halaman Login & Autentikasi sesi
    ├── register_view.dart # Halaman Registrasi Pengguna baru
    ├── home_view.dart    # Dashboard utama (Daftar Menu Kategori Chicken)
    ├── detail_view.dart  # Halaman detail resep lengkap (Bahan & Cara Memasak)
    └── favorite_view.dart # Tab resep favorit tersimpan (Reactive & Local Hive)
```

---

## 🏁 Cara Menjalankan Projek Secara Lokal

Ikuti langkah-langkah berikut untuk menjalankan aplikasi ini di perangkat emulator atau fisik Anda:

1. **Prasyarat**:
   Pastikan Anda sudah menginstal Flutter SDK di komputer Anda. Cek kesiapan dengan perintah:
   ```bash
   flutter doctor
   ```

2. **Dapatkan Dependensi**:
   Masuk ke folder direktori projek ini, lalu unduh semua paket pustaka yang dideklarasikan di `pubspec.yaml`:
   ```bash
   flutter pub get
   ```

3. **Generate Hive Adapter** *(Opsional, lakukan jika file `favorite.g.dart` belum ter-generate)*:
   Jalankan kode generator untuk membuat adaptor database Hive:
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

4. **Jalankan Aplikasi**:
   Hubungkan perangkat emulator Android/iOS Anda, lalu jalankan perintah:
   ```bash
   flutter run
   ```
