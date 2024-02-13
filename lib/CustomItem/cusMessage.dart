import 'package:flutter/material.dart';
import 'package:my_bot/CustomItem/cusColors.dart';
import 'package:my_bot/CustomItem/cusText.dart';

Widget cusMessage(String message, String time, bool isMe) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
    alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
    child: Container(
        constraints: BoxConstraints(maxWidth: 300),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: backGroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            cusText(
              isMe ? 'Me' : 'Gemini',
              20,
              true,
            ),
            cusText(
              '$message',
              18,
              false,
            ),
          ],
        )),
  );
}
