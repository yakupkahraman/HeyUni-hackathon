import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  static const String baseUrl = 'http://35.192.132.90:8080';

  /// Kullanıcı oluşturma isteği
  static Future<bool> createUser(Map<String, dynamic> userData) async {
    final url = Uri.parse('$baseUrl');

    userData['id'] = "string";
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(userData),
      );
      if (response.statusCode == 200) {
        print("✅ Kullanıcı başarıyla oluşturuldu.");
        return true;
      } else {
        print("❌ Kullanıcı oluşturulamadı.");
        return false;
      }
    } catch (e) {
      print("❌ Hata oluştu: $e");
      return false;
    }
  }

  /// Sends a message to the bot and returns the response
  static Future<String?> sendMessage(String sessionId, String message) async {
    final url = Uri.parse('$baseUrl/chat');
    final body = jsonEncode({'id': sessionId, 'message': message});

    try {
      print("📤 Mesaj gönderiliyor: $body");
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        print("✅ Yanıt alındı: ${decoded['response']}");
        return decoded['response'];
      } else {
        print("❌ Mesaj gönderilemedi. Status Code: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("❌ Hata oluştu: $e");
      return null;
    }
  }

  /// Kullanıcı bilgilerini backend'e gönder
  static Future<bool> sendUserDetails(Map<String, dynamic>? userDetails) async {
    final url = Uri.parse('$baseUrl');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(userDetails),
      );

      if (response.statusCode == 200) {
        print("✅ Kullanıcı bilgileri başarıyla gönderildi.");
        return true;
      } else {
        print(
          "❌ Kullanıcı bilgileri gönderilemedi. Status Code: ${response.statusCode}",
        );
        return false;
      }
    } catch (e) {
      print("❌ Kullanıcı bilgileri gönderilirken hata oluştu: $e");
      return false;
    }
  }

  /// Üniversite hakkında detaylı bilgi almak için AI'ya istek gönderir
  static Future<String?> getUniversityDetails(String universityName) async {
    final url = Uri.parse('$baseUrl/chat');
    final prompt =
        "Bu $universityName adlı üniversite hakkında detaylı tanıtım ardından benim profilimin bu üniversitenin giriş kriterlerinden hangilerini karşıladığı ve hangi avantajlarımın olduğunu, ayrıca başvuru sürecinde neler yapmam gerektiği ve kendime hangi yetkinlikleri eklersem şansımın daha yüksek olacağına dair analiz yapabilir misin? Bide başta 'tabiii...' gibi cümleler kurma direkt üniversitenin adı ile başla";

    // Kullanıcının UID'sini al
    final currentUser = FirebaseAuth.instance.currentUser;
    final userId =
        currentUser?.uid ??
        "anonim"; // Eğer kullanıcı oturum açmamışsa "anonim" kullanılır

    final body = jsonEncode({'id': userId, 'message': prompt});

    try {
      print("📤 AI'ya istek gönderiliyor: $prompt");
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        print("✅ AI'dan yanıt alındı: ${decoded['response']}");
        return decoded['response'];
      } else {
        print("❌ AI isteği başarısız. Status Code: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("❌ AI isteği sırasında hata oluştu: $e");
      return null;
    }
  }
}
