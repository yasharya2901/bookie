import 'package:appwrite/appwrite.dart';
import 'package:bookie/configs/appwrite_config.dart';
import 'package:bookie/pages/home_page.dart';
import 'package:bookie/pages/login_page.dart';
import 'package:bookie/pages/signup_page.dart';
import 'package:flutter/material.dart';


Client client = Client();

void main() {
  const String endpoint = String.fromEnvironment('APPWRITE_ENDPOINT');
  const String projectId = String.fromEnvironment('APPWRITE_PROJECT_ID');
  initializeAppwriteClient(client, endpoint, projectId);
  Account account = Account(client);
  runApp(MyApp(account: account));
}

class MyApp extends StatelessWidget {
  final Account account;
  const MyApp({super.key, required this.account});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        primaryColor: Colors.purple,
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: '/login',
      routes: {
        '/': (context) => const HomePage(),
        '/login': (context) => LoginPage(account: account),
        '/signup': (context) => SignUpPage(account: account),
      },
    );
  }
}