// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:health_care/models/symptom.dart';
import 'package:health_care/widgets/home_page/appointment_list_patient.dart';
import 'package:health_care/widgets/search.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';

class NewAppointment extends StatefulWidget {
  final String id;
  const NewAppointment(this.id, {super.key});

  @override
  State<NewAppointment> createState() => _NewAppointmentState();
}

class _NewAppointmentState extends State<NewAppointment> {
  final TextEditingController _searchController = TextEditingController();

  var _selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Make Appointment',
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
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Search(_searchController),
          ),
          FutureBuilder(
              future: SymptomsProvider.getSymtoms(),
              builder: (ctx, future) {
                if (future.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }

                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  width: double.infinity,
                  child: DropDownTextField(
                    initialValue: future.data![0].name,
                    clearOption: false,
                    dropDownItemCount: 6,
                    dropDownList: future.data!
                        .map(
                          (e) =>
                              DropDownValueModel(name: e.name, value: e.name),
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
                );
              }),
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
