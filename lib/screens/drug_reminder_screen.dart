import "package:flutter/material.dart";

// widgets
import "../widgets/week_day_radio.dart";
import "../widgets/pill_list.dart";

class DrugReminderScreen extends StatelessWidget {
  const DrugReminderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFAEE6FF),
      body: Padding(
        padding: const EdgeInsets.only(top: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const Text(
                    "Your Drug cabinet",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  WeekdayRadio(),
                  const SizedBox(
                    height: 32,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                  color: Colors.white,
                ),
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: const <Widget>[
                    Text(
                      "Today Drug",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Expanded(child: PillList()),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
