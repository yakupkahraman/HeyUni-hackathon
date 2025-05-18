import 'package:flutter/material.dart';
import 'package:heyuni/models/university.dart';

class UniversityCard extends StatelessWidget {
  final University university;
  final VoidCallback onDetailsPressed;

  const UniversityCard({
    super.key,
    required this.university,
    required this.onDetailsPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary, // Arka plan rengi
        borderRadius: BorderRadius.circular(15), // Border radius
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 9.0),
          Text(
            "${university.fit_score.toString()}/100",
            style: const TextStyle(fontSize: 36.0, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          Text(
            maxLines: 2,
            university.collegeName,
            style: const TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20.0),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Theme.of(context).colorScheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            onPressed: onDetailsPressed,
            child: const Text("Detaylar"),
          ),
        ],
      ),
    );
  }
}
