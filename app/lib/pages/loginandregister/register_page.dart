import 'package:flutter/material.dart';
import 'package:heyuni/components/my_textfield.dart';
import 'package:heyuni/pages/loginandregister/login_and_register_page.dart';
import 'package:provider/provider.dart';
import 'package:heyuni/providers/register_provider.dart';
import 'package:heyuni/components/sign_button.dart';
import 'package:heyuni/pages/chat_page.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegisterProvider(),
      child: Scaffold(
        resizeToAvoidBottomInset:
            false, // Klavye açıldığında yeniden boyutlandırmayı engeller
        appBar: AppBar(
          title: Consumer<RegisterProvider>(
            builder: (context, provider, child) {
              double progress =
                  (provider.currentPage + 1) / 7; // Şu anda 6 sayfa var
              return LinearProgressIndicator(
                borderRadius: BorderRadius.circular(10),
                minHeight: 20,
                value: progress,
                backgroundColor: Colors.grey[300],
                color: Colors.deepPurpleAccent,
              );
            },
          ),
        ),
        body: Consumer<RegisterProvider>(
          builder: (context, provider, child) {
            return PageView(
              controller: provider.pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildEmailPasswordPage(context, provider),
                _buildNamePage(context, provider),
                _buildCountryAndLanguagePage(context, provider),
                _buildGraduationAndBudgetPage(context, provider),
                _buildEducationAndProficiencyPage(context, provider),
                _buildTargetMajorPage(context, provider),
                _buildInterestsPage(context, provider),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildEmailPasswordPage(
    BuildContext context,
    RegisterProvider provider,
  ) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // Üst kısım
            Column(
              children: [
                Image.asset(
                  'assets/images/logo.png', // Logo
                  width: 150,
                ),
                Image.asset('assets/images/cuate.png', width: 270),
                const SizedBox(height: 50),
                MyTextfield(
                  hintText: "Email?",
                  backgroundColor: Colors.white,
                  textColor: Theme.of(context).colorScheme.primary,
                  hintTextColor: Colors.grey,
                  controller: provider.emailController,
                ),
                const SizedBox(height: 10),
                MyTextfield(
                  hintText: "password?",
                  backgroundColor: Colors.white,
                  textColor: Theme.of(context).colorScheme.primary,
                  hintTextColor: Colors.grey,
                  controller: provider.passwordController,
                  isPassword: true,
                ),
              ],
            ),
            const Spacer(), // Esnek boşluk, butonu alta iter
            // "Devam Et" butonu
            SignButton(
              text: "Devam Et",
              backgroundColor: Theme.of(context).colorScheme.primary,
              textColor: Colors.white,
              onPressed: () {
                if (provider.email.isNotEmpty && provider.password.isNotEmpty) {
                  provider.nextPage();
                } else {
                  print("email veya password alanı boş!");
                }
              },
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildNamePage(BuildContext context, RegisterProvider provider) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/logo.png', // Logo
                    width: 150,
                  ),
                  Image.asset('assets/images/cuate.png', width: 270),
                  const SizedBox(height: 50),
                  MyTextfield(
                    hintText: "Adınız?",
                    backgroundColor: Colors.white,
                    textColor: Theme.of(context).colorScheme.primary,
                    hintTextColor: Colors.grey,
                    controller: provider.nameController,
                  ),
                  const SizedBox(height: 10),
                  MyTextfield(
                    hintText: "Soyadınız?",
                    backgroundColor: Colors.white,
                    textColor: Theme.of(context).colorScheme.primary,
                    hintTextColor: Colors.grey,
                    controller: provider.surnameController,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  SignButton(
                    text: "Devam Et",
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    textColor: Colors.white,
                    onPressed: () {
                      if (provider.name.isNotEmpty &&
                          provider.surname.isNotEmpty) {
                        provider.nextPage();
                      } else {
                        print("Ad veya soyad alanı boş!");
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCountryAndLanguagePage(
    BuildContext context,
    RegisterProvider provider,
  ) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/logo.png', // Logo
                    width: 150,
                  ),
                  Image.asset('assets/images/pana.png', width: 270),
                  const SizedBox(height: 50),
                  MyTextfield(
                    hintText: "Ülkeniz?",
                    backgroundColor: Colors.white,
                    textColor: Theme.of(context).colorScheme.primary,
                    hintTextColor: Colors.grey,
                    controller: provider.countryController,
                  ),
                  const SizedBox(height: 10),
                  MyTextfield(
                    hintText: "Konuştuğunuz Dil?",
                    backgroundColor: Colors.white,
                    textColor: Theme.of(context).colorScheme.primary,
                    hintTextColor: Colors.grey,
                    controller: provider.languageController,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  SignButton(
                    text: "Devam Et",
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    textColor: Colors.white,
                    onPressed: () {
                      if (provider.country.isNotEmpty &&
                          provider.language.isNotEmpty) {
                        provider.nextPage();
                      } else {
                        print("Ülke veya dil alanı boş!");
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGraduationAndBudgetPage(
    BuildContext context,
    RegisterProvider provider,
  ) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/logo.png', // Logo
                    width: 150,
                  ),
                  Image.asset('assets/images/amico.png', width: 270),
                  const SizedBox(height: 50),
                  MyTextfield(
                    hintText: "Kaç Yıl İçinde Mezun Olmayı Planlıyorsunuz?",
                    backgroundColor: Colors.white,
                    textColor: Theme.of(context).colorScheme.primary,
                    hintTextColor: Colors.grey,
                    controller: provider.yearsUntilGradController,
                  ),
                  const SizedBox(height: 10),
                  MyTextfield(
                    hintText: "Bütçeniz? \$",
                    backgroundColor: Colors.white,
                    textColor: Theme.of(context).colorScheme.primary,
                    hintTextColor: Colors.grey,
                    controller: provider.budgetController,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  SignButton(
                    text: "Devam Et",
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    textColor: Colors.white,
                    onPressed: () {
                      if (provider.yearsUntilGrad.isNotEmpty &&
                          provider.budget.isNotEmpty) {
                        provider.nextPage();
                      } else {
                        print("Mezuniyet yılı veya bütçe alanı boş!");
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEducationAndProficiencyPage(
    BuildContext context,
    RegisterProvider provider,
  ) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/logo.png', // Logo
                    width: 150,
                  ),
                  Image.asset('assets/images/bro.png', width: 270),
                  const SizedBox(height: 40),
                  MyTextfield(
                    hintText: "Eğitim Diliniz?",
                    backgroundColor: Colors.white,
                    textColor: Theme.of(context).colorScheme.primary,
                    hintTextColor: Colors.grey,
                    controller: provider.educationLanguageController,
                  ),
                  const SizedBox(height: 10),
                  MyTextfield(
                    hintText: "Eğitim Dilindeki Yeterliliğiniz?",
                    backgroundColor: Colors.white,
                    textColor: Theme.of(context).colorScheme.primary,
                    hintTextColor: Colors.grey,
                    controller: provider.educationLanguageProficiencyController,
                  ),
                  const SizedBox(height: 10),
                  MyTextfield(
                    hintText: "İngilizce Yeterliliğiniz?",
                    backgroundColor: Colors.white,
                    textColor: Theme.of(context).colorScheme.primary,
                    hintTextColor: Colors.grey,
                    controller: provider.englishProficiencyController,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  SignButton(
                    text: "Devam Et",
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    textColor: Colors.white,
                    onPressed: () {
                      if (provider.educationLanguage.isNotEmpty &&
                          provider.educationLanguageProficiency.isNotEmpty &&
                          provider.englishProficiency.isNotEmpty) {
                        provider.nextPage();
                      } else {
                        print(
                          "Eğitim dili, yeterlilik veya İngilizce alanı boş!",
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTargetMajorPage(
    BuildContext context,
    RegisterProvider provider,
  ) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/logo.png', // Logo
                    width: 150,
                  ),
                  Image.asset('assets/images/cuate2.png', width: 270),
                  const SizedBox(height: 50),
                  MyTextfield(
                    hintText: "Hedef Bölümleriniz?",
                    backgroundColor: Colors.white,
                    textColor: Theme.of(context).colorScheme.primary,
                    hintTextColor: Colors.grey,
                    controller: provider.targetMajorController,
                    maxLines: 3, // TextField yüksekliği 2 satır olacak
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  SignButton(
                    text: "Devam Et",
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    textColor: Colors.white,
                    onPressed: () {
                      if (provider.targetMajor.isNotEmpty) {
                        provider.nextPage();
                      } else {
                        print("Hedef bölümler alanı boş!");
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInterestsPage(BuildContext context, RegisterProvider provider) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/logo.png', // Logo
                    width: 150,
                  ),
                  Image.asset('assets/images/cuate3.png', width: 270),
                  const SizedBox(height: 50),
                  MyTextfield(
                    hintText: "İlgi Alanlarınız?",
                    backgroundColor: Colors.white,
                    textColor: Theme.of(context).colorScheme.primary,
                    hintTextColor: Colors.grey,
                    controller: provider.interestsController,
                    maxLines: 3, // TextField yüksekliği 3 satır olacak
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  SignButton(
                    text: "Tamamla",
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    textColor: Colors.white,
                    onPressed: () {
                      if (provider.interests.isNotEmpty) {
                        provider.saveData();
                        print("Kayıt tamamlandı!");
                        // ChatPage'e geçiş
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginAndRegisterPage(),
                          ),
                        );
                      } else {
                        print("İlgi alanları alanı boş!");
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
