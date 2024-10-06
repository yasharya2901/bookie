import 'package:appwrite/appwrite.dart';
import 'package:bookie/configs/global_user_state_manager.dart';
import 'package:bookie/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserSettingsPage extends StatefulWidget {
  final Account account;
  const UserSettingsPage({super.key, required this.account});

  @override
  State<UserSettingsPage> createState() => _UserSettingsPageState();
}

class _UserSettingsPageState extends State<UserSettingsPage> {

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    Future<void> logout() async {
      await widget.account.deleteSession(sessionId: 'current');
      clearUser(userProvider);
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Settings'),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () async {
              await logout();
              if (context.mounted){
                Navigator.pushReplacementNamed(context, '/login');}
            }, 
            child: const Text('Logout')
          ),
      ),
    );
  }
}
