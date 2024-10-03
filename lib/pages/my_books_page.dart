import 'package:flutter/material.dart';

class MyBooksPage extends StatelessWidget {
  const MyBooksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Books'),
      ),
      body: const Center(
        child: Text('My Books Page'),
      ),
    );
  }
}
 