import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/theme.dart';
import '../widgets/custom_form.dart';

class ContactPatientInfo extends StatefulWidget {
  const ContactPatientInfo({Key? key}) : super(key: key);

  @override
  State<ContactPatientInfo> createState() => _ContactPatientInfoState();
}

class _ContactPatientInfoState extends State<ContactPatientInfo> {
  @override
  Widget build(BuildContext context) {
    bool terms = false;
    final Map<String, String> formValues = {
      "contactCode": "",
      "contactTextCode": "",
      "contactFirstName": "",
      "contactLastName": "",
      "contactPhone": "",
      "contactGender": "",
      "contactAddress": "",
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
                  Text(
                    "Contacto emergencia",
                    style: GoogleFonts.rubik(
                      color: ThemeApp.appRed,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Llene estos datos con informacion del contacto de emergencia del paciente",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.rubik(
                      color: ThemeApp.primary,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  CustomForm(
                    labelText: "Nombre",
                    formField: 'contactFirstName',
                    formValues: formValues,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomForm(
                    labelText: "Apellido",
                    formField: 'contactLastName',
                    formValues: formValues,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomForm(
                    labelText: "Celular",
                    inputType: TextInputType.number,
                    formField: 'contactPhone',
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
                        formValues["contactGender"] = value ?? "None";
                      }),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomForm(
                    labelText: "Direccion",
                    formField: 'address',
                    formValues: formValues,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        labelText: "Relacion",
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: "BP",
                          child: Text("Contacto de emergencia"),
                        ),
                        DropdownMenuItem(
                          value: "E",
                          child: Text("Empleador"),
                        ),
                        DropdownMenuItem(
                          value: "F",
                          child: Text("Agente federal"),
                        ),
                        DropdownMenuItem(
                          value: "I",
                          child: Text("Compañia de seguros"),
                        ),
                        DropdownMenuItem(
                          value: "U",
                          child: Text("Desconocido"),
                        ),
                      ],
                      onChanged: (value) {
                        formValues["gender"] = value ?? "None";
                      }),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "");
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
