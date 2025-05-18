import 'package:flutter/material.dart';
import 'package:heyuni/pages/profile_page.dart'; // ProfilePage'i import edin

class MyAppbar extends StatefulWidget implements PreferredSizeWidget {
  const MyAppbar({super.key});

  @override
  State<MyAppbar> createState() => _MyAppbarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight); // AppBar yüksekliği
}

class _MyAppbarState extends State<MyAppbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leading: Builder(
        builder:
            (context) => Container(
              width: 40, // Sabit genişlik
              height: 40, // Sabit yükseklik
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).colorScheme.primary,
              ),
              margin: const EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: const Icon(Icons.menu, color: Colors.white),
              ),
            ),
      ),
      title: Image.asset("assets/images/logo.png", height: 40),
      centerTitle: true,
      actions: [
        Container(
          width: 40, // Sabit genişlik
          height: 40, // Sabit yükseklik
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Theme.of(context).colorScheme.primary,
          ),
          margin: const EdgeInsets.all(8.0),
          child: IconButton(
            onPressed: () {
              // Profil sayfasına geçiş
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
            icon: const Icon(Icons.person_2, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
