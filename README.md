# Kasir AI

Aplikasi Kasir Cerdas berbasis Flutter dengan fitur rekomendasi produk menggunakan AI sederhana.

## Cara Menjalankan Aplikasi

Pastikan Flutter SDK sudah terinstall.

1.  **Install Dependencies**:
    ```bash
    flutter pub get
    ```

2.  **Jalankan Aplikasi**:
    ```bash
    flutter run
    ```

## Fitur Frontend

### 1. Autentikasi
- Login Screen dengan validasi input.
- Indikator loading simulasi saat login.

### 2. Dashboard
- Navigasi utama ke fitur-fitur aplikasi: Transaksi Baru, Daftar Produk, dan Riwayat Transaksi.

### 3. Manajemen Produk
- **Daftar Produk**: Menampilkan list produk dengan harga dan stok.
- **Tambah Produk**: Form input dengan validasi untuk menambah produk baru.

### 4. Transaksi Kasir
- **Pencarian Produk**: Mencari produk berdasarkan nama.
- **Keranjang Belanja**: Menambah item, mengatur jumlah, dan menghapus item.
- **Rekomendasi AI**: Menampilkan rekomendasi produk pelengkap berdasarkan isi keranjang (misal: beli Makanan -> rekomendasi Minuman).
- **Kalkulasi Total**: Menghitung total belanja secara real-time.

### 5. Riwayat Transaksi
- Menampilkan daftar transaksi yang pernah dilakukan.
- Detail transaksi dapat dilihat dengan menekan item pada list.

## Struktur Project

- `lib/src/models`: Definisi model data (`Product`, `CartItem`).
- `lib/src/screens`: Halaman-halaman aplikasi (`Login`, `Dashboard`, `Transaction`, dll).
- `lib/src/widgets`: Komponen UI yang dapat digunakan kembali (`PrimaryButton`, `ProductItemTile`, `CartItemTile`).
- `lib/src/services`: Layer untuk akses data dan API (`ApiClient`, `ProductService`).
