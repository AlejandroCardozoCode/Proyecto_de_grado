import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../models/fhir/app_fhir_clases.dart';
import '../theme/theme.dart';
import '../widgets/alert_global.dart';
import '../widgets/custom_form.dart';

class RegisterPatientContact extends StatefulWidget {
  const RegisterPatientContact({Key? key}) : super(key: key);

  @override
  State<RegisterPatientContact> createState() => _RegisterPatientContactState();
}

class _RegisterPatientContactState extends State<RegisterPatientContact> {
  final Map<String, String> formValues = {
    "contactCode": "",
    "contactTextCode": "",
    "contactFirstName": "",
    "contactLastName": "",
    "contactPhone": "",
    "contactGender": "",
    "contactAddress": "",
    "contactRelation": "",
  };
  final GlobalKey<FormState> myFormKey2 = GlobalKey<FormState>();

  bool isValidName = false;
  bool isValidLastName = false;
  bool isValidPhone = false;
  bool isValidGender = false;
  bool isValidAddress = false;
  bool isValidRelation = false;
  @override
  Widget build(BuildContext context) {
    AppPractitioner curentPractitioner = context.watch<AppPractitioner>();
    AppPatient currentPatient = context.watch<AppPatient>();
    AppPatientContact currentPatientContact =
        context.watch<AppPatientContact>();
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          physics: const BouncingScrollPhysics(),
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            key: myFormKey2,
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
                  textAlign: TextAlign.left,
                  style: GoogleFonts.rubik(
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomForm(
                    labelText: "Nombre",
                    formField: 'contactFirstName',
                    formValues: formValues,
                    validator: (value) {
                      if (value!.length < 1) {
                        isValidName = false;
                        return "Ingrese un nombre\n";
                      }

                      isValidName = true;
                    }),
                const SizedBox(
                  height: 30,
                ),
                CustomForm(
                  labelText: "Apellido",
                  formField: 'contactLastName',
                  formValues: formValues,
                  validator: (value) {
                    if (value!.length < 1) {
                      isValidLastName = false;
                      return "Ingrese un apellido\n";
                    }

                    isValidLastName = true;
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomForm(
                  labelText: "Celular",
                  inputType: TextInputType.number,
                  formField: 'contactPhone',
                  formValues: formValues,
                  validator: (value) {
                    if (value!.length < 6) {
                      isValidPhone = false;
                      return "Ingrese un numero con almenos 6 dijitos\n";
                    }
                    isValidPhone = true;
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                Card(
                  elevation: 5,
                  shadowColor: ThemeApp.primary.withOpacity(0.5),
                  child: DropdownButtonFormField<String>(
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
                      if (value != null) {
                        formValues["gender"] = value;
                        isValidGender = true;
                      } else {
                        isValidGender = false;
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomForm(
                  labelText: "Direccion",
                  formField: 'address',
                  formValues: formValues,
                  validator: (value) {
                    if (value!.length < 5) {
                      isValidAddress = false;
                      return "Ingrese una direccion valida\n";
                    }
                    isValidAddress = true;
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                Card(
                  elevation: 5,
                  shadowColor: ThemeApp.primary.withOpacity(0.5),
                  child: DropdownButtonFormField<String>(
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
                      if (value != null) {
                        isValidRelation = true;
                        formValues["contactRelation"] = value;
                      } else {
                        isValidRelation = false;
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () {
                    print(formValues);
                    if (isValidAddress &&
                        isValidGender &&
                        isValidLastName &&
                        isValidName &&
                        isValidPhone &&
                        isValidRelation) {
                      //create patient emergency contact
                      currentPatientContact.setValues(
                          formValues["contactCode"],
                          formValues["contactTextCode"],
                          formValues["contactFirstName"],
                          formValues["contactLastName"],
                          formValues["contactPhone"],
                          formValues["contactGender"],
                          formValues["contactAddress"]);

                      currentPatient.emergencyContact = currentPatientContact;
                      currentPatient.addEmergencyContact(currentPatientContact);
                      curentPractitioner.addPatientToList(currentPatient);
                      Navigator.popAndPushNamed(context, "newReport");
                    } else {
                      showAlert(context);
                    }
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
    );
  }

  void showAlert(BuildContext context) => showDialog(
        context: context,
        builder: (_) => const AlertGlobal(
            alertText: "Alguno de los campos no esta llenado correctamente"),
      );
}
