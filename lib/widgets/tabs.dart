import "package:flutter/material.dart";

class Tabs extends StatefulWidget {
  const Tabs({
    super.key,
    this.onChange,
    required this.children,
  });

  final List<Widget> children;
  final void Function(int index)? onChange;

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: widget.children
            .asMap()
            .entries
            .map(
              (e) => Expanded(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                      backgroundColor: _index == e.key ? const Color(0xFF3A86FF) : const Color(0xFFE0E0E0),
                    ),
                    onPressed: () {
                      if (e.key != _index) {
                        setState(() {
                          _index = e.key;
                        });
                        if (widget.onChange != null) {
                          widget.onChange!(e.key);
                        }
                      }
                    },
                    child: e.value),
              ),
            )
            .toList(),
      ),
    );
  }
}
