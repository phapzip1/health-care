import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care/bloc/app_bloc.dart';
import 'package:health_care/bloc/app_event.dart';
import 'package:health_care/models/appointment_model.dart';
import 'package:health_care/models/health_record_model.dart';
import 'package:health_care/screens/Doctor/doctor_home_screen.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';

class WriteRecord extends StatefulWidget {
  final AppointmentModel record;
  const WriteRecord(this.record, {super.key});

  @override
  State<WriteRecord> createState() => _RecordDetailState();
}

class _RecordDetailState extends State<WriteRecord> {
  TextEditingController diagnosticController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController prescriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    diagnosticController.dispose();
    noteController.dispose();
    prescriptionController.dispose();
    super.dispose();
  }

  void _writeRecord(BuildContext context) async {
    _formKey.currentState?.save();
    if (diagnosticController.text != "") {

      context.read<AppBloc>().add(AppEventUpdateHealthRecord(
          HealthRecordModel(diagnosticController.text,
              prescriptionController.text, noteController.text),
          widget.record.id));

      await Future.delayed(const Duration(seconds: 1)).then(
        (value) => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                    value: BlocProvider.of<AppBloc>(context),
                    child: const DoctorHomeScreen(),
                  )),
        ),
      );
    } else {
      Fluttertoast.showToast(
        msg: "You must fill diagnostic for patient",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final meeting = widget.record.datetime;

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
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Container(
          padding:
              const EdgeInsets.only(bottom: 4, top: 16, left: 16, right: 16),
          child: Form(
            key: _formKey,
            child: Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 26.0,
                          backgroundImage:
                              NetworkImage(widget.record.patientImage),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          widget.record.patientName,
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
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
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
                        Text('${DateFormat.yMd().add_Hm().format(meeting)}',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
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
                      controller: diagnosticController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 1, color: Color(0xFF828282)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 1, color: Color(0xFF828282)),
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
                      controller: prescriptionController,
                      keyboardType: TextInputType.multiline,
                      maxLines: 7,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 1, color: Color(0xFF828282)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 1, color: Color(0xFF828282)),
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
                      controller: noteController,
                      keyboardType: TextInputType.multiline,
                      maxLines: 6,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 1, color: Color(0xFF828282)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 1, color: Color(0xFF828282)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF2F80ED),
                                elevation: 0,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12)),
                            onPressed: () {
                              _writeRecord(context);
                            },
                            child: const Text(
                              'Save',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
