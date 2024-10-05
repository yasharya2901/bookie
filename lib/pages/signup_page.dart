import 'package:appwrite/appwrite.dart';
import 'package:bookie/widgets/error.dart';
import 'package:flutter/material.dart';
import 'package:appwrite/models.dart' as models;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SignUpPage extends StatefulWidget {
  final Account account;
  const SignUpPage({super.key, required this.account});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  models.User? signedUpUser;
  bool error = false;
  String errorMessage = "";
  bool errorVisible = false; // Controls the visibility of the error animation

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> _signUp(String name, String email, String password) async {
    try {
      name = name.trim();
      email = email.trim();
      await widget.account.create(userId: ID.unique(), email: email, password: password);
      await widget.account.createEmailPasswordSession(email: email, password: password);
      await widget.account.updateName(name: name);
      final user = await widget.account.get();
      // Set the user_id in the persistent storage
      const storage = FlutterSecureStorage();
      await storage.write(key: "user_id", value: user.$id);
      setState(() {
        signedUpUser = user;
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
            Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  const Text("SignUp Page"),
                  const Spacer(),
                  TextField(
                    decoration: const InputDecoration(
                      hintText: "Name",
                    ),
                    controller: nameController,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    decoration: const InputDecoration(
                      hintText: "Email",
                    ),
                    controller: emailController,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    decoration: const InputDecoration(
                      hintText: "Password",
                    ),
                    obscureText: true,
                    controller: passwordController,
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () async {
                      await _signUp(nameController.text, emailController.text, passwordController.text);
                      if (signedUpUser != null && context.mounted) {
                        Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
                      }
                    },
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
          ErrorPopUp(errorMessage: errorMessage, errorVisible: errorVisible),
        ]
      ),
    );
  }
}