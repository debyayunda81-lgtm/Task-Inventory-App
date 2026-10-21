import 'package:flutter/material.dart';

import '../models/item_model.dart';
import 'register_screen.dart';
import 'admin_dashboard.dart';
import 'user_dashboard.dart';

const LinearGradient bluePinkGradient = LinearGradient(
  colors: [
    Color(0xFF1597E5),
    Color(0xFF4169E1),
    Color(0xFF9B59FF),
    Color(0xFFF06AA8),
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController =
      TextEditingController();

  final TextEditingController passwordController =
      TextEditingController();

  bool obscurePassword = true;
  bool isLoading = false;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<void> login() async {
    final username = usernameController.text.trim();
    final password = passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      showMessage('Username dan password wajib diisi!');
      return;
    }

    final index = registeredUsers.indexWhere(
      (user) =>
          user.username.toLowerCase() ==
              username.toLowerCase() &&
          user.password == password,
    );

    if (index == -1) {
      showMessage('Username atau password salah!');
      return;
    }

    final akun = registeredUsers[index];

    if (akun.persetujuan == 'Ditolak') {
      showMessage('Pendaftaran akun kamu ditolak Admin.');
      return;
    }

    if (akun.persetujuan != 'Disetujui') {
      showMessage('Akun menunggu persetujuan Admin.');
      return;
    }

    setState(() {
      isLoading = true;
    });

    await Future.delayed(
      const Duration(milliseconds: 300),
    );

    if (!mounted) return;

    setState(() {
      isLoading = false;
    });

    if (akun.role.toLowerCase() == 'admin') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => AdminDashboardScreen(
            user: akun,
          ),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => UserDashboardPage(
            username: akun.username,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: bluePinkGradient,
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 380,
                ),
                child: Card(
                  elevation: 10,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 28,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // LOGO SEKOLAH
                        Container(
                          width: 100,
                          height: 100,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withAlpha(12),
                                blurRadius: 15,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Image.asset(
                            'assets/logosmk.png',
                            fit: BoxFit.contain,
                            errorBuilder: (
                              context,
                              error,
                              stackTrace,
                            ) {
                              return const Icon(
                                Icons.school_rounded,
                                size: 75,
                                color: Color(0xFF3155FF),
                              );
                            },
                          ),
                        ),

                        const SizedBox(height: 24),

                        const Text(
                          'SMK NEGERI 1 BERINGIN',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF24243A),
                          ),
                        ),

                        const SizedBox(height: 8),

                        const Text(
                          'TASK & INVENTORY MANAGER',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 11,
                            letterSpacing: 1.1,
                            color: Color(0xFF4169E1),
                          ),
                        ),

                        const SizedBox(height: 30),

                        // USERNAME
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Username',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        const SizedBox(height: 8),

                        TextField(
                          controller: usernameController,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            hintText: 'Masukkan username',
                            prefixIcon: const Icon(
                              Icons.person_outline,
                            ),
                            filled: true,
                            fillColor: const Color(0xFFF4F5FB),
                            contentPadding:
                                const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 15,
                            ),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // PASSWORD
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Password',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        const SizedBox(height: 8),

                        TextField(
                          controller: passwordController,
                          obscureText: obscurePassword,
                          textInputAction: TextInputAction.done,
                          onSubmitted: (_) => login(),
                          decoration: InputDecoration(
                            hintText: 'Masukkan password',
                            prefixIcon: const Icon(
                              Icons.lock_outline,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  obscurePassword =
                                      !obscurePassword;
                                });
                              },
                              icon: Icon(
                                obscurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                            ),
                            filled: true,
                            fillColor: const Color(0xFFF4F5FB),
                            contentPadding:
                                const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 15,
                            ),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),

                        const SizedBox(height: 26),

                        // TOMBOL MASUK
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: bluePinkGradient,
                              borderRadius:
                                  BorderRadius.circular(15),
                            ),
                            child: ElevatedButton(
                              onPressed:
                                  isLoading ? null : login,
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Colors.transparent,
                                disabledBackgroundColor:
                                    Colors.transparent,
                                shadowColor: Colors.transparent,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(15),
                                ),
                              ),
                              child: isLoading
                                  ? const SizedBox(
                                      height: 23,
                                      width: 23,
                                      child:
                                          CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2.5,
                                      ),
                                    )
                                  : const Text(
                                      'MASUK',
                                      style: TextStyle(
                                        fontWeight:
                                            FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 14),

                        // LINK REGISTRASI
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.center,
                          children: [
                            const Flexible(
                              child: Text(
                                'Belum punya akun?',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        const RegisterScreen(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Registrasi',
                                style: TextStyle(
                                  color: Color(0xFF4169E1),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}