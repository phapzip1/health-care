import 'package:flutter/material.dart';

class RecordTag extends StatelessWidget {
  final String name;
  final String time;
  final String id_record;
  final String url;
  final Widget page;
  const RecordTag(this.id_record, this.name, this.time, this.url,this.page, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Row(children: [
        Image(image: NetworkImage(url)),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          Text(name, style: const TextStyle(fontWeight: FontWeight.bold),),
          Text(time),
        ],),
      ]),
    );
  }
}
