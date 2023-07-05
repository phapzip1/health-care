// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care/bloc/app_bloc.dart';
import 'package:health_care/bloc/app_event.dart';
import 'package:health_care/bloc/app_state.dart';
import 'package:health_care/models/doctor_model.dart';
import 'package:health_care/services/navigation_service.dart';
import 'package:health_care/widgets/avatar_picker.dart';
import 'package:health_care/widgets/date_picker_textfield.dart';
import 'dart:io';

class UpdateDoctorInformation extends StatefulWidget {
  const UpdateDoctorInformation( {super.key});

  @override
  State<UpdateDoctorInformation> createState() => _UpdateDoctorInformationState();
}

class _UpdateDoctorInformationState extends State<UpdateDoctorInformation> {
  final user = FirebaseAuth.instance.currentUser;
  final _formKey = GlobalKey<FormState>();

  File? _avatar;
  String _username = "";
  String _phone = "";
  int _gender = 0;
  String _workplace = "";
  int _experience = 0;
  double _price = 0;
  DateTime? _birthdate;

  void _updateInfor(BuildContext context) async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      _formKey.currentState?.save();
      context.read<AppBloc>().add(
            AppEventUpdateDoctorInfomation(
              _avatar,
              _username,
              _phone,
              _gender,
              _workplace,
              _experience,
              _price,
              _birthdate!,
            ),
          );
    }

    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          'Profile editing',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        actions: [
          TextButton(
              onPressed: () => _updateInfor(context),
              child: const Text(
                'Save',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Color(0xFF3A86FF),
                ),
              )),
        ],
      ),
      body: BlocBuilder<AppBloc, AppState>(builder: (context, state) {
        _birthdate = state.doctor!.birthdate;
        return GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(children: [
                AvatarPicker(
                  onPicked: (value) {
                    _avatar = value;
                  },
                  defaultImageUrl: state.doctor!.image,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('License ID', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      style: const TextStyle(fontSize: 16),
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFF3A86FF))),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                      ),
                      readOnly: true,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text('Name', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      initialValue: state.doctor!.name,
                      style: const TextStyle(fontSize: 16),
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFF3A86FF))),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Name cannot be empty";
                        }
                        if (value.length <= 6) {
                          return "Name must be greater than 6 chars";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _username = value!;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text('Phone number', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      style: const TextStyle(fontSize: 16),
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFF3A86FF))),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Name cannot be empty";
                        }
                        if (value.length >= 8) {
                          return "Phone number must be greater than 8 chars";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _phone = value!;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text('Gender', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 8,
                    ),
                    DropDownTextField(
                      clearOption: false,
                      dropDownItemCount: 3,
                      dropDownList: const [
                        DropDownValueModel(name: 'Male', value: 0),
                        DropDownValueModel(name: 'Female', value: 1),
                        DropDownValueModel(name: 'Other', value: 2),
                      ],
                      textFieldDecoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFF3A86FF))),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                      ),
                      onChanged: (value) {
                        _gender = int.parse((value as DropDownValueModel).value);
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text('Birthday', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 8,
                    ),
                    DatePickerTextField(
                      onChange: (value) {
                        _birthdate = value;
                      },
                      initialDate: state.doctor!.birthdate,
                      firstDate: DateTime(1970),
                      lastDate: now,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text('Workplace', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      style: const TextStyle(fontSize: 16),
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFF3A86FF))),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Work place cannot be empty";
                        }
                        if (value.length <= 6) {
                          return "Work place must be greater than 6 chars";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _workplace = value!;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text('Expertise', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 8,
                    ),
                    // DropDownTextField(
                    //   clearOption: false,
                    //   dropDownItemCount: 6,
                    //   dropDownList: state.symptom!
                    //       .map(
                    //         (e) => DropDownValueModel(name: e.name, value: e.name),
                    //       )
                    //       .toList(),
                    //   textFieldDecoration: InputDecoration(
                    //     focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFF3A86FF))),
                    //     border: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(10),
                    //     ),
                    //     contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    //   ),
                    //   onChanged: (value) {
                    //     _expertise = (value as DropDownValueModel).value;
                    //   },
                    // ),
                    TextFormField(
                      style: const TextStyle(fontSize: 16),
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFF3A86FF))),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                      ),
                      readOnly: true,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text('Experience', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      style: const TextStyle(fontSize: 16),
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFF3A86FF))),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Experience cannot be empty";
                        }
                        final exp = int.tryParse(value);
                        if (exp == null || exp < 0) {
                          return "Experience must be a valid positive number";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _experience = int.parse(value!);
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text('Price for consulting', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      style: const TextStyle(fontSize: 16),
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFF3A86FF))),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Price cannot be empty";
                        }
                        final exp = double.tryParse(value);
                        if (exp == null || exp < 0) {
                          return "Price must be a valid positive number";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _price = double.parse(value!);
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Schedules',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      onPressed: () {
                        NavigationService.navKey.currentState?.pushNamed('/schedule', arguments: state.doctor!.id);
                      },
                      child: const Text(
                        'Change your time for consultant',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ]),
            ),
          ),
        );
      }),
    );
  }
}
