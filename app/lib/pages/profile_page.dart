import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heyuni/services/auth/auth_service.dart';
import 'package:heyuni/components/sign_button.dart';
import 'package:heyuni/pages/loginandregister/login_and_register_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Firestore'dan kullanıcı bilgilerini alır
  Future<Map<String, String>> getUserDetails() async {
    final currentUser = _auth.currentUser;

    if (currentUser == null) {
      throw Exception("Kullanıcı oturum açmamış.");
    }

    try {
      final userDoc =
          await _firestore.collection('users').doc(currentUser.uid).get();

      if (!userDoc.exists) {
        throw Exception("Kullanıcı Firestore'da bulunamadı.");
      }

      final data = userDoc.data();
      if (data == null) {
        throw Exception("Kullanıcı verisi boş.");
      }

      final String name = data['name'] ?? "İsim bulunamadı";
      final String surname = data['surname'] ?? "Soyisim bulunamadı";
      final String email = data['email'] ?? "E-posta bulunamadı";

      return {'name': name, 'surname': surname, 'email': email};
    } catch (e) {
      throw Exception("Kullanıcı bilgileri alınırken hata oluştu: $e");
    }
  }
}

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final AuthService _authService = AuthService();
  final UserService _userService = UserService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: FutureBuilder<Map<String, String>>(
        future: _userService.getUserDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Hata: ${snapshot.error}"));
          } else if (!snapshot.hasData) {
            return const Center(child: Text("Kullanıcı bilgileri alınamadı."));
          }

          final userDetails = snapshot.data!;
          final String name = userDetails['name']!;
          final String surname = userDetails['surname']!;
          final String email = userDetails['email']!;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Profil resmi
                ClipOval(
                  child: Image.asset(
                    'assets/images/default_pfp.jpeg', // Profil resmi
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                Column(
                  children: [
                    const SizedBox(height: 40.0),
                    // İsim
                    _buildProfileField("İsim", name),
                    const SizedBox(height: 5.0),
                    // Soyisim
                    _buildProfileField("Soyisim", surname),
                    const SizedBox(height: 5.0),
                    // E-posta
                    _buildProfileField("E-posta", email),
                    const SizedBox(height: 60.0),
                  ],
                ),
                // Çıkış Yap butonu
                SignButton(
                  text: "Çıkış Yap",
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  textColor: Colors.white,
                  onPressed: () async {
                    await _authService.signOut();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginAndRegisterPage(),
                      ),
                      (route) => false,
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Profil alanlarını oluşturur
  Widget _buildProfileField(String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.blue[900]!, width: 3.0),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black54,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
