import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {

  const SignUpPage({super.key});

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
              const Text("SignUp Page"),
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
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {},
                child: const Text("Sign Up"),
              ),
              Container(
                margin: const EdgeInsets.only(top: 8),
                child: TextButton(
                  onPressed: () {
                    // Navigate to the sign-up page when pressed
                    Navigator.pushReplacementNamed(context, "/login");
                  },
                  child: const Text("Existing User? Sign In"),
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