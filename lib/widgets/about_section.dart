import 'package:flutter/material.dart';

class AboutSection extends StatefulWidget {
  final String? description;

  const AboutSection({super.key, this.description});

  @override
  AboutSectionState createState() => AboutSectionState();
}

class AboutSectionState extends State<AboutSection> {
  bool isExpanded = false; // To track the current state of expansion

  @override
  Widget build(BuildContext context) {
    final String textToDisplay = widget.description ?? 'No description available';

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'About This Book',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(height: 10),
          LayoutBuilder(
            builder: (context, constraints) {
              final textSpan = TextSpan(
                text: textToDisplay,
                style: const TextStyle(fontSize: 14),
              );
              final textPainter = TextPainter(
                text: textSpan,
                maxLines: isExpanded ? null : 6,
                textDirection: TextDirection.ltr,
              );
              textPainter.layout(maxWidth: constraints.maxWidth);

              final isTextOverflowing = textPainter.didExceedMaxLines;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    textToDisplay,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.justify,
                    softWrap: true,
                    overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                    maxLines: isExpanded ? null : 6,
                  ),
                  if (isTextOverflowing || isExpanded) // Ensure "Read Less" shows when expanded
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isExpanded = !isExpanded; // Toggle the state
                        });
                      },
                      child: Text(
                        isExpanded ? 'Read Less' : 'Read More',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
