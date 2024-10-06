import 'package:appwrite/appwrite.dart';
import 'package:bookie/configs/appwrite_config.dart';
import 'package:bookie/configs/global_user_state_manager.dart';
import 'package:bookie/pages/home_page.dart';
import 'package:bookie/pages/login_page.dart';
import 'package:bookie/pages/signup_page.dart';
import 'package:bookie/pages/user_settings_page.dart';
import 'package:bookie/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';


Client client = Client();
const FlutterSecureStorage secureStorage = FlutterSecureStorage();

void main() {
  const String endpoint = String.fromEnvironment('APPWRITE_ENDPOINT');
  const String projectId = String.fromEnvironment('APPWRITE_PROJECT_ID');
  initializeAppwriteClient(client, endpoint, projectId);
  Account account = Account(client);
  Avatars avatars = Avatars(client);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
      child: MyApp(account: account, secureStorage: secureStorage, avatars:avatars),
    )
  );
}

class MyApp extends StatelessWidget {
  final Account account;
  final FlutterSecureStorage secureStorage;
  final Avatars avatars;
  const MyApp({super.key, required this.account, required this.secureStorage, required this.avatars});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        primaryColor: Colors.purple,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: InitialPage(account: account, secureStorage: secureStorage, avatars: avatars),
      routes: {
        '/home': (context) => const HomePage(),
        '/login': (context) => LoginPage(account: account),
        '/signup': (context) => SignUpPage(account: account),
        '/settings': (context) => const UserSettingsPage(),
      },
    );
  }
}

class InitialPage extends StatefulWidget {
  final Account account;
  final Avatars avatars;
  final FlutterSecureStorage secureStorage;
  const InitialPage({super.key, required this.account, required this.secureStorage, required this.avatars});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  @override
  void initState() {
    super.initState();
    _checkAndNavigate();
  }

  Future<void> _checkAndNavigate() async {
    String? userId = await widget.secureStorage.read(key: 'user_id');
    if (!mounted) return; // Check if the widget is still mounted

    if (userId != null) {
      try {
        final user = await widget.account.get();
        if (!mounted) return; // Check if the widget is still mounted
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        final initials = await widget.avatars.getInitials(name: user.name, width: 50, height: 50);
        setUserName(user.name, userProvider);
        setUserVerificationStatus(user.emailVerification, userProvider);
        setUserAvatar(initials, userProvider);

        if (user.$id != userId) {
          await widget.secureStorage.delete(key: 'user_id');
          if (mounted) {
            Navigator.pushReplacementNamed(context, '/login');
          }
        } else {
          if (mounted) {
            Navigator.pushReplacementNamed(context, '/home');
          }
        }
      } catch (e) {
        if (mounted) {
          Navigator.pushReplacementNamed(context, '/login');
        }
      }
    } else {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

} 