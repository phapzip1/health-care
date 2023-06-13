import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// widgets
import '../widgets/slider_with_label.dart';

// model
import '../models/doctor_model.dart';

const week = ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"];
const map = {
  "0.0": "00",
  "0.5": "30",
};

class DoctorScheduleScreen extends StatefulWidget {
  const DoctorScheduleScreen({
    super.key,
  });

  @override
  State<DoctorScheduleScreen> createState() => _DoctorScheduleScreenState();
}

class _DoctorScheduleScreenState extends State<DoctorScheduleScreen> {
  double _morning = 0;
  double _afternoon = 0;
  double _evening = 0;

  List<double> def = [0, 0, 0];

  int _weekday = 0;

  bool _changed = false;

  void _getData(int weekday) async {
    // Todo: fetch data from firebase
    final data = await (await DoctorModel.getById("Xgh3EC9d7jVeNsaRk6dsVM2Yk9V2")).getSchedule(weekday);
    setState(() {
      _morning = def[0] = data[0] * 1.0;
      _afternoon = def[1] = data[1] * 1.0;
      _evening = def[2] = data[2] * 1.0;
    });
  }

  @override
  void initState() {
    super.initState();
    _getData(_weekday);
  }

  void _save() async {
    final data = await DoctorModel.getById("Xgh3EC9d7jVeNsaRk6dsVM2Yk9V2");

    setState(() {
      _changed = false;
    });

    await data.applySchedule(_weekday, _morning, _afternoon, _evening);
  }

  void _saveToAll() async {
    final data = await DoctorModel.getById("Xgh3EC9d7jVeNsaRk6dsVM2Yk9V2");
    setState(() {
      _changed = false;
    });
    await data.applyToAllSchedule(_morning, _afternoon, _evening);
  }

  void _discard() {
    setState(() {
      _morning = def[0];
      _afternoon = def[1];
      _evening = def[2];
    });
  }

  String _toTime(double start, double offset) {
    final res = start + offset * 0.5;
    final isHalf = (res - res.floor()) == 0.5;
    return "${NumberFormat("00", "en_US").format(res.floor())}:${isHalf ? "30" : "00"}";
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    //ignore: avoid_print
    print("morning: $_morning, afternoon: $_afternoon, evening: $_evening");
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
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
                        color: i == _weekday ? Colors.amber : Colors.white,
                        child: SizedBox(
                          width: size.width / 5,
                          child: Center(
                            child: Text(week[i]),
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
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFC4FAFF),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SliderWithLabel(
                        label: "Morning",
                        onChanged: (value) {
                          setState(() {
                            _morning = value;
                            _changed = true;
                          });
                        },
                        value: _morning,
                        timeText: _morning == 0 ? "Unavailable" : "07:00 - ${_toTime(7, _morning)}",
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SliderWithLabel(
                        label: "Afternoon",
                        onChanged: (value) {
                          setState(() {
                            _afternoon = value;
                            _changed = true;
                          });
                        },
                        value: _afternoon,
                        timeText: _afternoon == 0 ? "Unavailable" : "13:00 - ${_toTime(13, _afternoon)}",
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SliderWithLabel(
                        label: "Evening",
                        onChanged: (value) {
                          setState(() {
                            _evening = value;
                            _changed = true;
                          });
                        },
                        value: _evening,
                        timeText: _evening == 0 ? "Unavailable" : "18:00 - ${_toTime(18, _evening)}",
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _discard,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Text("Undo"),
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
                        child: Text("Save"),
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
                        child: Text("Apply to all"),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
