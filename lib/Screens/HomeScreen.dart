import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_bot/CustomItem/cusColors.dart';
import 'package:my_bot/CustomItem/cusMessage.dart';
import 'package:my_bot/CustomItem/cusText.dart';
import 'package:my_bot/Models/ChatModel.dart';
import 'package:my_bot/Provider/MessageProvider.dart';
import 'package:my_bot/Resources/ApiKey.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController queryController = TextEditingController();

  Future<ChatModel> sendRequest(String query) async {
    final url =
        'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=${ApiKey().api_key}';
    Uri uri = Uri.parse(url);
    final result = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(
        {
          "contents": [
            {
              "parts": [
                {
                  "text": query,
                },
              ],
            },
          ],
        },
      ),
    );
    final decodeJson = json.decode(result.body);
    String message = decodeJson['candidates'][0]['content']['parts'][0]['text'];
    return ChatModel(isMe: false, message: message);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MessageProvider>(
      builder: (context, value, child) {
        return Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        'assets/images/flower_image.jpg',
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      constraints: BoxConstraints(minHeight: 70),
                      alignment: Alignment.center,
                      width: double.infinity,
                      color: backGroundColor,
                      child: cusText('Gemini', 30, true),
                    ),
                    value.list.isEmpty
                        ? Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: backGroundColor,
                              borderRadius: BorderRadius.circular(
                                12,
                              ),
                            ),
                            child: cusText(
                                'Ask anything,\n as you want....', 30, false),
                          )
                        : Expanded(
                            child: ListView.builder(
                              itemCount: value.list.length,
                              itemBuilder: (context, index) {
                                ChatModel chat = value.list[index];
                                return cusMessage(chat.message, '', chat.isMe);
                              },
                            ),
                          ),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: backGroundColor,
                        borderRadius: BorderRadius.circular(
                          12,
                        ),
                      ),
                      height: 70,
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: queryController,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'ProtestRiot'),
                              decoration: InputDecoration(
                                label: cusText(
                                    'Enter your query......', 16, false),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 1),
                                  borderRadius: BorderRadius.circular(
                                    12,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 1),
                                  borderRadius: BorderRadius.circular(
                                    12,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              String query = queryController.text.toString();
                              value.addMessage(
                                ChatModel(
                                  isMe: true,
                                  message: '$query',
                                ),
                              );
                              queryController.clear();
                              ChatModel gemini = await sendRequest(query);
                              value.addMessage(gemini);
                            },
                            icon: const Icon(
                              Icons.send,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
