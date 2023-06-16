import 'package:flutter/material.dart';

// model
import '../models/doctor_model.dart';

const week = ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"];
const map = {
  "0.0": "00",
  "0.5": "30",
};

class DoctorScheduleScreen extends StatefulWidget {
  final String doctorId;
  const DoctorScheduleScreen(
    this.doctorId, {
    super.key,
  });

  @override
  State<DoctorScheduleScreen> createState() => _DoctorScheduleScreenState();
}

class _DoctorScheduleScreenState extends State<DoctorScheduleScreen> {
  List<int> def = [0, 0, 0];

  int _weekday = 0;

  // ignore: unused_field
  bool _changed = false;

  void _getData(int weekday) async {
    // Todo: fetch data from firebase
    final data =
        await (await DoctorModel.getById(widget.doctorId)).getSchedule(weekday);
    setState(() {
      checkedTime = def = data as List<int>;
    });
  }

  @override
  void initState() {
    super.initState();
    _getData(_weekday);
  }

  void _save() async {
    final data = await DoctorModel.getById(widget.doctorId);
    def = [...checkedTime];
    setState(() {
      _changed = false;
    });

    await data.applySchedule(_weekday, checkedTime);
  }

  void _saveToAll() async {
    final data = await DoctorModel.getById(widget.doctorId);
    def = [...checkedTime];

    setState(() {
      _changed = false;
    });
    await data.applyToAllSchedule(checkedTime);
  }

  void _discard() {
    setState(() {
      checkedTime = def;
    });
  }

  List<int> time = [
    70,
    73,
    8,
    83,
    90,
    93,
    100,
    103,
    110,
    113,
    120,
    123,
    130,
    133,
    140,
    143,
    150,
    153,
    160,
    163,
    170,
    173,
    180,
    183,
    190,
    193,
    200,
    203,
    210,
    213,
    220,
    223
  ];

  List<int> checkedTime = [];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(
                height: 60,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (ctx, i) {
                    return GestureDetector(
                      onTap: () async {
                        if (i != _weekday) {
                          _getData(i);
                          setState(() {
                            _weekday = i;
                          });
                        }
                      },
                      child: Card(
                        color: i == _weekday
                            ? const Color(0xFF3A86FF)
                            : Colors.white,
                        child: SizedBox(
                          width: size.width / 5,
                          child: Center(
                            child: Text(
                              week[i],
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (ctx, i) {
                    return const SizedBox(
                      width: 5,
                    );
                  },
                  itemCount: 7,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFC4FAFF),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 10,
                  ),
                  child: ListView.builder(
                      itemCount: time.length,
                      itemBuilder: (ctx, index) {
                        bool checked = checkedTime.contains(time[index]);
                        return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: checked
                                    ? Colors.red
                                    : const Color(0xFF3A86FF)),
                            onPressed: () {
                              if (!checked) {
                                setState(() {
                                  checkedTime.add(time[index]);
                                });
                              } else {
                                setState(() {
                                  checkedTime.remove(time[index]);
                                });
                              }
                            },
                            child: Text(
                              '${time[index]}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ));
                      }),
                ),
              ),

              //button appear only for changing
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _discard,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          "Undo",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _save,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          "Save",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _saveToAll,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          "Apply to all",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
