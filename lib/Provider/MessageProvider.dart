import 'package:flutter/material.dart';
import 'package:my_bot/Models/ChatModel.dart';

class MessageProvider extends ChangeNotifier{
  List<ChatModel> list = [];
  addMessage(ChatModel chat){
    list.add(chat);
    notifyListeners();
  }
}