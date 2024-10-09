import 'package:appwrite/models.dart';
import 'package:bookie/api/fetch_book.dart';
import 'package:bookie/configs/appwrite_config.dart';
import 'package:bookie/model/book.dart';
import 'package:bookie/widgets/book_card.dart';
import 'package:flutter/material.dart';

class MyBooksPage extends StatefulWidget {
  const MyBooksPage({super.key});

  @override
  State<MyBooksPage> createState() => _MyBooksPageState();
}

class _MyBooksPageState extends State<MyBooksPage> {

  @override
  Widget build(BuildContext context) {
    User? user = appwriteUser();
    if (user == null) {
      return const Center(child: Text("User not found"));
    }
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Container(alignment: Alignment.topLeft, padding: const EdgeInsets.only(left: 10), child: const Text("My Books", style: TextStyle(fontSize: 20),),), // Search bar at the top
          const SizedBox(height: 10),
          FutureBuilder(
            future: fetchUserBooks(user.$id), 
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return const Text('none');
                case ConnectionState.waiting:
                case ConnectionState.active:
                  return const Center(child: CircularProgressIndicator());
                case ConnectionState.done:
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  if (snapshot.hasData) {
                    List<Book> books = snapshot.data;
                    return Expanded(
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
                          return BookCard(book: books[index]);
                        },
                      ),
                    );
                  } else {
                    return const Text("No books found");
                  }
                default:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
              }
            }
          )
        ],
      ),
    );
  }
}
