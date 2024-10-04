import 'package:flutter/material.dart';

class TopBarContent extends StatelessWidget {
  const TopBarContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Image Avatar
        const CircleAvatar(
          radius: 20,
          backgroundImage: NetworkImage('https://via.placeholder.com/50'),
        ),
        const SizedBox(width: 10),
        const Text("Hi, Yash!"),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.notifications),
          onPressed: () {},
        ),
      ],
    );
  }
}