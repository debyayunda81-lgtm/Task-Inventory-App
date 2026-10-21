// ===============================
// MODEL AKUN
// ===============================
class UserAccount {
  final String username;
  String password;
  final String role;
  String persetujuan;

  UserAccount({
    required this.username,
    required this.password,
    required this.role,
    this.persetujuan = 'Menunggu',
  });
}

// ===============================
// MODEL DATA BARANG / TUGAS
// ===============================
class TaskItem {
  final String nama;
  final String kategori;
  String status;
  final String deskripsi;
  String persetujuan;
  final String dibuatOleh;

  TaskItem({
    required this.nama,
    required this.kategori,
    required this.status,
    required this.deskripsi,
    this.persetujuan = 'Menunggu',
    required this.dibuatOleh,
  });
}

// ===============================
// DATA AKUN ADMIN DAN USER
// ===============================
final List<UserAccount> registeredUsers = [
  UserAccount(
    username: 'admin1',
    password: '123456',
    role: 'Admin',
    persetujuan: 'Disetujui',
  ),
  UserAccount(
    username: 'user1',
    password: '123456',
    role: 'User',
    persetujuan: 'Disetujui',
  ),
];

// ===============================
// DATA AWAL BARANG DAN TUGAS
// ===============================
final List<TaskItem> globalItemList = [
  TaskItem(
    nama: 'Laptop ASUS',
    kategori: 'Elektronik',
    status: 'Tersedia',
    deskripsi: 'Laptop untuk kebutuhan pembelajaran.',
    persetujuan: 'Disetujui',
    dibuatOleh: 'admin1',
  ),
  TaskItem(
    nama: 'Buku Pemrograman',
    kategori: 'Alat Tulis',
    status: 'Selesai',
    deskripsi: 'Buku materi pemrograman Flutter.',
    persetujuan: 'Disetujui',
    dibuatOleh: 'admin1',
  ),
  TaskItem(
    nama: 'Mouse Wireless',
    kategori: 'Elektronik',
    status: 'Dipinjam',
    deskripsi: 'Mouse wireless untuk komputer.',
    persetujuan: 'Disetujui',
    dibuatOleh: 'admin1',
  ),
  TaskItem(
    nama: 'Tugas Flutter',
    kategori: 'Tugas',
    status: 'Berjalan',
    deskripsi: 'Membuat aplikasi Task & Inventory Manager.',
    persetujuan: 'Disetujui',
    dibuatOleh: 'user1',
  ),
];