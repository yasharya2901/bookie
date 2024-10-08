import 'package:appwrite/appwrite.dart';
import 'package:bookie/configs/appwrite_config.dart';
import 'package:bookie/configs/global_user_state_manager.dart';
import 'package:bookie/providers/user_provider.dart';
import 'package:bookie/widgets/error.dart';
import 'package:flutter/material.dart';
import 'package:appwrite/models.dart' as models;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

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
      Avatars? avatars = appwriteAvatars();
      if (avatars == null) {
        throw Exception("Avatars is not initialized");
      }

      Account? account = appwriteAccount();
      if (account == null) {
        throw Exception("Account is not initialized");
      }

      email = email.trim();
      await account.createEmailPasswordSession(email: email, password: password);
      final user = await account.get();
      final initials = await avatars.getInitials(name: user.name, width: 50, height: 50);

      if (mounted){
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        setUserName(user.name, userProvider);
        setUserAvatar(initials, userProvider);
        setUserVerificationStatus(user.emailVerification, userProvider);
      }

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
