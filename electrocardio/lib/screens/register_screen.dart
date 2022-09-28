import 'package:electrocardio/communicators/all_communicator.dart';
import 'package:electrocardio/services/services.dart';
import 'package:electrocardio/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/fhir/practitioner_fhir.dart';
import '../widgets/widgets.dart';

class RegistryScreen extends StatefulWidget {
  const RegistryScreen({Key? key}) : super(key: key);

  @override
  State<RegistryScreen> createState() => _RegistryScreenState();
}

class _RegistryScreenState extends State<RegistryScreen> {
  bool terms = false;

  String birthDate = "Ingrese fecha de nacimiento";
  final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();
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
  bool isValidId = false;
  bool isValidName = false;
  bool isValidLastName = false;
  bool isValidEmail = false;
  bool isValidPass = false;
  bool isValidPass2 = false;
  bool isValidGender = false;
  bool isValidRole = false;
  bool isValidBirth = false;
  bool isValidAddress = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            physics: const BouncingScrollPhysics(),
            child: Form(
              autovalidateMode: AutovalidateMode.always,
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
                    height: 30,
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
                    height: 30,
                  ),
                  CustomForm(
                    labelText: "E-mail",
                    inputType: TextInputType.emailAddress,
                    formField: 'email',
                    formValues: formValues,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        isValidEmail = false;
                        return "El campo no puede estar vacio";
                      }

                      const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                      final regExp = RegExp(pattern);

                      if (!regExp.hasMatch(value)) {
                        isValidEmail = false;
                        return "El email no es valido";
                      }

                      isValidEmail = true;
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomForm(
                    labelText: "Contraseña",
                    protectedText: true,
                    formField: 'pwd',
                    formValues: formValues,
                    validator: (value) {
                      if (value!.length < 8) {
                        isValidPass = false;
                        return "La contraseña tiene que tener 8 caracteres\n";
                      }

                      isValidPass = true;
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomForm(
                    labelText: "Confirmar Contraseña",
                    protectedText: true,
                    formField: 'pwd2',
                    formValues: formValues,
                    validator: (value) {
                      if (value != formValues["pwd"]) {
                        isValidPass2 = false;
                        return "Las contraseñas no coinciden\n";
                      }

                      isValidPass2 = true;
                      return null;
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
                            isValidGender = true;
                            formValues["gender"] = value;
                          } else {
                            isValidGender = false;
                          }
                        }),
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
                        if (value != null) {
                          isValidRole = true;
                          formValues["role"] = value;
                        } else {
                          isValidRole = false;
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomForm(
                    labelText: "Direcction",
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
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      DatePicker.showDatePicker(
                        context,
                        maxTime: DateTime.now(),
                        onConfirm: (date) {
                          setState(() {
                            birthDate =
                                "${date.year}-${date.month}-${date.day}";
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
// nuevo
                      if (isValidName &&
                          isValidId &&
                          isValidAddress &&
                          isValidBirth &&
                          isValidGender &&
                          isValidLastName &&
                          isValidPass &&
                          isValidPass2 &&
                          isValidEmail &&
                          isValidRole) {
                        print(formValues);
                        //ToDo crear usuario en autenticacion y obtener el uid en firebase y asignarlo en una variable
                        AppPractitioner().create(
                          firstName: formValues["firstName"],
                          lastName: formValues["lastName"],
                          id: formValues["id"],
                          role: formValues["role"],
                          active: "true",
                          address: formValues["address"],
                          birthDate: formValues["birthDate"],
                          email: formValues["email"],
                          gender: formValues["gender"],
                          imgUrl:
                              "https://painlesshire.com/wp-content/uploads/2017/07/doctor.jpg",
                        );

                        Navigator.popAndPushNamed(context, "profilePicture");
                      } else {
                        print(formValues);
                        showAlert(context);
                      }

//                      Navigator.pushNamed(context, "profilePicture");
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

  void showAlert(BuildContext context) => showDialog(
        context: context,
        builder: (_) => AlertGlobal(
            alertText: "Alguno de los campos no esta llenado correctamente"),
      );
}
