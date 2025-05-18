import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Şu anki kullanıcıyı al
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  User? get currentUser {
    return FirebaseAuth.instance.currentUser;
  }

  /// E-posta ve şifre ile giriş yap
  Future<UserCredential> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("✅ Kullanıcı giriş yaptı: ${result.user?.email}");
      return result;
    } on FirebaseAuthException catch (e) {
      print("❌ Giriş hatası: ${e.code}");
      throw Exception(e.code);
    }
  }

  /// E-posta ve şifre ile kayıt ol ve Firestore'a kaydet
  Future<UserCredential> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required String surname,
    required String country,
    required String language,
    required String yearsUntilGrad,
    required String budget,
    required String educationLanguage,
    required String educationLanguageProficiency,
    required String englishProficiency,
    required String targetMajor,
    required String interests,
  }) async {
    try {
      // Firebase Authentication ile kullanıcı kaydı
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Kullanıcı bilgilerini Firestore'a kaydet
      final userId = result.user!.uid;
      final userData = {
        'id': userId,
        'email': email,
        'name': name,
        'surname': surname,
        'country': country,
        'language': language,
        'years_until_grad': yearsUntilGrad,
        'budget': budget,
        'education_language': educationLanguage,
        'education_language_proficiency': educationLanguageProficiency,
        'english_proficiency': englishProficiency,
        'target_major': targetMajor,
        'interests': interests,
      };

      await _firestore.collection('users').doc(userId).set(userData);

      print("✅ Kullanıcı kaydedildi ve Firestore'a eklendi: $userData");
      return result;
    } on FirebaseAuthException catch (e) {
      print("❌ Kayıt hatası: ${e.code}");
      throw Exception(e.code);
    } catch (e) {
      print("❌ Firestore'a kaydetme hatası: $e");
      throw Exception("Firestore hatası: $e");
    }
  }

  /// Çıkış yap
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      print("✅ Kullanıcı çıkış yaptı.");
    } on FirebaseAuthException catch (e) {
      print("❌ Çıkış hatası: ${e.code}");
      throw Exception(e.code);
    }
  }

  /// Şifre sıfırlama
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      print("✅ Şifre sıfırlama e-postası gönderildi: $email");
    } on FirebaseAuthException catch (e) {
      print("❌ Şifre sıfırlama hatası: ${e.code}");
      throw Exception(e.code);
    }
  }
}
