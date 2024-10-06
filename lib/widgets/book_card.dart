import 'package:bookie/model/book.dart';
import 'package:bookie/styles/app_text.dart';
import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  final Book book;

  const BookCard({
    super.key,
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Constrain image height to avoid overflow
              SizedBox(
                height: 150, // Fixed height for the image
                child: Image.network(
                  book.coverUrl,
                  width: (MediaQuery.of(context).size.width * 0.3),
                  fit: BoxFit.contain,
                ),
              ),
              // Wrap ListTile with Flexible to fit within available space
              Flexible(
                child: ListTile(
                  title: Text(
                    book.name,
                    style: AppText.subheading2,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  subtitle: Text(
                    book.author,
                    style: AppText.subheading3,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
