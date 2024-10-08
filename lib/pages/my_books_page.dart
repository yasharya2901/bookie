import 'package:bookie/api/mock_data.dart';
import 'package:bookie/widgets/book_card.dart';
import 'package:flutter/material.dart';

class MyBooksPage extends StatefulWidget {
  const MyBooksPage({super.key});

  @override
  State<MyBooksPage> createState() => _MyBooksPageState();
}

class _MyBooksPageState extends State<MyBooksPage> {
  final books = MockData.books;
  void _loadMyBooks() async {
    // Load books from the API
    
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Container(alignment: Alignment.topLeft, padding: const EdgeInsets.only(left: 10), child: const Text("My Books", style: TextStyle(fontSize: 20),),), // Search bar at the top
          const SizedBox(height: 10),
          ElevatedButton(onPressed: _loadMyBooks, child: const Text("Load My Books")),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200, // Maximum width for each book card
                mainAxisSpacing: 10, // Spacing between rows
                crossAxisSpacing: 10, // Spacing between columns
                childAspectRatio: 0.67, // Adjust card aspect ratio
                mainAxisExtent: 280, // Maximum height for each book card
              ),
              itemCount: books.length,
              itemBuilder: (context, index) {
                // Remove the SizedBox and rely on constraints in BookCard
                return BookCard(book: books[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
