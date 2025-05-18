import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heyuni/components/my_appbar.dart';
import 'package:heyuni/components/my_drawer.dart';
import 'package:heyuni/models/university.dart';

class ApplicationsPage extends StatelessWidget {
  final List<University> unis = [
    University(
      collegeName: "Stanford Üniversitesi",
      imagePath: "assets/uni_logos/1.png",
      collegeLocation: "Stanford, California, USA",
      whatTheySpecializeIn: "Engineering and Technology",
      fit_score: 85,
    ),
    University(
      collegeName: "Michigan Yüksek Teknoloji Enstitüsü",
      imagePath: "assets/uni_logos/2.png",
      collegeLocation: "Houghton, Michigan, USA",
      whatTheySpecializeIn: "Engineering and Applied Sciences",
      fit_score: 93,
    ),
    University(
      collegeName: "Amsterdam Üniversitesi",
      imagePath: "assets/uni_logos/3.png",
      collegeLocation: "Amsterdam, Netherlands",
      whatTheySpecializeIn: "Social Sciences and Humanities",
      fit_score: 87,
    ),
    University(
      collegeName: "Yale Üniversitesi",
      imagePath: "assets/uni_logos/4.png",
      collegeLocation: "New Haven, Connecticut, USA",
      whatTheySpecializeIn: "Law and Liberal Arts",
      fit_score: 90,
    ),
    University(
      collegeName: "Columbia Üniversitesi",
      imagePath: "assets/uni_logos/5.png",
      collegeLocation: "New York City, New York, USA",
      whatTheySpecializeIn: "Business and Journalism",
      fit_score: 89,
    ),
    University(
      collegeName: "Bocconi Üniversitesi",
      imagePath: "assets/uni_logos/6.png",
      collegeLocation: "Milan, Italy",
      whatTheySpecializeIn: "Economics and Management",
      fit_score: 89,
    ),
    University(
      collegeName: "Tokyo Üniversitesi",
      imagePath: "assets/uni_logos/7.png",
      collegeLocation: "Tokyo, Japan",
      whatTheySpecializeIn: "Science and Technology",
      fit_score: 94,
    ),
    University(
      collegeName: "Viyana Üniversitesi",
      imagePath: "assets/uni_logos/8.png",
      collegeLocation: "Vienna, Austria",
      whatTheySpecializeIn: "Arts and Philosophy",
      fit_score: 85,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar(),
      drawer: MyDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: unis.length,
          itemBuilder: (context, index) {
            final uni = unis[index];
            return Column(
              children: [
                ListTile(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.blue[900]!, width: 3.0),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage(uni.imagePath),
                      ),
                    ],
                  ),
                  title: Text(
                    uni.collegeName,
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
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
