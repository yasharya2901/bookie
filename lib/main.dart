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


const FlutterSecureStorage secureStorage = FlutterSecureStorage();

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initializeAppwriteClient();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
      child: const MyApp(secureStorage: secureStorage),
    )
  );
}

class MyApp extends StatelessWidget {
  final FlutterSecureStorage secureStorage;
  const MyApp({super.key, required this.secureStorage});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        primaryColor: Colors.purple,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: InitialPage(secureStorage: secureStorage),
      routes: {
        '/home': (context) => const HomePage(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignUpPage(),
        '/settings': (context) => const UserSettingsPage(),
      },
    );
  }
}

class InitialPage extends StatefulWidget {
  
  final FlutterSecureStorage secureStorage;
  const InitialPage({super.key, required this.secureStorage});

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
    Account? account = appwriteAccount();
    Avatars? avatars = appwriteAvatars();
    String? userId = await widget.secureStorage.read(key: 'user_id');
    if (!mounted) return; // Check if the widget is still mounted

    if (userId != null) {
      try {
        final user = await account?.get();
        if (user == null) {
          throw Exception('Appwrite User not found');
        }
        if (!mounted) return; // Check if the widget is still mounted
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        final initials = await avatars?.getInitials(name: user.name, width: 50, height: 50);
        if (initials == null) {
          throw Exception('Failed to get user initials object');
        }
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