import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care/bloc/app_bloc.dart';
import 'package:health_care/bloc/app_event.dart';
import 'package:health_care/bloc/app_state.dart';
import 'package:health_care/widgets/check_list.dart';

const week = ["mon", "tue", "wed", "thu", "fri", "sat", "sun"];

class DoctorScheduleScreen extends StatefulWidget {
  const DoctorScheduleScreen({super.key});

  @override
  State<DoctorScheduleScreen> createState() => _DoctorScheduleScreenState();
}

class _DoctorScheduleScreenState extends State<DoctorScheduleScreen> {
  int _weekday = 0;

  void _save(BuildContext context) {
    if (_checkedTime.isNotEmpty) {
      context.read<AppBloc>().add(AppEventUpdateDoctorSchedule(times: _checkedTime, weekday: week[_weekday]));
    }
  }

  void _saveForAll(BuildContext context) {
    if (_checkedTime.isNotEmpty) {
      context.read<AppBloc>().add(AppEventUpdateDoctorSchedule(times: _checkedTime));
    }
  }

  void _discard() {
    setState(() {
      _checkedTime = [];
    });
  }

  List<int> _checkedTime = [];

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
                          setState(() {
                            _weekday = i;
                          });
                        }
                      },
                      child: Card(
                        color: i == _weekday ? const Color(0xFF3A86FF) : Colors.white,
                        child: SizedBox(
                          width: size.width / 5,
                          child: Center(
                            child: Text(
                              week[i],
                              style: const TextStyle(fontWeight: FontWeight.bold),
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
                  child: BlocBuilder<AppBloc, AppState>(builder: (context, state) {
                    return CheckList(
                      onChange: (list) {
                        _checkedTime = list;
                      },
                      initial: (state.doctor!.availableTime["$_weekday"] as List<int>),
                    );
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
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _save(context),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          "Save",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _saveForAll(context),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          "Apply to all",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
