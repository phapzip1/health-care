import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
          context: context,
          builder: (ctx) => Container(
                child: const Center(
                  child: Text("Cac"),
                ),
                decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0))),
              ));
    });
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Image.asset(
                "assets/images/loginwallpaper.webp",
                width: 20,
                height: 20,
                repeat: ImageRepeat.repeat,
              ),
            ),
            Positioned.fill(
              child: Container(
                child: const Text("Cac"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
