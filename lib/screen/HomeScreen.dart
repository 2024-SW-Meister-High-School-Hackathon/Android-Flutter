// 홈 화면
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("홈 화면"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: const Text(
          '로그인 성공! 환영합니다.',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}