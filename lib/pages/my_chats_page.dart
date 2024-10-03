import 'package:flutter/material.dart';

class MyChatPage extends StatelessWidget {
  const MyChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Chats'),
      ),
      body: Center(
        child: Text('My Chats'),
      ),
    );
  }
}