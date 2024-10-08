import 'package:bookie/pages/explore_page.dart';
import 'package:bookie/pages/my_books_page.dart';
import 'package:bookie/pages/my_chats_page.dart';
import 'package:bookie/widgets/top_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _bottomAppBarItems = const <Widget>[
    NavigationDestination(icon: Icon(Icons.search), label: "Explore"),
    NavigationDestination(icon: Icon(Icons.book), label: "My Books"),
    NavigationDestination(icon: Icon(Icons.chat), label: "My Chats"),
  ];

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = <Widget>[const ExplorePage(), const MyBooksPage(), const MyChatPage()];
    return Scaffold(
      appBar: AppBar(
        title: const TopBarContent(),
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedIndex: _selectedIndex,
        destinations: _bottomAppBarItems,
      ),
      body: pages[_selectedIndex],
    );
  }
}