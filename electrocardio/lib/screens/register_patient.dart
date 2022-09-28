import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/fhir/app_fhir_clases.dart';
import '../theme/theme.dart';
import '../widgets/widgets.dart';

class RegisterPatient extends StatefulWidget {
  const RegisterPatient({Key? key}) : super(key: key);

  @override
  State<RegisterPatient> createState() => _RegisterPatientState();
}

class _RegisterPatientState extends State<RegisterPatient> {
  String birthDate = "Ingrese fecha de nacimiento";
  final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();
  final Map<String, String> formValues = {
    "id": "",
    "firstName": "",
    "lastName": "",
    "phone": "",
    "gender": "",
    "birthDate": "",
    "address": "",
    "maritalCode": "",
    "marialText": "",
  };

  bool isValidId = false;
  bool isValidName = false;
  bool isValidLastName = false;
  bool isValidPhone = false;
  bool isValidGender = false;
  bool isValidAddress = false;
  bool isValidMarital = false;
  bool isValidBirth = false;

  @override
  Widget build(BuildContext context) {
    AppPatient currentPatient = context.watch<AppPatient>();
    AppPractitioner currentPractitioner = context.watch<AppPractitioner>();
    final w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          physics: const BouncingScrollPhysics(),
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            key: myFormKey,
            child: Column(
              children: [
                Text(
                  "Creacion de paciente",
                  style: GoogleFonts.rubik(
                    color: ThemeApp.appRed,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Ingrese los siguientes datos del paciente",
                  style: GoogleFonts.rubik(
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomForm(
                  labelText: "Cedula Paciente",
                  inputType: TextInputType.number,
                  formField: 'id',
                  formValues: formValues,
                  validator: (value) {
                    if (value!.length < 6) {
                      isValidId = false;
                      return "La cedula tiene que tener minimo 6 digitos\n";
                    }
                    isValidId = true;
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomForm(
                  labelText: "Nombre",
                  formField: 'firstName',
                  formValues: formValues,
                  validator: (value) {
                    if (value!.length < 1) {
                      isValidName = false;
                      return "Ingrese un nombre\n";
                    }

                    isValidName = true;
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomForm(
                  labelText: "Apellido",
                  formField: 'lastName',
                  formValues: formValues,
                  validator: (value) {
                    if (value!.length < 1) {
                      isValidLastName = false;
                      return "Ingrese un apellido\n";
                    }

                    isValidLastName = true;
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomForm(
                  labelText: "Celular",
                  inputType: TextInputType.number,
                  formField: 'phone',
                  formValues: formValues,
                  validator: (value) {
                    if (value!.length < 6) {
                      isValidPhone = false;
                      return "Ingrese un numero con almenos 6 dijitos\n";
                    }
                    isValidPhone = true;
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
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
                  height: 20,
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
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Card(
                  elevation: 5,
                  shadowColor: ThemeApp.primary.withOpacity(0.5),
                  child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        labelText: "Estado civil",
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: "D",
                          child: Text("Divorciado"),
                        ),
                        DropdownMenuItem(
                          value: "L",
                          child: Text("Legalmente separado"),
                        ),
                        DropdownMenuItem(
                          value: "M",
                          child: Text("Casado"),
                        ),
                        DropdownMenuItem(
                          value: "S",
                          child: Text("Nunca casado"),
                        ),
                        DropdownMenuItem(
                          value: "W",
                          child: Text("Viudo"),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          isValidMarital = true;
                          formValues["maritalCode"] = value;
                          formValues["maritalText"] = "prueba";
                        } else {
                          isValidMarital = false;
                        }
                      }),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: w * 0.85,
                  child: Text(
                    "Fecha nacimiento",
                    style: GoogleFonts.rubik(
                      color: ThemeApp.primary,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    DatePicker.showDatePicker(
                      context,
                      maxTime: DateTime.now(),
                      onConfirm: (date) {
                        setState(() {
                          birthDate = "${date.year}-${date.month}-${date.day}";
                          formValues["birthDate"] = birthDate;
                          isValidBirth = true;
                        });
                      },
                    );
                  },
                  child: Card(
                    elevation: 5,
                    shadowColor: ThemeApp.primary.withOpacity(0.5),
                    child: SizedBox(
                      height: 50,
                      child: Center(
                        child: Text(
                          birthDate,
                          textAlign: TextAlign.start,
                          style: GoogleFonts.rubik(
                            color: const Color.fromARGB(255, 124, 124, 124),
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (isValidName &&
                        isValidId &&
                        isValidAddress &&
                        isValidBirth &&
                        isValidGender &&
                        isValidLastName &&
                        isValidMarital &&
                        isValidPhone) {
                      currentPatient.setPatientValues(
                        formValues["id"],
                        formValues["firstName"],
                        formValues["lastName"],
                        formValues["phone"],
                        formValues["gender"],
                        formValues["birthDate"],
                        formValues["address"],
                        formValues["maritalCode"],
                        formValues["maritalText"],
                        currentPractitioner.id,
                      );
                      Navigator.popAndPushNamed(context, "contactPatientInfo");
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
        builder: (_) => AlertGlobal(
            alertText: "Alguno de los campos no esta llenado correctamente"),
      );
}
