import 'package:bookie/model/book.dart';
import 'package:bookie/widgets/about_section.dart';
import 'package:bookie/widgets/book_information_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyBookDetails extends StatelessWidget {
  const MyBookDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final Book book = ModalRoute.of(context)?.settings.arguments as Book;

    return Scaffold(
      appBar: AppBar(
        title: Text(book.name),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            BookInformationCard(book: book),
            const SizedBox(
              height: 10,
            ),
            AboutSection(description: book.description),
          ],
        ),
      ),
    );
  }
}

