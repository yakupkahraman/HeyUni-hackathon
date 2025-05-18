import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heyuni/components/my_appbar.dart';
import 'package:heyuni/components/my_drawer.dart';
import 'package:heyuni/models/mentor.dart';
import 'package:heyuni/pages/video_player_page.dart';

class MentorsPage extends StatelessWidget {
  final List<Mentor> mentors = [
    Mentor(
      name: "Debora Mahmutaj",
      university: "Yıldız Teknik Üniversitesi",
      imagePath: "assets/profile_pics/1.png",
      country: "🇦🇱",
    ),
    Mentor(
      name: "Kaan Paçaman",
      university: "Eindhoven Teknoloji Üniversitesi",
      imagePath: "assets/profile_pics/2.png",
      country: "🇹🇷",
    ),
    Mentor(
      name: "Albert Flores",
      university: "Harvard Üniversitesi",
      imagePath: "assets/profile_pics/3.png",
      country: "🇳🇿",
    ),
    Mentor(
      name: "Leslie Alexander",
      university: "Columbia Üniversitesi",
      imagePath: "assets/profile_pics/4.png",
      country: "🇧🇷",
    ),
    Mentor(
      name: "Wade Warren",
      university: "Bocconi Üniversitesi",
      imagePath: "assets/profile_pics/5.png",
      country: "🇳🇴",
    ),
    Mentor(
      name: "Darlene Robertson",
      university: "New York Üniversitesi",
      imagePath: "assets/profile_pics/6.png",
      country: "🇯🇵",
    ),
    Mentor(
      name: "Floyd Miles",
      university: "Brno Teknoloji Üniversitesi",
      imagePath: "assets/profile_pics/7.png",
      country: "🇿🇦",
    ),
    Mentor(
      name: "Ralph Edwards",
      university: "Tokyo Üniversitesi",
      imagePath: "assets/profile_pics/8.png",
      country: "🇮🇹",
    ),
    Mentor(
      name: "Hunter Doe",
      university: "Harvard Üniversitesi",
      imagePath: "assets/profile_pics/9.png",
      country: "🇨🇦",
    ),
    Mentor(
      name: "Militsa Mahmutaj",
      university: "Yıldız Teknik Üniversitesi",
      imagePath: "assets/profile_pics/10.png",
      country: "🇸🇪",
    ),
    Mentor(
      name: "Jack Steward",
      university: "Yale Üniversitesi",
      imagePath: "assets/profile_pics/11.png",
      country: "🇰🇷",
    ),
    Mentor(
      name: "Mark Flores",
      university: "Harvard Üniversitesi",
      imagePath: "assets/profile_pics/12.png",
      country: "🇲🇽",
    ),
    // Mentor(name: "Jane Smith", university: "Stanford University", imagePath: "assets/images/jane.jpg"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar(),
      drawer: MyDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: mentors.length,
          itemBuilder: (context, index) {
            final mentor = mentors[index];
            return Column(
              children: [
                ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => VideoPlayerPage(
                              num: "${index + 1}",
                              username: mentors[index].name,
                            ),
                      ),
                    );
                  },
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.blue[900]!, width: 3.0),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage(mentor.imagePath),
                      ),
                    ],
                  ),
                  title: Text(
                    maxLines: 1,
                    mentor.name,
                    style: GoogleFonts.poppins(
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    mentor.university,
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        mentor.country,
                        style: GoogleFonts.poppins(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16), // Adds spacing between items
              ],
            );
          },
        ),
      ),
    );
  }
}
