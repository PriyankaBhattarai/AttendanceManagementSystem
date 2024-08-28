import 'package:ams/pages/signUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'dashboard.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 50.0),
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Enter your username',
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Enter your password',
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.0),
              if (_errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    _errorMessage,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              SizedBox(
                height: 70,
                width: 300,
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                    ),
                    onPressed: () async {
                      if (emailController.text.isNotEmpty &&
                          passwordController.text.length > 6) {
                        await _login();
                      } else {
                        setState(() {
                          _errorMessage =
                              'Email is empty or password is invalid';
                        });
                      }
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Signup()),
                    );
                  },
                  child: Text(
                    'New User? Sign Up',
                    style: TextStyle(
                      color: Colors.blue,
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

  Future<void> _login() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      if (userCredential.user == null) {
        print('Login failed');
        return;
      }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DashboardPage()),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        if (e.code == 'user-not-found') {
          _errorMessage = 'No user found for that email.';
        } else if (e.code == 'wrong-password') {
          _errorMessage = 'Wrong password provided.';
        } else if (e.code == 'invalid-credential') {
          _errorMessage = 'user not found';
        } else {
          _errorMessage = 'Something went wrong. Please try again.';
        }
      });
    }
  }
}
