import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:heyuni/pages/chat_page.dart';
import 'package:heyuni/pages/loginandregister/login_and_register_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  Future<Map<String, dynamic>?> _fetchUserData(String userId) async {
    try {
      print("🔍 Firestore'dan kullanıcı bilgileri alınıyor. userId: $userId");
      final doc =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .get();
      if (doc.exists) {
        print("✅ Firestore'dan kullanıcı bilgileri alındı: ${doc.data()}");
        return doc.data();
      } else {
        print("❌ Kullanıcı bilgileri bulunamadı. userId: $userId");
        return null;
      }
    } catch (e) {
      print("❌ Firestore'dan kullanıcı bilgileri alınırken hata oluştu: $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          print("🔍 FirebaseAuth authStateChanges snapshot: ${snapshot.data}");
          if (snapshot.connectionState == ConnectionState.waiting) {
            print("⏳ FirebaseAuth bağlantı bekleniyor...");
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
              ),
            );
          } else if (snapshot.hasData) {
            final userId = snapshot.data!.uid;
            print("✅ FirebaseAuth oturum açmış kullanıcı: userId: $userId");

            // Kullanıcı bilgilerini Firestore'dan al
            return FutureBuilder<Map<String, dynamic>?>(
              future: _fetchUserData(userId),
              builder: (context, userSnapshot) {
                print(
                  "🔍 Firestore FutureBuilder snapshot: ${userSnapshot.data}",
                );
                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  print("⏳ Firestore'dan kullanıcı bilgileri bekleniyor...");
                  return Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  );
                } else if (userSnapshot.hasData) {
                  final userData = userSnapshot.data!;
                  print(
                    "✅ Firestore'dan alınan kullanıcı bilgileri: $userData",
                  );
                  return ChatPage();
                } else {
                  print("❌ Firestore'dan kullanıcı bilgileri alınamadı.");
                  return const LoginAndRegisterPage();
                }
              },
            );
          } else {
            print("❌ FirebaseAuth oturum açmamış kullanıcı.");
            // Kullanıcı oturum açmamışsa LoginAndRegisterPage'e yönlendir
            return const LoginAndRegisterPage();
          }
        },
      ),
    );
  }
}
