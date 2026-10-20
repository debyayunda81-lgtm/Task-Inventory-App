
import 'package:flutter/material.dart';
import 'login_screen.dart';
import '../models/item_model.dart';

class AdminDashboardScreen extends StatefulWidget {
  final dynamic user;

  const AdminDashboardScreen({
    super.key,
    required this.user,
  });

  @override
  State<AdminDashboardScreen> createState() =>
      _AdminDashboardScreenState();
}

class _AdminDashboardScreenState
    extends State<AdminDashboardScreen> {
  String filter = 'Semua';

  final List<Map<String, String>> data = [
    {
      'nama': 'Laptop ASUS',
      'kategori': 'Elektronik',
      'status': 'Tersedia',
    },
    {
      'nama': 'Buku Pemrograman',
      'kategori': 'Alat Tulis',
      'status': 'Selesai',
    },
    {
      'nama': 'Mouse Wireless',
      'kategori': 'Elektronik',
      'status': 'Dipinjam',
    },
    {
      'nama': 'Tugas Flutter',
      'kategori': 'Tugas',
      'status': 'Berjalan',
    },
  ];

  static const Color biru = Color(0xFF3155FF);
  static const Color ungu = Color(0xFF9857FF);
  static const Color latar = Color(0xFFF4F5FB);

  final LinearGradient gradien = const LinearGradient(
    colors: [
      Color(0xFF1597E5),
      Color(0xFF4169E1),
      Color(0xFF9B59FF),
      Color(0xFFF06AA8),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  String get username {
    try {
      return widget.user.username.toString();
    } catch (_) {
      return 'ADMIN';
    }
  }

  Color warnaStatus(String status) {
    switch (status) {
      case 'Tersedia':
        return Colors.green;
      case 'Selesai':
        return Colors.blue;
      case 'Dipinjam':
        return Colors.orange;
      case 'Berjalan':
        return ungu;
      default:
        return Colors.grey;
    }
  }

  void keluar() {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Keluar'),
        content: const Text('Yakin ingin keluar dari akun?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => LoginPage(),
                ),
                (route) => false,
              );
            },
            child: const Text('Keluar'),
          ),
        ],
      ),
    );
  }

  void lihatDetail(Map<String, String> item) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(item['nama']!),
        content: Text(
          'Kategori: ${item['kategori']}\n'
          'Status: ${item['status']}',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  void ubahStatus(Map<String, String> item) {
    const statusList = [
      'Tersedia',
      'Berjalan',
      'Dipinjam',
      'Selesai',
    ];

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Ubah Status'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: statusList.map((status) {
            return ListTile(
              title: Text(status),
              leading: Icon(
                Icons.circle,
                color: warnaStatus(status),
                size: 14,
              ),
              onTap: () {
                setState(() {
                  item['status'] = status;
                });
                Navigator.pop(dialogContext);
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  // MENYETUJUI DATA TASK ATAU INVENTORY
  void setujuiData(TaskItem item) {
    setState(() {
      item.persetujuan = 'Disetujui';

      final sudahAda = data.any(
        (row) =>
            row['nama'] == item.nama &&
            row['kategori'] == item.kategori,
      );

      if (!sudahAda) {
        data.add({
          'nama': item.nama,
          'kategori': item.kategori,
          'status': item.status,
        });
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${item.nama} berhasil disetujui.'),
      ),
    );
  }

  void tolakData(TaskItem item) {
    setState(() {
      item.persetujuan = 'Ditolak';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${item.nama} ditolak.'),
      ),
    );
  }

  // MENYETUJUI AKUN USER BARU
  void setujuiAkun(UserAccount akun) {
    setState(() {
      akun.persetujuan = 'Disetujui';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Akun ${akun.username} berhasil disetujui.',
        ),
      ),
    );
  }

  void tolakAkun(UserAccount akun) {
    setState(() {
      akun.persetujuan = 'Ditolak';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Pendaftaran ${akun.username} ditolak.',
        ),
      ),
    );
  }

  // KARTU AKUN YANG MENUNGGU PERSETUJUAN
  Widget kartuAkun(UserAccount akun) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(8),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.account_circle_rounded,
                color: biru,
                size: 38,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      akun.username,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Role: ${akun.role}',
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Status: ${akun.persetujuan}',
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => setujuiAkun(akun),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Setujui'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton(
                  onPressed: () => tolakAkun(akun),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                  ),
                  child: const Text('Tolak'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // KARTU DATA TASK DAN INVENTORY
  Widget kartuPersetujuan(TaskItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(8),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.nama,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text('Kategori: ${item.kategori}'),
          const SizedBox(height: 4),
          Text('Status: ${item.status}'),
          const SizedBox(height: 4),
          Text('Dikirim oleh: ${item.dibuatOleh}'),
          const SizedBox(height: 4),
          Text('Deskripsi: ${item.deskripsi}'),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => setujuiData(item),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Setujui'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton(
                  onPressed: () => tolakData(item),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                  ),
                  child: const Text('Tolak'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget kartuStat(
    IconData ikon,
    int jumlah,
    String label,
  ) {
    return Expanded(
      child: Container(
        height: 100,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(8),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                gradient: gradien,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                ikon,
                color: Colors.white,
                size: 20,
              ),
            ),
            const Spacer(),
            Text(
              '$jumlah',
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              label,
              style: const TextStyle(
                fontSize: 10,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget kartuData(Map<String, String> item) {
    final nama = item['nama']!;
    final kategori = item['kategori']!;
    final status = item['status']!;
    final warna = warnaStatus(status);

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(21),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(8),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: gradien,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.inventory_2_rounded,
              color: Colors.white,
              size: 25,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nama,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  kategori,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 7),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: warna.withAlpha(25),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: warna,
                      fontSize: 9,
                    ),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => lihatDetail(item),
            icon: const Icon(
              Icons.visibility_outlined,
              color: biru,
            ),
          ),
          IconButton(
            onPressed: () => ubahStatus(item),
            icon: const Icon(
              Icons.edit,
              color: ungu,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final daftar = data.where((item) {
      return filter == 'Semua' || item['status'] == filter;
    }).toList();

    final tugas = data
        .where((item) => item['kategori'] == 'Tugas')
        .length;

    final akunMenunggu = registeredUsers
        .where(
          (akun) =>
              akun.role == 'User' &&
              akun.persetujuan == 'Menunggu',
        )
        .toList();

    final dataMenunggu = globalItemList
        .where((item) => item.persetujuan == 'Menunggu')
        .toList();

    return Scaffold(
      backgroundColor: latar,
      body: SafeArea(
        child: Column(
          children: [
            // HEADER SEKOLAH
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 10,
              ),
              child: Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: Image.asset(
                      'assets/logosmk.png',
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) =>
                          const Icon(Icons.school, color: biru),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text(
                      'SMK NEGERI 1 BERINGIN',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  IconButton(
                    onPressed: keluar,
                    icon: const Icon(Icons.logout_rounded),
                  ),
                ],
              ),
            ),

            const Divider(height: 1),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(
                  22, 15, 22, 20,
                ),
                children: [
                  // SAMBUTAN ADMIN
                  Container(
                    padding: const EdgeInsets.all(17),
                    decoration: BoxDecoration(
                      gradient: gradien,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: biru.withAlpha(30),
                          blurRadius: 15,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 65,
                          height: 65,
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(17),
                          ),
                          child: Image.asset(
                            'assets/logosmk.png',
                            fit: BoxFit.contain,
                            errorBuilder: (_, __, ___) =>
                                const Icon(
                              Icons.school,
                              color: biru,
                              size: 40,
                            ),
                          ),
                        ),
                        const SizedBox(width: 13),
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Selamat Datang 👋',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 11,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                username.toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              const Text(
                                'Manajemen Task & Inventory',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 26),

                  const Text(
                    'Data Task & Inventory',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 7),

                  const Text(
                    'Admin dapat melihat dan mengubah status data.',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 18),

                  Row(
                    children: [
                      kartuStat(
                        Icons.inventory_2_rounded,
                        data.length,
                        'Total',
                      ),
                      const SizedBox(width: 10),
                      kartuStat(
                        Icons.task_alt_rounded,
                        tugas,
                        'Tugas',
                      ),
                      const SizedBox(width: 10),
                      kartuStat(
                        Icons.category_rounded,
                        data.length - tugas,
                        'Barang',
                      ),
                    ],
                  ),

                  const SizedBox(height: 27),

                  // PERSETUJUAN AKUN USER
                  const Text(
                    'Persetujuan Akun User',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 7),

                  const Text(
                    'Akun baru harus disetujui Admin sebelum login.',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 14),

                  if (akunMenunggu.isEmpty)
                    const Padding(
                      padding: EdgeInsets.only(bottom: 12),
                      child: Text(
                        'Tidak ada akun yang menunggu persetujuan.',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  else
                    ...akunMenunggu.map(kartuAkun),

                  const SizedBox(height: 20),

                  // PERSETUJUAN DATA TASK/INVENTORY
                  const Text(
                    'Persetujuan Data User',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 7),

                  const Text(
                    'Periksa data yang dikirim User.',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 14),

                  if (dataMenunggu.isEmpty)
                    const Padding(
                      padding: EdgeInsets.only(bottom: 12),
                      child: Text(
                        'Tidak ada data yang menunggu persetujuan.',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  else
                    ...dataMenunggu.map(kartuPersetujuan),

                  const SizedBox(height: 20),

                  // FILTER STATUS
                  const Text(
                    'Filter Status',
                    style: TextStyle(fontSize: 11),
                  ),

                  const SizedBox(height: 12),

                  SizedBox(
                    height: 43,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        'Semua',
                        'Tersedia',
                        'Berjalan',
                        'Dipinjam',
                        'Selesai',
                      ].map((status) {
                        final aktif = filter == status;

                        return Padding(
                          padding: const EdgeInsets.only(right: 7),
                          child: OutlinedButton(
                            onPressed: () {
                              setState(() => filter = status);
                            },
                            style: OutlinedButton.styleFrom(
                              backgroundColor:
                                  aktif ? biru : Colors.white,
                              foregroundColor:
                                  aktif ? Colors.white : Colors.black54,
                              side: BorderSide(
                                color: aktif
                                    ? biru
                                    : const Color(0xFFD6D6E0),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(11),
                              ),
                            ),
                            child: Text(
                              status,
                              style: const TextStyle(fontSize: 10),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  const SizedBox(height: 22),

                  if (daftar.isEmpty)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(25),
                        child: Text(
                          'Belum ada data untuk status ini.',
                        ),
                      ),
                    )
                  else
                    ...daftar.map(kartuData),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}