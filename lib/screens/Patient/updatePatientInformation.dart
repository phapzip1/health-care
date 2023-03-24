import 'package:flutter/material.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';

class UpdatePatientInfo extends StatefulWidget {
  const UpdatePatientInfo({super.key});

  @override
  State<UpdatePatientInfo> createState() => _UpdatePatientInfoState();
}

class _UpdatePatientInfoState extends State<UpdatePatientInfo> {
  final circleAvatar = SizedBox(
    child: Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: const CircleAvatar(
        radius: 56.0,
        backgroundColor: Colors.white,
        child: CircleAvatar(
          child: const Align(
            alignment: Alignment.bottomRight,
            child: const CircleAvatar(
              backgroundColor: Colors.white,
              radius: 16.0,
              child: const Icon(
                Icons.camera_alt,
                size: 20.0,
                color: Color(0xFF404040),
              ),
            ),
          ),
          radius: 48.0,
          backgroundImage: AssetImage('assets/images/avatartUser.jpg'),
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
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
          actions: [
            TextButton(
                onPressed: () {},
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
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(children: [
            circleAvatar,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Name',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  style: const TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 20),
                  ),
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
                TextField(
                  style: const TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 20),
                  ),
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

                DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black38, width: 1),
                    borderRadius: BorderRadius.circular(
                        50), 
                  ),
                  child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20, top: 4, bottom: 4),
                      child: DropdownButton(
                        // value: "Male",
                        items: const [
                          DropdownMenuItem(
                            child: Text("Male"),
                            value: "male",
                          ),
                          DropdownMenuItem(
                            child: Text("Female"),
                            value: "female",
                          )
                        ],
                        onChanged: (value) {},

                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),

                        underline: Container(), 
                        isExpanded: true, 
                      )),
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
                TextField(
                  style: const TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 20),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),

                const Text('Email',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  style: const TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 20),
                  ),
                ),
              ],
            ),
          ]),
        ));
  }
}
