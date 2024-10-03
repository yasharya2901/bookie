import 'package:bookie/widgets/custom_search_bar.dart';
import 'package:flutter/material.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
      child: const Column(
        children: [
          CustomSearchBar(),
          
        ],
      ),
    );
  }
}

