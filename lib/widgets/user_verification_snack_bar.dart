import 'package:flutter/material.dart';

void showVerificationSnackBar(BuildContext context, bool userVerified) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!userVerified) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text("Please verify your email to continue"),
            action: SnackBarAction(
              label: "Verify",
              onPressed: () {
                Navigator.pushNamed(context, "/settings");
              },
            ),
          ),
        );
      }
    });
}