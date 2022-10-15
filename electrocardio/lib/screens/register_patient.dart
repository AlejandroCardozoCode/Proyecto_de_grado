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
    "contactFirstName": "",
    "contactLastName": "",
    "contactPhone": "",
    "contactGender": "",
    "contactAddress": "",
    "contactRelationCode": "",
  };

  // paciente validadores
  bool isValidId = false;
  bool isValidName = false;
  bool isValidLastName = false;
  bool isValidPhone = false;
  bool isValidGender = false;
  bool isValidAddress = false;
  bool isValidMarital = false;
  bool isValidBirth = false;

  // contacto de emergencia validdores
  bool isValidNameE = false;
  bool isValidLastNameE = false;
  bool isValidPhoneE = false;
  bool isValidGenderE = false;
  bool isValidAddressE = false;
  bool isValidRelationCode = false;

  bool optionals = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppPatient currentPatient = context.watch<AppPatient>();
    currentPatient.clearValues();
    AppPractitioner currentPractitioner = context.watch<AppPractitioner>();
    final w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
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
                          value: "male",
                          child: Text("Hombre"),
                        ),
                        DropdownMenuItem(
                          value: "female",
                          child: Text("Mujer"),
                        ),
                        DropdownMenuItem(
                          value: "other",
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        value: optionals,
                        onChanged: (value) {
                          setState(() {
                            optionals = value!;
                          });
                        },
                      ),
                      const Text("Llenar datos opcionales del paciente")
                    ],
                  ),
                  optionals ? getOptionals(currentPatient, currentPractitioner, context) : Container(),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (isValidId && isValidBirth && isValidGender) {
                        if (optionals &&
                            isValidName &&
                            isValidLastName &&
                            isValidPhone &&
                            isValidAddress &&
                            isValidMarital &&
                            isValidNameE &&
                            isValidPhoneE &&
                            isValidGenderE &&
                            isValidAddressE &&
                            isValidLastNameE) {
                          AppPatientContact emergencyContact = AppPatientContact();
                          emergencyContact.setValues(formValues["contactRelationCode"], formValues["contactFirstName"], formValues["contactLastName"], formValues["contactPhone"],
                              formValues["contactGender"], formValues["contactAddress"]);
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
                            emergencyContact,
                          );
                          currentPatient.create();
                          currentPatient.uploadToFirebase(currentPatient.id);
                          currentPractitioner.addPatientToList(currentPatient);
                          Navigator.popAndPushNamed(context, "homeOnc");
                        } else if (!optionals) {
                          currentPatient.setPatientValues(
                            formValues["id"],
                            formValues["id"],
                            formValues["id"],
                            formValues["id"],
                            formValues["gender"],
                            formValues["birthDate"],
                            formValues["id"],
                            formValues["id"],
                            formValues["id"],
                            currentPractitioner.id,
                            AppPatientContact(),
                          );
                          currentPatient.create();
                          currentPatient.uploadToFirebase(currentPatient.id);
                          currentPractitioner.addPatientToList(currentPatient);
                          Navigator.popAndPushNamed(context, "homeOnc");
                        } else {
                          showAlert(context);
                        }
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
      ),
    );
  }

  Widget getOptionals(AppPatient currentPatient, AppPractitioner currentPractitioner, BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 30,
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
                  value: "I",
                  child: Text("Interlocutorio"),
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
                  value: "P",
                  child: Text("Polígamo"),
                ),
                DropdownMenuItem(
                  value: "W",
                  child: Text("Viudo"),
                ),
                DropdownMenuItem(
                  value: "UNK",
                  child: Text("Desconocido"),
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
            fontSize: 14,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        CustomForm(
            labelText: "Nombre",
            formField: 'contactFirstName',
            formValues: formValues,
            validator: (value) {
              if (value!.length < 1) {
                isValidNameE = false;
                return "Ingrese un nombre\n";
              }

              isValidNameE = true;
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
              isValidLastNameE = false;
              return "Ingrese un apellido\n";
            }

            isValidLastNameE = true;
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
              isValidPhoneE = false;
              return "Ingrese un numero con almenos 6 dijitos\n";
            }
            isValidPhoneE = true;
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
                value: "male",
                child: Text("Hombre"),
              ),
              DropdownMenuItem(
                value: "female",
                child: Text("Mujer"),
              ),
              DropdownMenuItem(
                value: "other",
                child: Text("Otro"),
              ),
            ],
            onChanged: (value) {
              if (value != null) {
                formValues["contactGender"] = value;
                isValidGenderE = true;
              } else {
                isValidGenderE = false;
              }
            },
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        CustomForm(
          labelText: "Direccion",
          formField: 'contactAddress',
          formValues: formValues,
          validator: (value) {
            if (value!.length < 5) {
              isValidAddressE = false;
              return "Ingrese una direccion valida\n";
            }
            isValidAddressE = true;
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
                child: Text("Persona de contacto de facturación"),
              ),
              DropdownMenuItem(
                value: "CP",
                child: Text("Persona de contacto"),
              ),
              DropdownMenuItem(
                value: "EP",
                child: Text("Persona de contacto de emergencia"),
              ),
              DropdownMenuItem(
                value: "E",
                child: Text("Empleador"),
              ),
              DropdownMenuItem(
                value: "I",
                child: Text("Compañía de seguros"),
              ),
              DropdownMenuItem(
                value: "U",
                child: Text("Desconocido"),
              ),
            ],
            onChanged: (value) {
              if (value != null) {
                isValidRelationCode = true;
                formValues["contactRelationCode"] = value;
              } else {
                isValidRelationCode = false;
              }
            },
          ),
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }

  void showAlert(BuildContext context) => showDialog(
        context: context,
        builder: (_) => AlertGlobal(alertText: "Alguno de los campos no esta llenado correctamente"),
      );
}
