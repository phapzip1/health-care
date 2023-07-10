// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care/bloc/app_bloc.dart';
import 'package:health_care/bloc/app_event.dart';
import 'package:health_care/bloc/app_state.dart';
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
  String _selectedValue = "All";

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
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      body: BlocBuilder<AppBloc, AppState>(builder: (context, state) {
        final listSymptom = state.symptom!;
        return GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Search(_searchController),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                width: double.infinity,
                child: DropDownTextField(
                  controller: SingleValueDropDownController(
                      data: DropDownValueModel(
                          name: _selectedValue, value: _selectedValue)),
                  clearOption: false,
                  dropDownItemCount: 6,
                  dropDownList: listSymptom
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

                    _selectedValue == "All"
                        ? context
                            .read<AppBloc>()
                            .add(const AppEventLoadDoctors(null))
                        : context
                            .read<AppBloc>()
                            .add(AppEventLoadDoctors(_selectedValue));
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                margin: const EdgeInsets.only(bottom: 4),
                child: AppointmentListPatient(
                  spec: _selectedValue,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
