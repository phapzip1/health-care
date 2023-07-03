// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:health_care/models/doctor_model.dart';
import 'package:health_care/models/symptom.dart';
import 'package:health_care/services/navigation_service.dart';
import 'package:health_care/widgets/infomation_page/time_choosing.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:health_care/models/patient_model.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: must_be_immutable
class UpdateDoctorInformation extends StatefulWidget {
  DoctorModel doctorInfo;
  UpdateDoctorInformation(this.doctorInfo, {super.key});

  @override
  State<UpdateDoctorInformation> createState() =>
      _UpdateDoctorInformationState();
}

class _UpdateDoctorInformationState extends State<UpdateDoctorInformation> {
  final user = FirebaseAuth.instance.currentUser;
  final _formKey = GlobalKey<FormState>();
  DateTime _selectedDate = DateTime.now();

  final TextEditingController dateinput = TextEditingController();

  late List<Symptom> symptoms;

  void loadDropdown() async {
    final list = await SymptomsProvider.getSymtoms();
    setState(() {
      symptoms.addAll(list);
    });
  }

  // ignore: unused_field
  int _choosingTime = -1;

  void _onChange(index) {
    _choosingTime = index;
  }

  _selectDate(BuildContext context) async {
    final now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: now,
      lastDate: now.add(
        const Duration(days: 7),
      ),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  void initState() {
    symptoms = [];
    loadDropdown();
    _enteredUsername.text = widget.doctorInfo.name;
    _enteredPhone.text = widget.doctorInfo.phoneNumber;
    _enteredGender = widget.doctorInfo.gender;
    _enteredBirthday = widget.doctorInfo.birthdate;
    _enteredLicenseId.text = widget.doctorInfo.licenseId;
    _enteredWorkplace.text = widget.doctorInfo.workplace;
    _enteredExpertise = widget.doctorInfo.specialization;
    _enteredExperience.text = widget.doctorInfo.experience.toString();
    _enteredPrice.text = widget.doctorInfo.price.toString();
    dateinput.text = '';
    super.initState();
  }

  var currentUrl;
  File? _selectedImage;

  final TextEditingController _enteredUsername = TextEditingController();
  final TextEditingController _enteredPhone = TextEditingController();
  final TextEditingController _enteredLicenseId = TextEditingController();
  final TextEditingController _enteredWorkplace = TextEditingController();
  String _enteredExpertise = "";
  final TextEditingController _enteredExperience = TextEditingController();
  final TextEditingController _enteredPrice = TextEditingController();
  // ignore: unused_field
  Gender _enteredGender = Gender.male;
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

  circleAvatar(url) => SizedBox(
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
      );

  void _updateInfor() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      _formKey.currentState?.save();
    }

    if (_selectedImage != null) {
      final ref = FirebaseStorage.instance
          .ref()
          .child('user_image')
          .child('${user!.uid}.jpg');

      await ref.putFile(File(_selectedImage!.path));

      currentUrl = await ref.getDownloadURL();
    }
    await DoctorModel(
            widget.doctorInfo.id,
            _enteredUsername.text,
            _enteredPhone.text,
            _enteredGender,
            _enteredBirthday,
            widget.doctorInfo.email,
            int.parse(_enteredExperience.text),
            int.parse(_enteredPrice.text),
            _enteredWorkplace.text,
            _enteredExpertise,
            _enteredLicenseId.text,
            currentUrl ?? widget.doctorInfo.image)
        .save()
        .then((value) => Fluttertoast.showToast(
              msg: "Update successfully",
              toastLength: Toast.LENGTH_SHORT,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.greenAccent,
              textColor: Colors.black,
              fontSize: 16.0,
            ))
        .catchError((error) => Fluttertoast.showToast(
              msg: "Failed to update user",
              toastLength: Toast.LENGTH_SHORT,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
            ));
    FocusManager.instance.primaryFocus?.unfocus();
  }

  bool _checkChanged() {
    return _enteredUsername.text != widget.doctorInfo.name ||
        _enteredPhone.text != widget.doctorInfo.phoneNumber ||
        _enteredLicenseId.text != widget.doctorInfo.licenseId ||
        _enteredWorkplace.text != widget.doctorInfo.workplace ||
        _enteredExpertise != widget.doctorInfo.specialization ||
        _enteredExperience.text != widget.doctorInfo.experience.toString() ||
        _enteredPrice.text != widget.doctorInfo.price.toString() ||
        _enteredBirthday != widget.doctorInfo.birthdate ||
        _enteredGender != widget.doctorInfo.gender ||
        _selectedImageCheck == true;
  }

  bool _selectedImageCheck = false;

  var changed = 1;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
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
              onPressed: _checkChanged() ? _updateInfor : null,
              child: Text(
                'Save',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: _checkChanged()
                      ? const Color(0xFF3A86FF)
                      : const Color(0xFF3A86FF).withOpacity(0.5),
                ),
              )),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(children: [
              circleAvatar(widget.doctorInfo.image),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('License ID',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: _enteredLicenseId,
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
                  const Text('Name',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.phone,
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
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 8,
                  ),
                  DropDownTextField(
                    controller: SingleValueDropDownController(
                        data: DropDownValueModel(
                            name: _enteredGender.toString().substring(7),
                            value: _enteredGender)),
                    // initialValue: _enteredGender.toString().substring(7),
                    clearOption: false,
                    dropDownItemCount: 3,
                    dropDownList: const [
                      DropDownValueModel(name: 'male', value: Gender.male),
                      DropDownValueModel(name: 'female', value: Gender.female),
                      DropDownValueModel(name: 'other', value: Gender.other),
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
                      _enteredGender = value.value;
                      setState(() {
                        changed += 1;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text('Birthday',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
                  const SizedBox(
                    height: 20,
                  ),
                  const Text('Workplace',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: _enteredWorkplace,
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
                  const Text('Expertise',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 8,
                  ),
                  DropDownTextField(
                    controller: SingleValueDropDownController(
                        data: DropDownValueModel(
                            name: _enteredExpertise, value: _enteredExpertise)),
                    // initialValue: _enteredExpertise,
                    clearOption: false,
                    dropDownItemCount: 6,
                    dropDownList: symptoms
                        .map(
                          (e) =>
                              DropDownValueModel(name: e.name, value: e.name),
                        )
                        .toList(),
                    textFieldDecoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Color(0xFF3A86FF))),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                    ),
                    onChanged: (value) {
                      _enteredExpertise = value.name.toString();
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text('Experience',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _enteredExperience,
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
                  const Text('Price for consulting',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _enteredPrice,
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
                  const Text(
                    'Schedules',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  FutureBuilder(
                      future: widget.doctorInfo.checkTime(),
                      builder: (ctx, futureCheck) {
                        if (futureCheck.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (futureCheck.data!) {
                          return Center(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                              ),
                              onPressed: () {
                                NavigationService.navKey.currentState
                                    ?.pushNamed('/schedule',
                                        arguments: widget.doctorInfo.id);
                              },
                              child: const Text(
                                'Change your time for consultant',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ),
                          );
                        }

                        return Column(
                          children: [
                            OutlinedButton(
                              onPressed: () {
                                _selectDate(context);
                              },
                              style: OutlinedButton.styleFrom(
                                primary: Colors.black,
                                textStyle: const TextStyle(fontSize: 16),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                ),
                              ),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(DateFormat('dd/MM/y')
                                        .format(_selectedDate)),
                                    const Icon(
                                      FontAwesomeIcons.calendar,
                                      color: Colors.black,
                                    ),
                                  ]),
                            ),
                            FutureBuilder(
                                future: widget.doctorInfo.getAvailableTime(
                                  _selectedDate.day,
                                  _selectedDate.month,
                                  _selectedDate.year,
                                ),
                                builder: (ctx, future) {
                                  if (future.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  final time = future.data!;
                                  return time.isEmpty
                                      ? const Text(
                                          'There is no time frame available')
                                      : TimeChoosing(
                                          time,
                                          mediaQuery,
                                          _selectedDate.day,
                                          _selectedDate.month,
                                          _selectedDate.year,
                                          _onChange,
                                          true);
                                }),
                          ],
                        );
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
