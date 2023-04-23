import 'package:Array_App/config/style_config.dart';
import 'package:flutter/material.dart';

class NameInputField extends StatelessWidget {
  const NameInputField({
    super.key,
    required this.field,
    required this.controller,
    required this.fillColor,
    required this.borderColor,
    required this.isEditingMode,
  });

  final String field;
  final TextEditingController controller;
  final Color fillColor;
  final Color borderColor;
  final bool isEditingMode;

  @override
  Widget build(BuildContext context) {
    final labelTextStyle = Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Theme.of(context).colorScheme.onTertiaryContainer,
            ) ??
        const TextStyle();
    return Padding(
      padding: const EdgeInsets.all(Styles.paddingS),
      child: TextField(
        controller: controller,
        readOnly: isEditingMode,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.6),
          hintText: field,
          // filled: true,
          // fillColor: fillColor,
          // enabled: false,
          // labelText: field,
          labelStyle: labelTextStyle,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: borderColor),
          ),
          // focusedBorder: UnderlineInputBorder(
          //   borderSide: BorderSide(color: Colors.cyan),
          // ),
          // prefixIcon: Icon(
          //   Icons.label,
          //   color: Theme.of(context).colorScheme.tertiary,
          // ),
          // suffixIcon: Icon(
          //   Icons.edit,
          //   color: Theme.of(context).primaryColor,
          // ),
        ),
      ),
    );
  }
}
