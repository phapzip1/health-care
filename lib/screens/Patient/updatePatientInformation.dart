import 'package:flutter/material.dart';

class UpdatePatientInfo extends StatefulWidget {
  const UpdatePatientInfo({super.key});

  @override
  State<UpdatePatientInfo> createState() => _UpdatePatientInfoState();
}

class _UpdatePatientInfoState extends State<UpdatePatientInfo> {
  final circleAvatar = SizedBox(
    child: Container(
      margin: EdgeInsets.only(bottom: 16),
      child: CircleAvatar(
        radius: 56.0,
        backgroundColor: Colors.white,
        child: CircleAvatar(
          child: Align(
            alignment: Alignment.bottomRight,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 16.0,
              child: Icon(
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
        body: Container(
          padding: const EdgeInsets.all(16),

          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            circleAvatar,
            const Text('Name', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            TextField(
              style: const TextStyle(fontSize: 16),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
            ),
            const SizedBox(height: 20,),

            const Text('Phone number', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            TextField(
              style: const TextStyle(fontSize: 16),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
            ),
            const SizedBox(height: 20,),

            const Text('Gender', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            TextField(
              style: const TextStyle(fontSize: 16),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
            ),
            const SizedBox(height: 20,),

            const Text('Birthday', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            TextField(
              style: const TextStyle(fontSize: 16),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
            ),
            const SizedBox(height: 20,),

            const Text('Email', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            TextField(
              style: const TextStyle(fontSize: 16),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
            ),
            const SizedBox(height: 20,),

          ]),
        ));
  }
}
