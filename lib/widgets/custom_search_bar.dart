import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width,
        minWidth: 100,
        minHeight: 50,
      ),
      hintText: "Search for books",
      onTap: () {},  // TODO: Implement search functionality
    );
  }
}

