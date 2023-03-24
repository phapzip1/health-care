import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:flutter/material.dart';

class UpdateDotorInfo extends StatefulWidget {
  const UpdateDotorInfo({super.key});

  @override
  State<UpdateDotorInfo> createState() => _UpdateDotorInfoState();
}

class _UpdateDotorInfoState extends State<UpdateDotorInfo> {
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
                const SizedBox(
                  height: 20,
                ),

                const Text('Expertise',
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
