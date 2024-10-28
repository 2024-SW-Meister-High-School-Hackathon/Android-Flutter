import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firebase Email/Password Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginScreen(),
    );
  }
}

// 이메일/비밀번호 로그인 화면
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("로그인 성공!")),
      );
      // 로그인 성공 시 홈 화면으로 이동
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("로그인 실패: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("로그인"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: '이메일',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: '비밀번호',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 24.0),
                backgroundColor: Colors.blueAccent,
              ),
              onPressed: _signIn,
              child: const Text("로그인", style: TextStyle(fontSize: 18)),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignupScreen()),
                );
              },
              child: const Text("계정이 없으신가요? 회원가입"),
            ),
          ],
        ),
      ),
    );
  }
}

// 회원가입 화면
class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _signUp() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("회원가입 성공!")),
      );
      Navigator.pop(context); // 로그인 화면으로 돌아가기
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("회원가입 실패: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("회원가입"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: '이메일',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: '비밀번호',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 24.0),
                backgroundColor: Colors.blueAccent,
              ),
              onPressed: _signUp,
              child: const Text("회원가입", style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}

// 홈 화면
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,  // 뒤로가기 버튼 제거
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