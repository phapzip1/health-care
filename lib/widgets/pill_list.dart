import "package:flutter/material.dart";

class PillList extends StatelessWidget {
  const PillList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Image.asset(
                      "assets/images/pill_colored.png",
                      width: 50,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const <Widget>[
                        Text(
                          "Paracetamol",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "1 Pill",
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Total 3 days",
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "After breakfast",
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Image.asset(
                          "assets/images/morning.png",
                          width: 24,
                        ),
                        const Text(
                          "08:00 AM",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Image.asset(
                          "assets/images/noon.png",
                          width: 24,
                        ),
                        const Text(
                          "11:00 AM",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Image.asset(
                          "assets/images/evening.png",
                          width: 24,
                        ),
                        const Text(
                          "08:00 PM",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      itemCount: 4,
    );
  }
}
