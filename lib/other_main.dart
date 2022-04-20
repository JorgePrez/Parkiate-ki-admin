import 'package:flutter/material.dart';
import 'package:parkline/firebase_crud/skillshare.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SkillShare(),
    );
  }
}
