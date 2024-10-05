import 'package:flutter/material.dart';

class ErrorPopUp extends StatelessWidget {
  const ErrorPopUp({
    super.key,
    required this.errorVisible,
    required this.errorMessage,
  });

  final bool errorVisible;
  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      bottom: errorVisible ? 20 : -150, // Error message slides up from bottom
      left: 20,
      right: 20,
      child: Visibility(
        visible: errorVisible,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error, color: Colors.white, size: 40),
              const SizedBox(height: 10),
              Text(
                errorMessage,
                style: const TextStyle(color: Colors.white, fontSize: 18),
                textAlign: TextAlign.center,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}