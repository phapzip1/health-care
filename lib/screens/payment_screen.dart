import "package:flutter/material.dart";


class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const double listtileVerticalPadding = 4.5;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 24,
          ),
          child: Stack(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      FloatingActionButton(
                        onPressed: () {},
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                        elevation: 1,
                        child: const Icon(Icons.arrow_back, color: Colors.black),
                      ),
                      const SizedBox(width: 22),
                      const Text(
                        "Confirm Appointment",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const ListTile(
                      contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                      leading: CircleAvatar(
                        radius: 22,
                        backgroundColor: Colors.amber,
                      ),
                      title: Text(
                        "Person visiting",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey),
                      ),
                      subtitle: Text(
                        "Do Khanh",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(vertical: listtileVerticalPadding, horizontal: 10),
                          leading: Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Image.asset(
                              "assets/images/stethoscope.png",
                              width: 32,
                            ),
                          ),
                          title: const Text(
                            "Doctor",
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey),
                          ),
                          subtitle: const Text(
                            "Dr Nguyen Huynh Tuan Khang",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                        ),
                        const Divider(
                          thickness: 1,
                          height: 1,
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(vertical: listtileVerticalPadding, horizontal: 10),
                          leading: Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Image.asset(
                              "assets/images/onlinemeeting.png",
                              width: 32,
                            ),
                          ),
                          title: const Text(
                            "Way to consult",
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey),
                          ),
                          subtitle: const Text(
                            "Video call",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                        ),
                        const Divider(
                          thickness: 1,
                          height: 1,
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(vertical: listtileVerticalPadding, horizontal: 10),
                          leading: Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Image.asset(
                              "assets/images/firstaidbox.png",
                              width: 32,
                            ),
                          ),
                          title: const Text(
                            "Cost",
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey),
                          ),
                          subtitle: const Text(
                            "100000VND",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                        ),
                        const Divider(
                          thickness: 1,
                          height: 1,
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(vertical: listtileVerticalPadding, horizontal: 10),
                          leading: Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Image.asset(
                              "assets/images/clock.png",
                              width: 32,
                            ),
                          ),
                          title: const Text(
                            "Time",
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey),
                          ),
                          subtitle: const Text(
                            "2023-12-11 08:00AM",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 0,
                left: 20,
                right: 20,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Padding(
                    padding: EdgeInsetsDirectional.symmetric(vertical: 5),
                    child: Text(
                      "Continue",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
