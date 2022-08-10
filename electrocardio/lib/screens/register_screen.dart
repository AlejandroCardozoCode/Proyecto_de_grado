import 'package:electrocardio/theme/theme.dart';
import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class RegistryScreen extends StatefulWidget {
  const RegistryScreen({Key? key}) : super(key: key);

  @override
  State<RegistryScreen> createState() => _RegistryScreenState();
}

class _RegistryScreenState extends State<RegistryScreen> {
  bool terms = false;
  @override
  Widget build(BuildContext context) {
    final Map<String, String> formValues = {
      "firstName": "",
      "lastName": "",
      "email": "",
      "pwd": "",
      "pwd2": "",
      "role": "",
    };
    final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/img/app_background.jpg"),
          fit: BoxFit.cover,
        )),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Form(
              key: myFormKey,
              child: Column(
                children: [
                  CustomForm(
                    labelText: "Nombre",
                    formField: 'firstName',
                    formValues: formValues,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomForm(
                    labelText: "Apellido",
                    formField: 'lastName',
                    formValues: formValues,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomForm(
                    labelText: "E-mail",
                    inputType: TextInputType.emailAddress,
                    formField: 'email',
                    formValues: formValues,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomForm(
                    labelText: "Contraseña",
                    protectedText: true,
                    formField: 'pwd',
                    formValues: formValues,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomForm(
                    labelText: "Confirmar Contraseña",
                    protectedText: true,
                    formField: 'pwd2',
                    formValues: formValues,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        labelText: "Especialidad",
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: "cardio",
                          child: Text("Cardiologo"),
                        ),
                        DropdownMenuItem(
                          value: "onco",
                          child: Text("Oncologo"),
                        ),
                      ],
                      onChanged: (value) {
                        formValues["role"] = value ?? "None";
                      }),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomForm(
                    labelText: "Universidad",
                    formField: 'uni',
                    formValues: formValues,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                        value: terms,
                        onChanged: (value) {
                          setState(() {
                            terms = value!;
                          });
                        },
                      ),
                      const Text("Acepto terminos y condiciones")
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (!myFormKey.currentState!.validate()) {
                        print("Este valor es requerido");
                      }
                      FocusScope.of(context).requestFocus(FocusNode());
                      print(formValues);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: ThemeApp.appRed,
                      elevation: 2,
                    ),
                    child: const SizedBox(
                      width: 80,
                      height: 50,
                      child: Center(
                        child: Text("Continuar"),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
