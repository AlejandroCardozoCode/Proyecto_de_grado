import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;

  const CustomTextField({Key? key, this.hintText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 5,
      child: SizedBox(
        height: 300,
        child: TextFormField(
          maxLines: 50,
          autofocus: true,
          validator: (value) {
            if (value == null) return "Formulario vacio";
            //TODO: ARREGLAR disparo de alertas
            //if(value.length > 70 )
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
              hintText: hintText,
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent))),
        ),
      ),
    );
  }
}
