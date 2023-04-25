import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/reivew.dart';

class CommendCard extends StatelessWidget {
  final Review review;

  const CommendCard(this.review, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0xFFE0E0E0),
            blurRadius: 1,
            spreadRadius: 1,
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      padding: EdgeInsets.all(12),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 26.0,
                  backgroundImage: AssetImage('assets/images/avatartUser.jpg'),
                ),
                const SizedBox(
                  width: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      review.timePosted.toString(),
                      style: TextStyle(color: Color(0xFF828282)),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                const Icon(
                  FontAwesomeIcons.solidStar,
                  color: Colors.yellowAccent,
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(review.rating.toString())
              ],
            )
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        Text(review.context),
      ]),
    );
  }
}
