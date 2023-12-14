import 'package:frontend/constants/colors.dart';
import 'package:flutter/material.dart';

const TextStyle descriptionStyle =
    TextStyle(fontSize: 12, color: txtLight, fontWeight: FontWeight.w200);

const txtInputDecoration = InputDecoration(
  hintText: "email",
  fillColor: bgBlack,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(100),
    ),
    borderSide: BorderSide(color: mainYellow, width: 1),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(100),
    ),
    borderSide: BorderSide(color: mainYellow, width: 1),
  ),
  hintStyle: TextStyle(color: Colors.black, fontSize: 16),
);
