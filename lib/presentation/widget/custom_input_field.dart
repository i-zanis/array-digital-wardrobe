import 'package:Array_App/config/style_config.dart';
import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  const CustomInputField(
    this.label,
    this.controller,
    this.labelStyle,
    this.fillColor,
    this.borderColor,
    this.isReadOnly, {
    super.key,
    this.maxLines,
  });

  final String label;
  final TextEditingController controller;
  final TextStyle labelStyle;
  final Color fillColor;
  final Color borderColor;
  final bool isReadOnly;
  final TextInputType keyboardType = TextInputType.text;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Styles.paddingS),
      child: TextField(
        controller: controller,
        readOnly: isReadOnly,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: labelStyle,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: borderColor),
          ),
        ),
      ),
    );
  }
}
