import 'package:flutter/material.dart';
import 'package:flutter_test_dev/controller/global_functions.dart';

class CustomDropdownButton extends StatefulWidget {
  final double width;
  final double height;
  final List<String> items;
  final onChanged;
  String itemSelected;
  bool isExpanded;
  Widget hint;
  Color dropdownColor;
  Color dropdownColorBorder;
  Color colorText;

  CustomDropdownButton(
      {this.width,
      this.height,
      @required this.onChanged,
      @required this.items,
      @required this.itemSelected,
      this.isExpanded = true,
      this.hint,
      this.dropdownColor = Colors.white,
      this.dropdownColorBorder = Colors.white,
      this.colorText = Colors.black26});

  @override
  _CustomDropdownButtonState createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height == null ? mediaQuery(context, 0.085) : widget.height,
      width: widget.width,
      padding: EdgeInsets.only(left: 10, right: 4),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: widget.dropdownColor,
          border: Border.all(color: widget.dropdownColorBorder),
          borderRadius: BorderRadius.circular(8)),
      child: DropdownButton(
        value: widget.itemSelected,
        onChanged: widget.onChanged,
        isExpanded: widget.isExpanded,
        dropdownColor: Colors.blueGrey[200],
        underline: Container(color: Colors.transparent),
        hint: widget.hint == null ? null : widget.hint,
        iconEnabledColor: widget.dropdownColorBorder,
        //dropdownColor: widget.dropdownColor,
        items: widget.items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value,
                style: TextStyle(
                    color: widget.colorText,
                    fontSize: mediaQuery(context, 0.028))),
          );
        }).toList(),
      ),
    );
  }
}
