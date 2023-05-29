import 'package:flutter/material.dart';
import 'package:health_care/models/symptom.dart';
import 'package:health_care/widgets/home_page/appointment_list_patient.dart';
import 'package:health_care/widgets/search.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';

class NewAppointment extends StatefulWidget {
  const NewAppointment({super.key});

  @override
  State<NewAppointment> createState() => _NewAppointmentState();
}

class _NewAppointmentState extends State<NewAppointment> {
  final TextEditingController _searchController = TextEditingController();

  var _selectedValue;

  @override
  void initState() {
    // TODO: implement initState
    _selectedValue = symptoms[0].name;
    super.initState();
  }

  final List<Symptom> symptoms = [
    Symptom('Bone', 'assets/images/bone.png'),
    Symptom('Joint', 'assets/images/joint.png'),
    Symptom('Digest', 'assets/images/stomachache.png'),
    Symptom('Nerve', 'assets/images/brain.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Make Appointment',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Search(_searchController),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            width: double.infinity,
            child: DropDownTextField(
              initialValue: _selectedValue,
              clearOption: false,
              dropDownItemCount: symptoms.length,
              dropDownList: symptoms
                  .map(
                    (e) => DropDownValueModel(name: e.name, value: e.name),
                  )
                  .toList(),
              textFieldDecoration: const InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              ),
              onChanged: (value) {
                _selectedValue = value.name.toString();
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            margin: const EdgeInsets.only(bottom: 4),
            child: AppointmentListPatient(),
          ),
        ],
      ),
    );
  }
}
