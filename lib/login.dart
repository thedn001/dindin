import 'package:dindin_app/forgetpassword.dart';
import 'package:dindin_app/navadmin.dart';
import 'package:dindin_app/navbar.dart';
import 'package:dindin_app/navstaff.dart';
import 'package:dindin_app/terms.dart';
import 'package:flutter/material.dart';

class User {
  final String username;
  final String password;
  final int id;
  final int role; // 1 = you, 2 = admin, 3 = staff
  

  User({required this.username, required this.password, required this.role, required this.id});
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
// login simulater
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Fake user list
  final List<User> _users = [
  User(username: 'user', password: '123', role: 1, id: 1),
  User(username: 'admin', password: '123', role: 2, id: 2),
  User(username: 'staff', password: '123', role: 3, id: 3),
];

  String? _errorMessage;

  void _login() {
  String inputUsername = _usernameController.text.trim();
  String inputPassword = _passwordController.text;

  User matchedUser = _users.firstWhere(
    (user) =>
        user.username == inputUsername && user.password == inputPassword,
    orElse: () => User(username: '', password: '', role: 0, id: 0),
  );

  if (matchedUser.role != 0) {
    late Widget nextPage;

    switch (matchedUser.role) {
      case 1:
        nextPage = Navbar(userId: matchedUser.id, userRole: matchedUser.role);
        break;
      case 2:
        nextPage = Navadmin(userId: matchedUser.id, userRole: matchedUser.role);
        break;
      case 3:
        nextPage = Navstaff(userId: matchedUser.id, userRole: matchedUser.role);
        break;
      default:
        nextPage = Navbar(userId: matchedUser.id, userRole: matchedUser.role);
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Terms(
          onAccepted: () {
            Navigator.pop(context); // ปิดหน้า Terms
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => nextPage),
              (route) => false,
            );
          },
        ),
      ),
    );
  } else {
    setState(() {
      _errorMessage = "Invalid username or password.";
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 100),
              const Text(
                'Login',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'STUDENT ID',
                  labelStyle: TextStyle(fontSize: 14),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                obscureText: true,
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'PASSWORD',
                  labelStyle: TextStyle(fontSize: 14),
                ),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Forgetpassword()),
                    );
                  },
                  child: const Text(
                    'Forgot password ?',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // login btn
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber[700],
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),

              // login error
              if (_errorMessage != null) ...[
                const SizedBox(height: 12),
                Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red, fontSize: 14),
                ),
              ],
              // google login
              const SizedBox(height: 20),
              const Center(child: Text("Or")),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: Image.asset(
                    'assets/images/dindin.png',
                    height: 20,
                  ),
                  label: const Text(
                    'Login with Google',
                    style: TextStyle(color: Colors.black),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    side: const BorderSide(color: Colors.black),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
