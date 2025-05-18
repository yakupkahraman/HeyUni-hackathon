import 'package:flutter/material.dart';
import 'package:heyuni/components/sign_button.dart';
import 'package:heyuni/components/my_textfield.dart';
import 'package:heyuni/pages/loginandregister/register_page.dart';
import 'package:heyuni/pages/chat_page.dart';
import 'package:heyuni/services/auth/auth_service.dart';

class LoginAndRegisterPage extends StatefulWidget {
  const LoginAndRegisterPage({super.key});

  @override
  State<LoginAndRegisterPage> createState() => _LoginAndRegisterPageState();
}

class _LoginAndRegisterPageState extends State<LoginAndRegisterPage> {
  bool rememberMe = false; // Checkbox state
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService _authService = AuthService(); // AuthService instance

  /// Handles user sign-in
  Future<void> _signIn() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showErrorDialog("E-posta ve şifre boş olamaz!");
      return;
    }

    try {
      final userCredential = await _authService.signInWithEmailAndPassword(
        email,
        password,
      );
      print("✅ Giriş başarılı: ${userCredential.user?.email}");

      // Navigate to ChatPage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ChatPage()),
      );
    } catch (e) {
      print("❌ Giriş hatası: $e");
      _showErrorDialog("Giriş sırasında bir hata oluştu: $e");
    }
  }

  /// Displays an error dialog
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Hata"),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Tamam"),
              ),
            ],
          ),
    );
  }

  /// Builds the login modal bottom sheet
  Widget _buildLoginModal() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.6,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            width: 60,
            height: 4,
            margin: const EdgeInsets.only(bottom: 16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(2.0),
            ),
          ),
          const Text(
            "Giriş Yap",
            style: TextStyle(
              fontSize: 40.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20.0),
          MyTextfield(
            hintText: "E-posta",
            backgroundColor: Colors.white,
            textColor: Colors.black,
            hintTextColor: Colors.grey,
            controller: emailController,
          ),
          const SizedBox(height: 16.0),
          MyTextfield(
            hintText: "Şifre",
            backgroundColor: Colors.white,
            textColor: Colors.black,
            hintTextColor: Colors.grey,
            controller: passwordController,
          ),
          const SizedBox(height: 5.0),
          _buildRememberMeAndForgotPassword(),
          const SizedBox(height: 80.0),
          SignButton(
            text: "Giriş Yap",
            backgroundColor: Colors.white,
            textColor: Theme.of(context).colorScheme.primary,
            onPressed: _signIn,
          ),
        ],
      ),
    );
  }

  /// Builds the "Remember Me" checkbox and "Forgot Password" link
  Widget _buildRememberMeAndForgotPassword() {
    return SizedBox(
      width: 330,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              print("Parolamı Unuttum tıklandı!");
            },
            child: const Text(
              "Parolanızı mı unuttunuz?",
              style: TextStyle(
                color: Colors.white,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset('assets/images/logo.png', width: 250),
                  Text(
                    '"Smarter Applications, Brighter Destinations"',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SignButton(
                    text: "Giriş Yap",
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    textColor: Colors.white,
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) => _buildLoginModal(),
                      );
                    },
                  ),
                  const SizedBox(height: 16.0),
                  SignButton(
                    text: "Kaydol",
                    backgroundColor: Colors.white,
                    textColor: Theme.of(context).colorScheme.primary,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterPage(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 70),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
