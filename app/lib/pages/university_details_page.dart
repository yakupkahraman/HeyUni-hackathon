import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:heyuni/components/my_appbar.dart';
import 'package:heyuni/components/my_drawer.dart';
import 'package:heyuni/services/user_service.dart';
import 'package:shimmer/shimmer.dart';

class UniversityDetailsPage extends StatefulWidget {
  final String universityName; // Üniversite adı
  final String universityImagePath; // Üniversite resmi yolu

  const UniversityDetailsPage({
    super.key,
    required this.universityName,
    required this.universityImagePath,
  });

  @override
  State<UniversityDetailsPage> createState() => _UniversityDetailsPageState();
}

class _UniversityDetailsPageState extends State<UniversityDetailsPage> {
  late double screenHeight;
  late double screenWidth;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final mediaQuery = MediaQuery.of(context);
    screenHeight = mediaQuery.size.height;
    screenWidth = mediaQuery.size.width;
  }

  String? responseText; // AI yanıtı
  bool isLoading = true; // Yükleme durumu

  @override
  void initState() {
    super.initState();
    _fetchUniversityDetails();
  }

  Future<void> _fetchUniversityDetails() async {
    try {
      final response = await UserService.getUniversityDetails(
        widget.universityName,
      );
      if (mounted) {
        // Widget hala aktif mi kontrol et
        setState(() {
          responseText = response;
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        // Widget hala aktif mi kontrol et
        setState(() {
          responseText = "Bir hata oluştu: $e";
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppbar(),
      drawer: const MyDrawer(),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  maxLines: 2,
                  widget.universityName,
                  style: TextStyle(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    fontSize: 45,
                  ),
                ),
              ],
            ),
          ),
          // AI yanıtı
          Expanded(
            child:
                isLoading
                    ? _buildShimmerEffect() // Shimmer efekti
                    : Text(responseText ?? "yanıt alınamadı") /*Markdown(
                      data: responseText ?? "yanıt alınamadı.",
                      styleSheet: MarkdownStyleSheet.fromTheme(
                        Theme.of(context),
                      ),
                    ),*/,
          ),
        ],
      ),
    );
  }

  /// Shimmer efekti
  Widget _buildShimmerEffect() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          6,
          (index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Container(
              width: double.infinity,
              height: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
