import 'package:flutter/material.dart';
import 'package:heyuni/components/university_card.dart';
import 'package:heyuni/models/university.dart';
import 'package:heyuni/pages/university_details_page.dart';

class HorizontalUniversityList extends StatelessWidget {
  final List<University> universities;

  const HorizontalUniversityList({super.key, required this.universities});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200, // Kartların yüksekliğini belirler
      child: ListView.builder(
        scrollDirection: Axis.horizontal, // Yatay kaydırma
        itemCount: universities.length,
        itemBuilder: (context, index) {
          final university = universities[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: UniversityCard(
              university: university,
              onDetailsPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => UniversityDetailsPage(
                          universityName: university.collegeName,
                          universityImagePath: university.imagePath,
                        ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
