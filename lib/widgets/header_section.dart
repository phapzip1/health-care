import 'package:flutter/material.dart';

class HeaderSection extends StatelessWidget {
  final String url;
  final String userName;

  const HeaderSection({super.key, required this.url,required this.userName});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 32.0,
          backgroundImage: AssetImage(url),
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
      ],
    );
  }
}
