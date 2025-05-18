class User {
  final String id;
  final String email;
  final String password;
  final String name;
  final String surname;
  final String country;
  final String language;
  final String yearsUntilGrad;
  final String budget;
  final String educationLanguage;
  final String educationLanguageProficiency;
  final String englishProficiency;
  final String targetMajor;
  final String interests;

  User({
    required this.id,
    required this.email,
    required this.password,
    required this.name,
    required this.surname,
    required this.country,
    required this.language,
    required this.yearsUntilGrad,
    required this.budget,
    required this.educationLanguage,
    required this.educationLanguageProficiency,
    required this.englishProficiency,
    required this.targetMajor,
    required this.interests,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'name': name,
      'surname': surname,
      'country': country,
      'language': language,
      'yearsUntilGrad': yearsUntilGrad,
      'budget': budget,
      'educationLanguage': educationLanguage,
      'educationLanguageProficiency': educationLanguageProficiency,
      'englishProficiency': englishProficiency,
      'targetMajor': targetMajor,
      'interests': interests,
    };
  }
}
