import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_dev/controller/global_functions.dart';

// ignore: must_be_immutable
class CustomTextField extends StatefulWidget {
  final double width;
  final double height;
  final double marginTop;
  final double marginBottom;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final int maxLength;
  final int maxLines;
  final FocusNode focusNode;
  final onChanged;
  final TextCapitalization textCapitalization;
  final FocusNode focusScope;
  final String labelText;
  final Color color;
  final Color colorText;
  final Color colorBord;
  final TextAlign textAlign;
  bool iconBool;
  final IconData suffixIcon1;
  final IconData suffixIcon2;
  String Function() errorText;
  final validate;
  final onEditingComplete;
  Function() onFieldSubmitted;
  final onTap;
  final onPressed;
  bool autovalidate;
  bool readOnly;
  Widget prefixIcon;

  CustomTextField(
      {Key key,
      this.width,
      this.height,
      this.marginTop = 0.0,
      this.marginBottom = 0.0,
      this.controller,
      this.keyboardType,
      this.textInputAction,
      this.maxLength,
      this.maxLines,
      this.focusNode,
      this.onChanged,
      this.textCapitalization = TextCapitalization.none,
      this.focusScope,
      this.labelText,
      this.color = Colors.blueGrey,
      this.colorText = Colors.blueGrey,
      this.colorBord = Colors.blueGrey,
      this.textAlign = TextAlign.start,
      this.iconBool = false,
      this.suffixIcon1,
      this.suffixIcon2,
      this.errorText,
      this.validate,
      this.onTap,
      this.onPressed,
      this.readOnly = false,
      this.prefixIcon,
      this.autovalidate = true,
      this.onFieldSubmitted,
      this.onEditingComplete})
      : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: mediaQuery(context, 1),
      height: widget.height,
      margin: EdgeInsets.only(
        top: widget.marginTop,
        left: 16,
        right: 16,
        bottom: widget.marginBottom,
      ),
      child: TextFormField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        maxLength: widget.maxLength,
        maxLines: widget.maxLines,
        focusNode: widget.focusNode,
        onChanged: widget.onChanged,
        autovalidate: widget.autovalidate,
        validator: widget.validate,
        readOnly: widget.readOnly,
        textCapitalization: widget.textCapitalization,
        textAlign: widget.textAlign,
        autofocus: false,
        cursorColor: widget.color,
        style: TextStyle(color: widget.colorText),
        obscureText: widget.iconBool,
        onFieldSubmitted: (v) {
          widget.onFieldSubmitted == null
              ? FocusScope.of(context).requestFocus(widget.focusScope)
              : widget.onFieldSubmitted;
        },
        onEditingComplete: widget.onEditingComplete,
        onTap: widget.onTap,
        decoration: InputDecoration(
            counterText: '',
            prefixIcon: widget.prefixIcon == null ? null : widget.prefixIcon,
            suffixIcon: widget.suffixIcon1 == null ? widget.suffixIcon2 == null
                    ? null
                    : IconButton(
                        icon: Icon(widget.suffixIcon2,
                            color: widget.colorText,
                            size: 20),
                        padding: EdgeInsets.all(0),
                        onPressed: () {
                          // ignore: unnecessary_statements
                          widget.onPressed;
                        })
                : IconButton(
                    icon: Icon(
                      widget.iconBool ? widget.suffixIcon1 : widget.suffixIcon2,
                      color: widget.colorText,
                      size: 20,
                    ),
                    padding: EdgeInsets.all(0),
                    onPressed: () {
                      setState(() {
                        widget.iconBool = !widget.iconBool;
                      });
                    }),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: widget.colorBord)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: widget.colorBord)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: widget.colorBord)),
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: widget.colorBord)),
            labelText: widget.labelText,
            labelStyle: TextStyle(color: widget.colorText),
            errorText: widget.errorText == null ? null : widget.errorText(),
            //contentPadding: EdgeInsets.only(left: 10, right: 0, top: 0, bottom: 0),
        ),
      ),
    );
  }
}
