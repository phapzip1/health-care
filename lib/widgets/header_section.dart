import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HeaderSection extends StatelessWidget {
  final String url;
  final String userName;

  const HeaderSection({super.key, required this.url,required this.userName});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 28.0,
          backgroundImage: NetworkImage(url),
        ),
        const SizedBox(
          width: 16,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Good Morning,',
              style: TextStyle(
                color: Color(0xFF828282),
                fontSize: 16,
              ),
            ),
            Text(
              userName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
        Flexible(
          fit: FlexFit.loose,
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              isExpanded: true,
                icon: const Icon(
                  Icons.more_vert,
                ),
                items: [
                  DropdownMenuItem(
                    child: Container(
                      child: Row(
                        children: [
                          const Icon(Icons.exit_to_app),
                          const Text('Logout'),
                        ],
                      ),
                    ),
                    value: 'logout',
                  )
                ],
                onChanged: (itemIdentifier) async {
                  if (itemIdentifier == 'logout') {
                    await FirebaseAuth.instance.signOut();
                  }
                },
              ),
          ),
        ),
      ],
    );
  }
}
