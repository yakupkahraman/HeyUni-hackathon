import 'package:flutter/material.dart';
import 'package:heyuni/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:heyuni/services/auth/auth_service.dart';

class RegisterProvider extends ChangeNotifier {
  final PageController pageController = PageController();

  // TextEditingController'lar
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController languageController = TextEditingController();
  final TextEditingController yearsUntilGradController =
      TextEditingController();
  final TextEditingController budgetController = TextEditingController();
  final TextEditingController educationLanguageController =
      TextEditingController();
  final TextEditingController educationLanguageProficiencyController =
      TextEditingController();
  final TextEditingController englishProficiencyController =
      TextEditingController();
  final TextEditingController targetMajorController = TextEditingController();
  final TextEditingController interestsController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  int currentPage = 0;

  // Getter'lar
  String get name => nameController.text;
  String get surname => surnameController.text;
  String get country => countryController.text;
  String get language => languageController.text;
  String get yearsUntilGrad => yearsUntilGradController.text;
  String get budget => budgetController.text;
  String get educationLanguage => educationLanguageController.text;
  String get educationLanguageProficiency =>
      educationLanguageProficiencyController.text;
  String get englishProficiency => englishProficiencyController.text;
  String get targetMajor => targetMajorController.text;
  String get interests => interestsController.text;
  String get email => emailController.text;
  String get password => passwordController.text;

  // Metotlar
  void updateName(String value) {
    nameController.text = value;
    notifyListeners();
  }

  void updateSurname(String value) {
    surnameController.text = value;
    notifyListeners();
  }

  void updateCountry(String value) {
    countryController.text = value;
    notifyListeners();
  }

  void updateLanguage(String value) {
    languageController.text = value;
    notifyListeners();
  }

  void updateYearsUntilGrad(String value) {
    yearsUntilGradController.text = value;
    notifyListeners();
  }

  void updateBudget(String value) {
    budgetController.text = value;
    notifyListeners();
  }

  void updateEducationLanguage(String value) {
    educationLanguageController.text = value;
    notifyListeners();
  }

  void updateEducationLanguageProficiency(String value) {
    educationLanguageProficiencyController.text = value;
    notifyListeners();
  }

  void updateEnglishProficiency(String value) {
    englishProficiencyController.text = value;
    notifyListeners();
  }

  void updateTargetMajor(String value) {
    targetMajorController.text = value;
    notifyListeners();
  }

  void updateInterests(String value) {
    interestsController.text = value;
    notifyListeners();
  }

  void updateEmail(String value) {
    emailController.text = value;
    notifyListeners();
  }

  void updatePassword(String value) {
    passwordController.text = value;
    notifyListeners();
  }

  void nextPage() {
    if (!pageController.hasClients)
      return; // Sayfa kontrolcüsü hala aktif mi kontrol et
    currentPage++;
    pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    notifyListeners();
  }

  void previousPage() {
    currentPage--;
    pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    notifyListeners();
  }

  // Firebase Authentication ile kullanıcı kaydı ve Firestore'a veri kaydetme
  Future<void> saveData() async {
    try {
      // Firebase Authentication ile kayıt ol
      final authService = AuthService();
      final userCredential = await authService.signUpWithEmailAndPassword(
        email: email,
        password: password,
        name: name,
        surname: surname,
        country: country,
        language: language,
        yearsUntilGrad: yearsUntilGrad,
        budget: budget,
        educationLanguage: educationLanguage,
        educationLanguageProficiency: educationLanguageProficiency,
        englishProficiency: englishProficiency,
        targetMajor: targetMajor,
        interests: interests,
      );

      // Kullanıcı bilgilerini Firestore'a kaydet
      final user = User(
        id: userCredential.user!.uid,
        email: email,
        password: password,
        name: name,
        surname: surname,
        country: country,
        language: language,
        yearsUntilGrad: yearsUntilGrad,
        budget: budget,
        educationLanguage: educationLanguage,
        educationLanguageProficiency: educationLanguageProficiency,
        englishProficiency: englishProficiency,
        targetMajor: targetMajor,
        interests: interests,
      );

      final firestore = FirebaseFirestore.instance;
      await firestore.collection('users').doc(user.id).set(user.toJson());

      print("✅ Kullanıcı başarıyla kaydedildi: ${user.toJson()}");
    } catch (e) {
      print("❌ Kullanıcı kaydedilirken bir hata oluştu: $e");
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    surnameController.dispose();
    countryController.dispose();
    languageController.dispose();
    yearsUntilGradController.dispose();
    budgetController.dispose();
    educationLanguageController.dispose();
    educationLanguageProficiencyController.dispose();
    englishProficiencyController.dispose();
    targetMajorController.dispose();
    interestsController.dispose();
    emailController.dispose();
    passwordController.dispose();
    pageController.dispose();
    super.dispose();
  }
}
