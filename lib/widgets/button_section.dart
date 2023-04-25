// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';

class ButtonSection extends StatefulWidget {
  const ButtonSection(
      {super.key,
      required this.click,
      required this.status,
      required this.mediaQuery,
      required this.sampleData});

  final List<RadioModel> sampleData;
  final MediaQueryData mediaQuery;
  final Function click;
  final bool status;

  @override
  State<ButtonSection> createState() => _ButtonSectionState();
}

class _ButtonSectionState extends State<ButtonSection> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // final mediaQuery = MediaQuery.of(context);

    return Container(
      width: double.infinity,
      child: Row(
        children: <Widget>[
          ...widget.sampleData
              .asMap()
              .entries
              .map((value) => Expanded(
                  flex: 1,
                  child: InkWell(
                      onTap: () {
                        setState(() {
                          currentIndex = value.key;
                        });
                        currentIndex == 0 ? widget.click(true) : widget.click(false);
                      },
                      child:
                          RadioItem(value.value, currentIndex == value.key))))
              .toList()
        ],
      ),
    );
  }
}

class RadioItem extends StatelessWidget {
  final RadioModel _item;
  final bool _isSelected;
  RadioItem(this._item, this._isSelected);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: _isSelected ? Color(0xFF3A86FF) : Color(0xFFE0E0E0),
        borderRadius: _item.value == 0
            ? BorderRadius.only(
                bottomLeft: Radius.circular(10), topLeft: Radius.circular(10))
            : BorderRadius.only(
                bottomRight: Radius.circular(10),
                topRight: Radius.circular(10)),
      ),
      child: Center(
        child: Text(
          _item.buttonText,
          style: TextStyle(
            color: _isSelected ? Colors.white : Color(0xFF828282),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

class RadioModel {
  bool isSelected;
  final String buttonText;
  final int value;

  RadioModel(this.isSelected, this.buttonText, this.value);
}
