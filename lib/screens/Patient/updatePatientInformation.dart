import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care/bloc/app_bloc.dart';
import 'package:health_care/bloc/app_event.dart';
import 'package:health_care/models/patient_model.dart';
import 'package:health_care/widgets/date_picker_textfield.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';

// ignore: must_be_immutable
class UpdatePatientInfo extends StatefulWidget {
  const UpdatePatientInfo({super.key, required this.patient});
  final PatientModel patient;

  @override
  State<UpdatePatientInfo> createState() => _UpdatePatientInfoState();
}

class _UpdatePatientInfoState extends State<UpdatePatientInfo> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _enteredUsername.text = widget.patient.name;
    _enteredPhone.text = widget.patient.phoneNumber;
    _enteredGender = widget.patient.gender;
    _enteredBirthday = widget.patient.birthdate;
  }

  File? _selectedImage;

  final TextEditingController _enteredUsername = TextEditingController();
  final TextEditingController _enteredPhone = TextEditingController();
  int _enteredGender = 0;
  final TextEditingController dateinput = TextEditingController();
  DateTime _enteredBirthday = DateTime.now();

  void _pickImage() async {
    final pickImage = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );

    if (pickImage == null) return;
    setState(() {
      _selectedImage = File(pickImage.path);
      _selectedImageCheck = true;
    });
  }

  circleAvatar(url) => Center(
        child: SizedBox(
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: CircleAvatar(
              radius: 56.0,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                // ignore: sort_child_properties_last
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 16.0,
                      child: IconButton(
                        onPressed: _pickImage,
                        icon: const Icon(
                          Icons.camera_alt,
                          size: 20.0,
                          color: Color(0xFF404040),
                        ),
                      )),
                ),
                radius: 48.0,
                foregroundImage: _selectedImage != null ? FileImage(_selectedImage!) : null,
                backgroundImage: NetworkImage(url),
              ),
            ),
          ),
        ),
      );

  void _updateInfor(BuildContext context1) async {
    try {
      final isValid = _formKey.currentState!.validate();

      if (isValid) {
        _formKey.currentState?.save();

        context1.read<AppBloc>().add(AppEventUpdatePatientInfomation(_enteredUsername.text, _enteredPhone.text, _enteredGender, _enteredBirthday, _selectedImage));
        Fluttertoast.showToast(
          msg: "Update successfully",
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.greenAccent,
          textColor: Colors.black,
        );
      }

      FocusManager.instance.primaryFocus?.unfocus();
    } catch (e) {
      print(e);
    }
  }

  bool _checkChanged() {

    return _enteredUsername.text != widget.patient.name ||
        _enteredPhone.text != widget.patient.phoneNumber ||
        _enteredGender != widget.patient.gender ||
        _enteredBirthday != widget.patient.birthdate ||
        _selectedImageCheck == true;
  }

  var changed = 1;
  bool _selectedImageCheck = false;

  @override
  Widget build(BuildContext context) {
    var gender = "Male";
    if (_enteredGender == 2) {
      gender = "Female";
    }
    if (_enteredGender == 3) {
      gender = "Other";
    }
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
                onPressed: _checkChanged() ? () => _updateInfor(context) : null,
                child: Text(
                  'Save',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: _checkChanged() ? const Color(0xFF3A86FF) : const Color(0xFF3A86FF).withOpacity(0.5)),
                )),
          ],
        ),
        body: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  circleAvatar(widget.patient.image),
                  const Text('Name', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: _enteredUsername,
                    style: const TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFF3A86FF))),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                    ),
                    onChanged: (value) {
                      setState(() {
                        changed += 1;
                      });
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
                    controller: _enteredPhone,
                    style: const TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFF3A86FF))),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                    ),
                    onChanged: (value) {
                      setState(() {
                        changed += 1;
                      });
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
                    initialValue: gender,
                    clearOption: false,
                    dropDownItemCount: 3,
                    dropDownList: const [
                      DropDownValueModel(name: 'Male', value: 1),
                      DropDownValueModel(name: 'Female', value: 2),
                      DropDownValueModel(name: 'Other', value: 3),
                    ],
                    textFieldDecoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFF3A86FF))),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                    ),
                    onChanged: (value) {
                      _enteredGender = value.value;
                      setState(() {
                        changed += 1;
                      });
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
                    onChange: (date) {
                      _enteredBirthday = date;
                    },
                    initialDate: widget.patient.birthdate,
                    firstDate: DateTime(1970, 1, 1),
                    lastDate: DateTime.now(),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
