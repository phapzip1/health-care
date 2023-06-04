import 'package:flutter/material.dart';

class RecordDetail extends StatefulWidget {
  final String url;
  const RecordDetail(this.url, {super.key});

  @override
  State<RecordDetail> createState() => _RecordDetailState();
}

class _RecordDetailState extends State<RecordDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Records',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: const BackButton(
          color: Colors.black,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 26.0,
                  backgroundImage: NetworkImage(widget.url),
                ),
                const SizedBox(
                  width: 8,
                ),
                const Text(
                  'Do Pham Huy Khanh',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      "assets/images/stethoscope.png",
                      width: 28,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    const Text('Doctor: '),
                  ],
                ),
                const Text('Nguyen Huynh Tuan Khang',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      "assets/images/clock.png",
                      width: 28,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    const Text('Time: '),
                  ],
                ),
                const Text('2023-04-19 08:00AM',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              'Diagnostic: ',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 8,
            ),
            TextFormField(
              readOnly: true,
              initialValue: 'Fat',
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(width: 1, color: Color(0xFF828282)),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(width: 1, color: Color(0xFF828282)),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              'Prescription: ',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 8,
            ),
            TextField(
              readOnly: true,
              controller: TextEditingController(text: '...'),
              keyboardType: TextInputType.multiline,
              maxLines: 7,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(width: 1, color: Color(0xFF828282)),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(width: 1, color: Color(0xFF828282)),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              'Note: ',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 8,
            ),
            TextField(
              readOnly: true,
              controller: TextEditingController(text: '...'),
              keyboardType: TextInputType.multiline,
              maxLines: 6,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(width: 1, color: Color(0xFF828282)),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(width: 1, color: Color(0xFF828282)),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
