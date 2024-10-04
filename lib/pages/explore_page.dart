import 'package:bookie/api/mock_data.dart';
import 'package:bookie/widgets/book_card.dart';
import 'package:bookie/widgets/custom_search_bar.dart';
import 'package:flutter/material.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    MockData.initializeBooks();
    var books = MockData.books;

    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: [
          const CustomSearchBar(), // Search bar at the top
          const SizedBox(height: 10),
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
