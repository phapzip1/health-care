import "package:flutter/material.dart";

// widgets
import "../widgets/week_day_radio.dart";
import "../widgets/pill_list.dart";
import "../widgets/tabs.dart";

class DrugReminderScreen extends StatelessWidget {
  const DrugReminderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Color(0xFFAEE6FF)),
      child: Padding(
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
                  children: <Widget>[
                    const Text(
                      "Today Drug",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Tabs(
                      children: <Widget>[
                        Image.asset(
                          "assets/images/morning.png",
                          width: 24,
                        ),
                        Image.asset(
                          "assets/images/noon.png",
                          width: 24,
                        ),
                        Image.asset(
                          "assets/images/evening.png",
                          width: 24,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Expanded(child: PillList()),
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
