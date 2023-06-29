import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_care/models/health_record_model.dart';
import 'package:intl/intl.dart';

class RecordDetail extends StatefulWidget {
  final HealthRecordModel record;
  final bool isDoctor;
  const RecordDetail(this.record, this.isDoctor, {super.key});

  @override
  State<RecordDetail> createState() => _RecordDetailState();
}

class _RecordDetailState extends State<RecordDetail> {
  final userID = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    final _time = DateFormat('dd-MM-y').format(widget.record.time);
    final _hour = DateFormat.Hm().format(widget.record.time);

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
                  backgroundImage: NetworkImage(widget.isDoctor
                      ? widget.record.patientImage
                      : widget.record.doctorImage),
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  widget.isDoctor
                      ? widget.record.patientName
                      : widget.record.doctorName,
                  style: const TextStyle(fontWeight: FontWeight.bold),
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
                Text(widget.record.doctorName,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
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
                Text('${_time} ${_hour}',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
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
              readOnly: widget.isDoctor ? false : true,
              initialValue: widget.record.diagnostic,
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
              readOnly: widget.isDoctor ? false : true,
              controller:
                  TextEditingController(text: widget.record.prescription),
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
              readOnly: widget.isDoctor ? false : true,
              controller: TextEditingController(text: widget.record.note),
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
            widget.isDoctor
                ? Column(
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF2F80ED),
                                elevation: 0,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12)),
                            onPressed: () {},
                            child: const Text(
                              'Save',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            )),
                      ),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
