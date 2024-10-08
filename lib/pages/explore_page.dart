import 'package:bookie/api/mock_data.dart';
import 'package:bookie/providers/user_provider.dart';
import 'package:bookie/widgets/book_card.dart';
import 'package:bookie/widgets/custom_search_bar.dart';
import 'package:bookie/widgets/user_verification_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    MockData();
    var books = MockData.books;

    final userProvider = Provider.of<UserProvider>(context);

    // Check if the user is not verified and show a SnackBar
    showVerificationSnackBar(context, userProvider.userVerified);


    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: [
          const SizedBox(height: 10),
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
