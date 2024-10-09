import 'package:bookie/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopBarContent extends StatelessWidget {
  const TopBarContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final userProvider = Provider.of<UserProvider>(context);

    return Row(
      children: [
        // Image Avatar
        InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            Navigator.pushNamed(context, "/settings");
          },
          child: CircleAvatar(
            radius: 20,
              backgroundImage: userProvider.userAvatarBytes != null
                ? MemoryImage(userProvider.userAvatarBytes!)
                : null,
              child: userProvider.userAvatarBytes == null
                ? const Icon(Icons.account_circle, size: 40)
                : null
              ,
          ),
        ),
        const SizedBox(width: 10),
        Text("Hi, ${userProvider.userName}!"),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.notifications),
          onPressed: () {},
        ),
      ],
    );
  }
}