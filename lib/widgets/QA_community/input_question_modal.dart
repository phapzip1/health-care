// ignore_for_file: prefer_final_fields

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care/bloc/app_bloc.dart';
import 'package:health_care/bloc/app_event.dart';
import 'package:health_care/bloc/app_state.dart';
// import 'package:health_care/screens/general/communityQA.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_care/screens/general/communityQA.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
// import 'package:fluttertoast/fluttertoast.dart';

class InputQuestionModal extends StatefulWidget {
  const InputQuestionModal({super.key});

  @override
  State<InputQuestionModal> createState() => _InputQuestionModalState();
}

class _InputQuestionModalState extends State<InputQuestionModal> {
  final _textController = TextEditingController();
  final userId = FirebaseAuth.instance.currentUser!;
  int _gender = 0;

  var _selectedValue = "All";
  final List<bool> _isSelected = [true, false, false];
  double _value = 20;
  File? _pickImageFile;
  bool _light = false;
  bool _isLoading = false;

  List<File> _fileImage = [];

  void _submitData(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    context.read<AppBloc>().add(AppEventCreatePost(_fileImage, userId.uid,
        _selectedValue, _value.round(), _gender, _textController.text, _light));

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: BlocProvider.of<AppBloc>(context),
          child: const CommunityQA(),
        ),
      ),
    );
  }

  void _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final option = await showDialog<int>(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: const Text("Source"),
        children: <Widget>[
          SimpleDialogOption(
            onPressed: () => Navigator.pop(ctx, 1),
            child: const Text("Camera"),
          ),
          const SizedBox(
            height: 20,
          ),
          SimpleDialogOption(
            onPressed: () => Navigator.pop(ctx, 2),
            child: const Text("Gallery"),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );

    if (option == null) {
      return;
    }
    final XFile? image = await picker.pickImage(
        source: option == 1 ? ImageSource.camera : ImageSource.gallery);

    if (image != null) {
      setState(() {
        _pickImageFile = File(image.path);
        _fileImage.add(_pickImageFile!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text(
          'Enter Question',
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
          color: Colors.black,
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Gender'),
                      const SizedBox(
                        height: 8,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: ToggleButtons(
                          isSelected: _isSelected,
                          selectedColor: Colors.white,
                          fillColor: const Color(0xFF3A86FF),
                          textStyle:
                              const TextStyle(fontWeight: FontWeight.bold),
                          renderBorder: true,
                          borderWidth: 1.5,
                          borderRadius: BorderRadius.circular(30),
                          children: const [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 16),
                              child: Text('Men'),
                            ),
                            Padding(
                              padding: EdgeInsets.all(16),
                              child: Text('Women'),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 16),
                              child: Text('Other'),
                            ),
                          ],
                          onPressed: (int newIndex) {
                            setState(() {
                              for (int index = 0;
                                  index < _isSelected.length;
                                  index++) {
                                if (index == newIndex) {
                                  _isSelected[index] = true;
                                } else {
                                  _isSelected[index] = false;
                                }
                              }
                              _gender = newIndex + 1;
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Text('Age'),
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          trackHeight: 10.0,
                          trackShape: const RoundedRectSliderTrackShape(),
                          activeTrackColor: const Color(0xFF3A86FF),
                          thumbShape: const RoundSliderThumbShape(
                            enabledThumbRadius: 14.0,
                            pressedElevation: 8.0,
                          ),
                          overlayColor:
                              const Color(0xFF3A86FF).withOpacity(0.2),
                          overlayShape: const RoundSliderOverlayShape(
                              overlayRadius: 32.0),
                          tickMarkShape: const RoundSliderTickMarkShape(),
                          activeTickMarkColor: const Color(0xFFAEE6FF),
                          inactiveTickMarkColor: Colors.white,
                          valueIndicatorShape:
                              const PaddleSliderValueIndicatorShape(),
                          valueIndicatorColor: const Color(0xFFAEE6FF),
                          valueIndicatorTextStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                          ),
                        ),
                        child: Slider(
                          min: 0.0,
                          max: 100.0,
                          value: _value,
                          divisions: 90,
                          label: '${_value.round()}',
                          onChanged: (value) {
                            setState(() {
                              _value = value;
                            });
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          '${_value.round()} years old',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Text('Please choose a field'),
                      const SizedBox(
                        height: 8,
                      ),
                      BlocBuilder<AppBloc, AppState>(
                        builder: (context, state) {
                          final symptoms = state.symptom!;

                          return DropDownTextField(
                            controller: SingleValueDropDownController(
                                data: DropDownValueModel(
                                    name: _selectedValue,
                                    value: _selectedValue)),
                            clearOption: false,
                            dropDownItemCount: 6,
                            dropDownList: symptoms
                                .map(
                                  (e) => DropDownValueModel(
                                      name: e.name, value: e.name),
                                )
                                .toList(),
                            textFieldDecoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Color(0xFF3A86FF))),
                            ),
                            onChanged: (value) {
                              _selectedValue = value.name.toString();
                            },
                            enableSearch: true,
                          );
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextField(
                        controller: _textController,
                        keyboardType: TextInputType.multiline,
                        maxLines: 7,
                        decoration: InputDecoration(
                          hintText:
                              'Write your question:\n- What symptoms did you have, how long did it last?\n- Did you go to the doctor or take any medicine?\n- send photos (if any)',
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
                      SizedBox(
                        height: 80,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (context, index) => const SizedBox(
                            width: 8,
                          ),
                          itemCount: _fileImage.length,
                          itemBuilder: (context, index) => ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Stack(
                              children: [
                                Image(
                                  image: FileImage(_fileImage[index]),
                                  height: 80,
                                  width: 80,
                                  fit: BoxFit.cover,
                                ),
                                Positioned(
                                    top: -8,
                                    right: -8,
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _fileImage
                                                .remove(_fileImage[index]);
                                          });
                                        },
                                        icon: const Icon(
                                          FontAwesomeIcons.x,
                                          color: Colors.red,
                                          size: 16,
                                        ))),
                              ],
                            ),
                          ),
                        ),
                      ),
                      _fileImage.isNotEmpty
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Only doctor can view'),
                                Switch(
                                  value: _light,
                                  activeColor: const Color(0xFF3A86FF),
                                  onChanged: (bool value) {
                                    setState(() {
                                      _light = value;
                                    });
                                  },
                                )
                              ],
                            )
                          : Container()
                    ],
                  ),
                ),
              ),
            ),
            IntrinsicHeight(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFC9C9C9),
                      blurRadius: 1,
                      spreadRadius: 1,
                    ),
                  ],
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                        onPressed: _pickImage,
                        icon: const Icon(FontAwesomeIcons.image),
                        label: const Text(
                          'Upload image',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        )),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _textController.text.isNotEmpty
                              ? const Color(0xFF3A86FF)
                              : const Color(0xFF3A86FF).withOpacity(0.5),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                        ),
                        onPressed: _textController.text.isNotEmpty
                            ? () => _submitData(context)
                            : null,
                        child: _isLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : const Row(
                                children: [
                                  Text(
                                    'Send',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Icon(Icons.send)
                                ],
                              )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
