import 'package:chooyan_resume/top_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chooyan Portfolio',
      theme: ThemeData.dark(useMaterial3: true),
      home: const TopPage(),
    );
  }
}
