import 'package:appwrite/appwrite.dart';
import 'package:bookie/widgets/error.dart';
import 'package:flutter/material.dart';
import 'package:appwrite/models.dart' as models;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginPage extends StatefulWidget {
  final Account account;
  const LoginPage({super.key, required this.account});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  models.User? loggedInUser;
  bool error = false;
  String errorMessage = "";
  bool errorVisible = false; // Controls the visibility of the error animation
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> _login(String email, String password) async {
    try {
      email = email.trim();
      await widget.account.createEmailPasswordSession(email: email, password: password);
      final user = await widget.account.get();

      // Set the user_id in the persistent storage
      const storage = FlutterSecureStorage();
      await storage.write(key: "user_id", value: user.$id);

      setState(() {
        loggedInUser = user;
        error = false; // Reset error if successful
        errorVisible = false; // Hide error message
      });
    } on Exception catch (e) {
      setState(() {
        error = true;
        errorMessage = e.toString();
        errorVisible = true; // Show error message
      });

      // Hide the error after 3 seconds
      Future.delayed(const Duration(seconds: 3), () {
        setState(() {
          errorVisible = false; // Animate error message out
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // The rest of your login UI
          Padding(
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
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: "Email",
                      ),
                      controller: emailController,
                    ),
                  ),
                  TextField(
                    decoration: const InputDecoration(
                      hintText: "Password",
                    ),
                    controller: passwordController,
                    obscureText: true,
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () async {
                      await _login(emailController.text, passwordController.text);
                      if (loggedInUser != null && context.mounted) {
                        Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
                      }
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

          // Error overlay with animation
          ErrorPopUp(errorVisible: errorVisible, errorMessage: errorMessage),
        ],
      ),
    );
  }
}
