import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:heyuni/components/horizontal_university_list.dart';
import 'package:heyuni/components/my_appbar.dart';
import 'package:heyuni/components/my_drawer.dart';
import 'package:heyuni/models/university.dart';
import 'package:heyuni/services/user_service.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, String>> _messages = [];
  bool _isLoading = false;
  Map<String, dynamic>? user;

  @override
  void initState() {
    super.initState();
    _initializeUser();
  }

  /// Initializes the current user from Firestore and sends details to backend
  Future<void> _initializeUser() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      try {
        final userDoc =
            await FirebaseFirestore.instance
                .collection('users')
                .doc(currentUser.uid)
                .get();

        if (userDoc.exists) {
          setState(() {
            user = userDoc.data();
          });
          print("✅ Firestore'dan kullanıcı bilgileri alındı: $user");

          // Kullanıcı bilgilerini backend'e gönder
          final success = await UserService.sendUserDetails(user!);
          if (success) {
            print("✅ Kullanıcı bilgileri backend'e başarıyla gönderildi.");
          } else {
            print("❌ Kullanıcı bilgileri backend'e gönderilemedi.");
          }
        } else {
          print("❌ Kullanıcı Firestore'da bulunamadı.");
        }
      } catch (e) {
        print("❌ Firestore'dan kullanıcı bilgileri alınırken hata oluştu: $e");
      }
    } else {
      print("❌ Kullanıcı oturum açmamış.");
    }
  }

  /// Adds a message to the chat
  void _addMessage({required String sender, required String message}) {
    setState(() {
      _messages.add({"sender": sender, "message": message});
    });
  }

  /// Sends a user message and fetches a response from the bot
  Future<void> _sendMessage() async {
    if (user == null) {
      print("❌ Kullanıcı bilgileri mevcut değil.");
      return;
    }

    final message = _messageController.text.trim();
    if (message.isEmpty) return;

    // Add user message to the chat
    _addMessage(sender: "user", message: message);
    _messageController.clear();

    setState(() {
      _isLoading = true; // Start loading indicator
    });

    try {
      // Fetch bot response
      final response = await UserService.sendMessage(user!['id'], message);
      if (response != null) {
        _addMessage(sender: "bot", message: response);
      } else {
        _addMessage(
          sender: "bot",
          message: "Üzgünüm, bir hata oluştu. Lütfen tekrar deneyin.",
        );
      }
    } catch (e) {
      _addMessage(sender: "bot", message: "Bir hata oluştu: $e");
    } finally {
      setState(() {
        _isLoading = false; // Stop loading indicator
      });
    }
  }

  /// Builds a single chat message widget
  Widget _buildMessage(Map<String, String> message) {
    final isUser = message['sender'] == "user";
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isUser ? Colors.blue : Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        child: SelectableText(
          message['message']!,
          style: TextStyle(color: isUser ? Colors.white : Colors.black),
        ),
      ),
    );
  }

  /// Builds a bot message bubble
  Widget _buildBotBubble(String message) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(message, style: const TextStyle(color: Colors.black)),
      ),
    );
  }

  /// Builds a bot message bubble with a horizontal list of universities
  Widget buildBotHorizontalListBubble(List<University> universities) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: HorizontalUniversityList(universities: universities),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: const MyAppbar(),
      body: Column(
        children: [
          Expanded(
            child:
                _messages.isEmpty
                    ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(height: 200),
                          user != null
                              ? Text(
                                "Hello, ${user!['name']}!",
                                style: TextStyle(
                                  fontSize: 36,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              )
                              : CircularProgressIndicator(),
                        ],
                      ),
                    )
                    : ListView.builder(
                      itemCount: _messages.length,
                      itemBuilder: (context, index) {
                        final message = _messages[index];
                        if (message['sender'] == "bot" &&
                            message['message']!.startsWith('[')) {
                          final List<dynamic> universitiesJson = jsonDecode(
                            message['message']!,
                          );
                          final List<University> universities =
                              universitiesJson
                                  .map((json) => University.fromJson(json))
                                  .toList();
                          return buildBotHorizontalListBubble(universities);
                        } else if (message['sender'] == "user") {
                          return _buildMessage(message);
                        } else if (message['sender'] == "bot") {
                          return _buildBotBubble(message['message']!);
                        } else {
                          return _buildMessage(message);
                        }
                      },
                    ),
          ),
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: LinearProgressIndicator(),
            ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  /// Builds the message input field and send button
  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextField(
                controller: _messageController,
                decoration: InputDecoration(
                  hintText: "Mesajınızı yazın...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                      width: 2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white),
              onPressed: _isLoading ? null : _sendMessage,
            ),
          ),
        ],
      ),
    );
  }
}
