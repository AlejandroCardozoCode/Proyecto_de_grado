import 'package:electrocardio/theme/theme.dart';
import 'package:flutter/material.dart';

class CustomForm extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final TextInputType? inputType;
  final bool protectedText;
  final String? Function(String?)? validator;

  final String formField;
  final Map<String, String> formValues;
  const CustomForm({
    Key? key,
    this.hintText,
    this.labelText,
    this.helperText,
    this.inputType,
    this.protectedText = false,
    required this.formField,
    required this.formValues,
    required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shadowColor: ThemeApp.primary.withOpacity(0.5),
      child: TextFormField(
        keyboardType: inputType,
        obscureText: protectedText,
        autofocus: false,
        textCapitalization: TextCapitalization.words,
        onChanged: (value) {
          formValues[formField] = value;
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: hintText,
          errorMaxLines: 2,
          labelText: labelText,
          helperText: helperText,
          filled: true,
          fillColor: Colors.white,
        ),
        validator: validator,
      ),
    );
  }
}
