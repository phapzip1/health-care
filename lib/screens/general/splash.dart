import 'package:flutter/material.dart';

import 'package:health_care/services/navigation_service.dart';
import 'package:animate_do/animate_do.dart';

// ignore: must_be_immutable
class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _navigateHome();
  }

  void _navigateHome() async {
    await Future.delayed(const Duration(milliseconds: 3000), () {
      NavigationService.navKey.currentState?.pushNamed('/');
    });
  }

  @override
  Widget build(BuildContext context) {
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Center(
                        child: IntrinsicHeight(
                          child: IntrinsicWidth(
                            child: FadeInUp(
                              duration: const Duration(milliseconds: 2000),
                              child: Container(
                                decoration: const BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0xFFBDBDBD),
                                      blurRadius: 10.0,
                                    ),
                                  ],
                                ),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                            "assets/images/logo_app.png",
                                            width: 32,
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          const Text(
                                            'Health meeting',
                                            style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      const Text(
                                        'Your health is our care',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ]),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        //
                      ),
                    ),
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