import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              const Text("Login Page"),
              const Spacer(),
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: "Username",
                  ),
                ),
              ),
              const TextField(
                decoration: InputDecoration(
                  hintText: "Password",
                ),
                obscureText: true,
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  // Navigate to the home page when pressed
                  Navigator.pushReplacementNamed(context, "/home");
                },
                child: const Text("Sign In"),
              ),
              Container(
                margin: const EdgeInsets.only(top: 8),
                child: TextButton(
                  onPressed: () {
                    // Navigate to the sign-up page when pressed
                    Navigator.pushNamed(context, "/signup");
                  },
                  child: const Text("New User? Sign Up"),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}