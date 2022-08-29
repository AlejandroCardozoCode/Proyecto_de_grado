import 'package:electrocardio/models/practitioner.dart';
import 'package:electrocardio/theme/theme.dart';
import 'package:fhir/stu3/resource_types/resource_types.enums.dart';
import 'package:flutter/material.dart';

import '../widgets/widgets.dart';
import 'package:fhir/r4.dart' as r4;

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
      "id": "",
      "firstName": "",
      "lastName": "",
      "email": "",
      "pwd": "",
      "pwd2": "",
      "gender": "",
      "birthDate": "",
      "role": "",
    };
    final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/img/app_background.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: myFormKey,
              child: Column(
                children: [
                  const Image(
                    image: AssetImage("assets/img/user_creation_logo.png"),
                    height: 100,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  CustomForm(
                    labelText: "Cedula",
                    inputType: TextInputType.number,
                    formField: 'id',
                    formValues: formValues,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
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
                        labelText: "Genero",
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: "G1",
                          child: Text("Hombre"),
                        ),
                        DropdownMenuItem(
                          value: "G2",
                          child: Text("Mujer"),
                        ),
                        DropdownMenuItem(
                          value: "G3",
                          child: Text("Otro"),
                        ),
                      ],
                      onChanged: (value) {
                        formValues["gender"] = value ?? "None";
                      }),
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
                    labelText: "Direcction",
                    formField: 'address',
                    formValues: formValues,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomForm(
                    labelText: "fecha",
                    formField: 'birthDate',
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
                      Navigator.pushNamed(context, "profilePicture");
                      var pac = AppPractitioner(
                              active: "true",
                              id: formValues["id"],
                              firstName: formValues["firstName"],
                              lastName: formValues["lastName"],
                              email: formValues["email"],
                              address: formValues["address"],
                              gender: formValues["gender"],
                              birthDate: formValues["birthDate"])
                          .generatePractitioner;
                      print(pac);
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
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
