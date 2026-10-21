import 'package:flutter/material.dart';
import '../models/item_model.dart';
import 'add_item_screen.dart';
import 'login_screen.dart';

class UserDashboardPage extends StatefulWidget {
  final String username;

  const UserDashboardPage({
    super.key,
    required this.username,
  });

  @override
  State<UserDashboardPage> createState() =>
      _UserDashboardPageState();
}

class _UserDashboardPageState extends State<UserDashboardPage> {
  static const Color biru = Color(0xFF4169E1);
  static const Color ungu = Color(0xFF805AD5);

  Future<void> tambahData() async {
    final hasil = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) => AddDataPage(
          username: widget.username,
        ),
      ),
    );

    if (!mounted) return;

    if (hasil == true) {
      setState(() {});
    }
  }

  void logout() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final dataSaya = globalItemList
        .where((item) => item.dibuatOleh == widget.username)
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FC),
      appBar: AppBar(
        title: const Text(
          'Dashboard User',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [biru, ungu],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: logout,
            tooltip: 'Keluar',
            icon: const Icon(Icons.logout),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: tambahData,
        backgroundColor: biru,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Tambah Data'),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [biru, ungu],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.account_circle,
                  color: Colors.white,
                  size: 55,
                ),
                const SizedBox(height: 12),
                Text(
                  'Halo, ${widget.username}!',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Selamat datang di dashboard kamu.',
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Statistik
          Card(
            elevation: 2,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 28,
                    backgroundColor: Color(0xFFE8EDFF),
                    child: Icon(
                      Icons.inventory_2,
                      color: biru,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Text(
                      'Total Data Saya',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Text(
                    '${dataSaya.length}',
                    style: const TextStyle(
                      color: biru,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          const Text(
            'Daftar Data Saya',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          // Data kosong
          if (dataSaya.isEmpty)
            Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const Icon(
                      Icons.folder_open,
                      size: 55,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Belum Ada Data',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Tekan tombol Tambah Data untuk menambahkan data baru.',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: tambahData,
                      icon: const Icon(Icons.add),
                      label: const Text('Tambah Sekarang'),
                    ),
                  ],
                ),
              ),
            ),

          // Daftar data yang sudah ditambahkan
          ...dataSaya.map(
            (item) => Card(
              color: Colors.white,
              elevation: 2,
              margin: const EdgeInsets.only(bottom: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          backgroundColor: Color(0xFFE8EDFF),
                          child: Icon(
                            Icons.assignment,
                            color: biru,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            item.nama,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 24),
                    _info('Kategori', item.kategori),
                    const SizedBox(height: 8),
                    _info('Status', item.status),
                    const SizedBox(height: 8),
                    _info(
                      'Persetujuan Admin',
                      item.persetujuan,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Deskripsi',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: biru,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(item.deskripsi),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _info(String judul, String isi) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 135,
          child: Text(
            judul,
            style: const TextStyle(color: Colors.black54),
          ),
        ),
        const Text(': '),
        Expanded(
          child: Text(
            isi,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
