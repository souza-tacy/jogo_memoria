import 'package:flutter/material.dart';
import 'memorygame.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jogo da Memória',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MemoryGame(),
    );
  }
}
