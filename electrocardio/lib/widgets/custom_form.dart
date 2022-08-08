import 'package:flutter/material.dart';

class CustomForm extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final TextInputType? inputType;
  final bool protectedText;

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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: inputType,
      obscureText: protectedText,
      autofocus: true,
      textCapitalization: TextCapitalization.words,
      onChanged: (value) {
        formValues[formField] = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return "Formulario No Valido";
        }
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        helperText: helperText,
      ),
    );
  }
}
