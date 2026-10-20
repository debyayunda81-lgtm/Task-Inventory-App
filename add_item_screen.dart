import 'package:flutter/material.dart';
import '../models/item_model.dart';

class AddDataPage extends StatefulWidget {
  final String username;

  const AddDataPage({
    super.key,
    required this.username,
  });

  @override
  State<AddDataPage> createState() => _AddDataPageState();
}

class _AddDataPageState extends State<AddDataPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _namaController =
      TextEditingController();

  final TextEditingController _deskripsiController =
      TextEditingController();

  String _kategori = 'Tugas';
  String _status = 'Berjalan';
  bool _loading = false;

  static const Color biru = Color(0xFF3155FF);

  static const LinearGradient gradient = LinearGradient(
    colors: [
      Color(0xFF1597E5),
      Color(0xFF4169E1),
      Color(0xFF9B59FF),
      Color(0xFFF06AA8),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  @override
  void dispose() {
    _namaController.dispose();
    _deskripsiController.dispose();
    super.dispose();
  }

  void _simpanData() {
    if (_loading) return;

    if (!_formKey.currentState!.validate()) {
      return;
    }

    final nama = _namaController.text.trim();
    final deskripsi = _deskripsiController.text.trim();

    // Pastikan model TaskItem memiliki semua field ini.
    final dataBaru = TaskItem(
      nama: nama,
      kategori: _kategori,
      status: _status,
      deskripsi: deskripsi,
      persetujuan: 'Menunggu',
      dibuatOleh: widget.username,
    );

    setState(() {
      _loading = true;
    });

    globalItemList.add(dataBaru);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Data berhasil dikirim untuk persetujuan Admin.',
        ),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.pop(context, true);
  }

  InputDecoration _dekorasi({
    required String label,
    required IconData ikon,
  }) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(ikon, color: biru),
      filled: true,
      fillColor: const Color(0xFFF5F6FC),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: Color(0xFFE4E7F0),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: biru,
          width: 1.5,
        ),
      ),
    );
  }

  Widget _judulBagian(String teks) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        teks,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Color(0xFF30344B),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5FB),
      appBar: AppBar(
        title: const Text(
          'Tambah Data',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        foregroundColor: Colors.white,
        flexibleSpace: const DecoratedBox(
          decoration: BoxDecoration(gradient: gradient),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: gradient,
                      borderRadius: BorderRadius.circular(22),
                      boxShadow: [
                        BoxShadow(
                          color: biru.withValues(alpha: 0.18),
                          blurRadius: 16,
                          offset: const Offset(0, 7),
                        ),
                      ],
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.inventory_2_rounded,
                          color: Colors.white,
                          size: 42,
                        ),
                        SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Tambah Task & Inventory',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Isi data dan kirim untuk persetujuan Admin.',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Card(
                    color: Colors.white,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.stretch,
                          children: [
                            const Text(
                              'Form Tambah Data',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Penginput: ${widget.username}',
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 22),

                            _judulBagian('Nama Data'),
                            TextFormField(
                              controller: _namaController,
                              textCapitalization:
                                  TextCapitalization.words,
                              decoration: _dekorasi(
                                label: 'Masukkan nama data',
                                ikon: Icons.inventory_2_outlined,
                              ),
                              validator: (value) {
                                if (value == null ||
                                    value.trim().isEmpty) {
                                  return 'Nama data wajib diisi.';
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 18),

                            _judulBagian('Kategori'),
                            DropdownButtonFormField<String>(
                              value: _kategori,
                              isExpanded: true,
                              decoration: _dekorasi(
                                label: 'Pilih kategori',
                                ikon: Icons.category_outlined,
                              ),
                              items: const [
                                DropdownMenuItem(
                                  value: 'Tugas',
                                  child: Text('Tugas'),
                                ),
                                DropdownMenuItem(
                                  value: 'Elektronik',
                                  child: Text('Elektronik'),
                                ),
                                DropdownMenuItem(
                                  value: 'Alat Tulis',
                                  child: Text('Alat Tulis'),
                                ),
                                DropdownMenuItem(
                                  value: 'Lainnya',
                                  child: Text('Lainnya'),
                                ),
                              ],
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() {
                                    _kategori = value;
                                  });
                                }
                              },
                            ),

                            const SizedBox(height: 18),

                            _judulBagian('Status'),
                            DropdownButtonFormField<String>(
                              value: _status,
                              isExpanded: true,
                              decoration: _dekorasi(
                                label: 'Pilih status',
                                ikon: Icons.flag_outlined,
                              ),
                              items: const [
                                DropdownMenuItem(
                                  value: 'Berjalan',
                                  child: Text('Berjalan'),
                                ),
                                DropdownMenuItem(
                                  value: 'Tersedia',
                                  child: Text('Tersedia'),
                                ),
                                DropdownMenuItem(
                                  value: 'Dipinjam',
                                  child: Text('Dipinjam'),
                                ),
                                DropdownMenuItem(
                                  value: 'Selesai',
                                  child: Text('Selesai'),
                                ),
                              ],
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() {
                                    _status = value;
                                  });
                                }
                              },
                            ),

                            const SizedBox(height: 18),

                            _judulBagian('Deskripsi'),
                            TextFormField(
                              controller: _deskripsiController,
                              minLines: 3,
                              maxLines: 5,
                              decoration: _dekorasi(
                                label: 'Masukkan deskripsi',
                                ikon: Icons.description_outlined,
                              ),
                            ),

                            const SizedBox(height: 22),

                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFF5E5),
                                borderRadius:
                                    BorderRadius.circular(12),
                              ),
                              child: const Row(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.info_outline,
                                    color: Colors.orange,
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      'Data baru berstatus Menunggu '
                                      'sampai Admin memberikan persetujuan.',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 22),

                            Container(
                              decoration: BoxDecoration(
                                gradient: gradient,
                                borderRadius:
                                    BorderRadius.circular(14),
                              ),
                              child: ElevatedButton.icon(
                                onPressed:
                                    _loading ? null : _simpanData,
                                icon: const Icon(Icons.send_rounded),
                                label: Text(
                                  _loading
                                      ? 'Menyimpan...'
                                      : 'Kirim untuk Persetujuan',
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  disabledBackgroundColor:
                                      Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}