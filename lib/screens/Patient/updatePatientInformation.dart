import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:health_care/widgets/update_page/non_rerender_patient.dart';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care/bloc/app_bloc.dart';
import 'package:health_care/bloc/app_event.dart';
import 'package:health_care/bloc/app_state.dart';
import 'package:health_care/models/patient_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';

// ignore: must_be_immutable
class UpdatePatientInfo extends StatefulWidget {
  PatientModel patientInfo;
  UpdatePatientInfo(this.patientInfo, {super.key});

  @override
  State<UpdatePatientInfo> createState() => _UpdatePatientInfoState();
}

class _UpdatePatientInfoState extends State<UpdatePatientInfo> {
  final user = FirebaseAuth.instance.currentUser;
  final _formKey = GlobalKey<FormState>();

  TextEditingController dateinput = TextEditingController();

  @override
  void initState() {
    _enteredUsername.text = widget.patientInfo.name;
    _enteredPhone.text = widget.patientInfo.phoneNumber;
    _enteredGender.text = widget.patientInfo.gender as String;
    _enteredBirthday = widget.patientInfo.birthdate;
    dateinput.text = '';

    super.initState();
  }

  var currentUrl;
  File? _selectedImage;

  final TextEditingController _enteredUsername = TextEditingController();
  final TextEditingController _enteredPhone = TextEditingController();
  final TextEditingController _enteredGender = TextEditingController();
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
                foregroundImage:
                    _selectedImage != null ? FileImage(_selectedImage!) : null,
                backgroundImage: NetworkImage(url),
              ),
            ),
          ),
        ),
      );

  void _updateInfor(BuildContext context) async {
    try {
      final isValid = _formKey.currentState!.validate();

      if (_selectedImage == null) {
        return;
      }

      if (isValid) {
        _formKey.currentState?.save();

        context.read<AppBloc>().add(AppEventUpdatePatientInfomation(
              PatientModel(
                  widget.patientInfo.id,
                  _enteredUsername.text,
                  _enteredPhone.text,
                  int.parse(_enteredGender.text),
                  _enteredBirthday,
                  widget.patientInfo.email,
                  currentUrl ?? widget.patientInfo.image),
            ));
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
    return _enteredUsername.text != widget.patientInfo.name ||
        _enteredPhone.text != widget.patientInfo.phoneNumber ||
        _enteredGender != widget.patientInfo.gender ||
        _enteredBirthday != widget.patientInfo.birthdate ||
        _selectedImageCheck == true;
  }

  var changed = 1;
  bool _selectedImageCheck = false;

  @override
  Widget build(BuildContext context) {
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
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: _checkChanged()
                          ? const Color(0xFF3A86FF)
                          : const Color(0xFF3A86FF).withOpacity(0.5)),
                )),
          ],
        ),
        body: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: BlocBuilder<AppBloc, AppState>(builder: (ctx, state) {
            return Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    circleAvatar(widget.patientInfo.image),
                    const Text('Name',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: _enteredUsername,
                      style: const TextStyle(fontSize: 16),
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Color(0xFF3A86FF))),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 20),
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
                    const Text('Phone number',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: _enteredPhone,
                      style: const TextStyle(fontSize: 16),
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Color(0xFF3A86FF))),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 20),
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
                    const Text('Gender',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 8,
                    ),
                    DropDownTextField(
                      initialValue: state.patient!.gender == 1
                          ? "Male"
                          : state.patient!.gender == 2
                              ? "Female"
                              : "Other",
                      clearOption: false,
                      dropDownItemCount: 3,
                      dropDownList: const [
                        DropDownValueModel(name: 'Male', value: 1),
                        DropDownValueModel(name: 'Female', value: 2),
                        DropDownValueModel(name: 'Other', value: 3),
                      ],
                      textFieldDecoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Color(0xFF3A86FF))),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 20),
                      ),
                      onChanged: (value) {
                        _enteredGender.text = value.value;
                        setState(() {
                          changed += 1;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text('Birthday',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: TextEditingController(
                        text: DateFormat('dd/MM/y').format(_enteredBirthday),
                      ),
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Color(0xFF3A86FF))),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 20),
                      ),
                      readOnly: true,
                      onTap: () async {
                        final DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );

                        if (pickedDate != null &&
                            pickedDate != _enteredBirthday) {
                          setState(() {
                            _enteredBirthday = pickedDate;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          }),
        ));
  }
}
