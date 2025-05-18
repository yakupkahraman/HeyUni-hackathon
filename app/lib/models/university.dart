class University {
  final String collegeName;
  final String collegeLocation;
  final String whatTheySpecializeIn;
  final int fit_score;
  final String imagePath;

  University({
    required this.collegeName,
    required this.collegeLocation,
    required this.whatTheySpecializeIn,
    required this.fit_score,
    required this.imagePath,
  });

  factory University.fromJson(Map<String, dynamic> json) {
    return University(
      collegeName: json['college_name'] as String? ?? '',
      collegeLocation: json['college_location'] as String? ?? '',
      whatTheySpecializeIn: json['what_they_specialize_in'] as String? ?? '',
      fit_score: json['fit_score'] as int? ?? 0,
      imagePath: json['image_path'] as String? ?? '',
    );
  }
}
