import 'package:flutter/material.dart';

Widget cusText(String text,double size,bool isBold){
  return Text(
    text,
    style: TextStyle(
      fontSize: size,
      color: Colors.white,
      fontFamily: 'ProtestRiot',
      fontWeight: isBold? FontWeight.bold : FontWeight.w300,
    ),
  );
}