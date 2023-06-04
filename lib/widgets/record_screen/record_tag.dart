import 'package:flutter/material.dart';
import 'package:health_care/widgets/record_screen/record_detail.dart';

class RecordTag extends StatelessWidget {
  final String name;
  final String time;
  final String id_record;
  final String url;
  // final Widget page;
  const RecordTag(this.id_record, this.name, this.time, this.url, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => RecordDetail(url)));
      },
      child: Container(
        margin: const EdgeInsets.only(top: 16),
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color(0xFFC9C9C9),
              blurRadius: 1,
              spreadRadius: 1,
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        padding: const EdgeInsets.all(16),
        child: IntrinsicHeight(
          child: Row(children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image(
                image: NetworkImage(url),
                height: 80,
                width: 64,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('Time: ${time}'),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
