import 'package:flutter/material.dart';
import 'package:heyuni/pages/chat_page.dart';
import 'package:heyuni/services/auth/auth_service.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  /// Logs out the user and navigates back
  Future<void> _logout(BuildContext context) async {
    try {
      final authService = AuthService();
      await authService.signOut();
      print("✅ Çıkış yapıldı.");
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/loginAndRegister',
        (route) => false,
      );
    } catch (e) {
      print("❌ Çıkış sırasında hata oluştu: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();
    final currentUser = authService.currentUser;

    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: EdgeInsets.zero,
            decoration: const BoxDecoration(color: Colors.white),
            child: Image.asset("assets/images/logo.png", fit: BoxFit.scaleDown),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons.chat_bubble_rounded,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      title: const Text('Chat Bot'),
                      onTap: () {
                        if (currentUser != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ChatPage()),
                          );
                        } else {
                          print("❌ Kullanıcı oturum açmamış.");
                        }
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.file_copy,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      title: const Text('Başvurularım'),
                      onTap: () {
                        Navigator.pushNamed(context, '/applications');
                      },
                    ),

                    ListTile(
                      leading: Icon(
                        Icons.people_alt,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      title: const Text('Mentörler'),
                      onTap: () {
                        Navigator.pushNamed(context, '/mentors');
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.settings,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      title: const Text('Ayarlar'),
                      onTap: () {
                        Navigator.pushNamed(context, '/settings');
                      },
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: SizedBox(
                    width: 250,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        padding: const EdgeInsets.symmetric(
                          vertical: 15.0,
                          horizontal: 20.0,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      onPressed: () {
                        _logout(context);
                      },
                      child: const Text(
                        "Çıkış Yap",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
