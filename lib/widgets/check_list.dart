import 'package:flutter/material.dart';

List<int> _time = [70, 73, 8, 83, 90, 93, 100, 103, 110, 113, 120, 123, 130, 133, 140, 143, 150, 153, 160, 163, 170, 173, 180, 183, 190, 193, 200, 203, 210, 213, 220, 223];

class MyWidget extends StatefulWidget {
  final List<int> initial;
  final void Function(List<int> list)? onChange;
  final void Function()? revert;

  const MyWidget({super.key, this.onChange, this.revert, this.initial = const []});
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  late List<int> _list;

  @override
  void initState() {
    super.initState();
    _list.addAll(widget.initial);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: _time.length,
        itemBuilder: (ctx, index) {
          final checked = _list.contains(_time[index]);
          return ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: checked ? Colors.red : const Color(0xFF3A86FF)),
              onPressed: () {
                if (!checked) {
                  setState(() {
                    _list.add(_time[index]);
                  });
                } else {
                  setState(() {
                    _list.remove(_time[index]);
                  });
                }
                if (widget.onChange != null) {
                  widget.onChange!(_list);
                }
              },
              child: Text(
                '${(_time[index] / 10).truncate()}:${(_time[index] % 10) * 10}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ));
        });
  }
}
