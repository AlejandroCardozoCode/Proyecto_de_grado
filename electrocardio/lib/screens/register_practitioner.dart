import 'dart:developer';

import 'package:electrocardio/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/widgets.dart';

class RegisterPractitioner extends StatefulWidget {
  const RegisterPractitioner({Key? key}) : super(key: key);

  @override
  State<RegisterPractitioner> createState() => _RegisterPractitionerState();
}

class _RegisterPractitionerState extends State<RegisterPractitioner> {
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
                    labelText: "Cédula",
                    inputType: TextInputType.number,
                    formField: 'id',
                    formValues: formValues,
                    validator: (value) {
                      if (value!.length < 6) {
                        isValidId = false;
                        return "La cédula tiene que tener mínimo 6 dígitos\n";
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
                    capitalization: TextCapitalization.none,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        isValidEmail = false;
                        return "El campo no puede estar vacío";
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
                          value: "Cardiologo",
                          child: Text("Cardiólogo"),
                        ),
                        DropdownMenuItem(
                          value: "Oncologo",
                          child: Text("Oncólogo"),
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
                    labelText: "Dirección",
                    formField: 'address',
                    formValues: formValues,
                    validator: (value) {
                      if (value!.length < 5) {
                        isValidAddress = false;
                        return "Ingrese una dirección valida\n";
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
                      GestureDetector(
                        onTap: () {
                          showTerms(
                            context,
                            "Diam dolores justo sadipscing no ipsum ipsum nonumy lorem et eos, takimata aliquyam ipsum sed lorem, labore et lorem ipsum sadipscing takimata at, labore labore diam sit sit et sed diam amet nonumy, ipsum takimata tempor at dolore ea, at sit sanctus kasd et aliquyam sanctus et ut, amet sit et accusam et stet gubergren sanctus sed accusam. Elitr aliquyam magna diam diam et accusam duo diam sadipscing. Dolore justo erat sed sed amet. Et lorem invidunt sadipscing takimata diam ut consetetur. Sed elitr et et dolor vero vero. Erat magna elitr aliquyam at est ea. Amet at vero dolor sea ipsum amet lorem at et, lorem diam kasd consetetur justo sed. Kasd takimata magna et kasd sea et. Sed justo magna et no, et takimata ipsum sit duo et consetetur diam duo amet. Erat amet nonumy nonumy nonumy eos invidunt magna ipsum. No kasd accusam aliquyam justo, takimata accusam et et at at gubergren diam tempor. Labore et vero elitr sanctus tempor invidunt. Kasd clita rebum sit amet ut no erat aliquyam, clita et nonumy dolore consetetur. Kasd et at nonumy sed et diam vero. Consetetur erat no diam consetetur et et, sadipscing sed sed ipsum sit sea, vero et clita magna eos ut elitr lorem accusam, ea sed takimata clita kasd no ipsum, voluptua voluptua et ea amet. Kasd et voluptua et clita sanctus ut clita. At eos kasd tempor dolores. Elitr nonumy amet aliquyam amet et sed, gubergren vero elitr ipsum et, dolor sanctus dolore ipsum invidunt sadipscing erat, accusam voluptua eirmod consetetur ut lorem gubergren, et lorem dolore no sit est stet ipsum. Ea sit tempor et sanctus ipsum sea gubergren eirmod. Accusam ea elitr clita sed lorem et ipsum, ipsum amet magna est invidunt justo. Dolores clita sea amet invidunt ipsum rebum erat. Rebum et stet ea nonumy sit. Labore amet duo vero ea, eirmod ea lorem et nonumy justo ipsum dolor invidunt, duo no stet amet sed, ea clita et magna kasd vero dolor. Eirmod vero accusam sit sit amet sea sea, lorem sed at sanctus ut ut aliquyam ipsum no. Consetetur at dolor at dolor kasd at gubergren sanctus amet. Labore justo sea justo sea elitr lorem. Justo takimata sed sea ut labore sanctus invidunt, gubergren kasd amet kasd voluptua no. Et et nonumy diam elitr. Diam sed sadipscing amet tempor eos dolor eirmod, clita at consetetur elitr stet, sit sanctus sit consetetur consetetur ipsum sit diam accusam tempor, et voluptua et et sanctus erat labore, ut sit magna nonumy gubergren, amet diam dolore takimata ipsum sanctus, tempor erat dolore gubergren erat vero lorem sea, duo sit nonumy duo kasd sed ipsum sea et at. Sanctus eirmod sanctus nonumy invidunt duo ipsum ipsum, amet voluptua erat ut eos et et voluptua, dolor sit dolor est kasd. Takimata ipsum nonumy est ipsum et, clita et lorem kasd lorem dolore, magna sed nonumy no sed et dolores lorem. Clita elitr dolore amet sit lorem, clita sed no amet sea lorem tempor. Ipsum takimata amet et.",
                          );
                        },
                        child: const Text("Acepto términos y condiciones"),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () async {
// nuevo
                      if (isValidName && isValidId && isValidAddress && isValidBirth && isValidGender && isValidLastName && isValidPass && isValidPass2 && isValidEmail && isValidRole && terms) {
                        Navigator.popAndPushNamed(context, "profilePicture", arguments: {
                          "email": formValues["email"],
                          "pwd": formValues["pwd"],
                          "firstName": formValues["firstName"],
                          "lastName": formValues["lastName"],
                          "id": formValues["id"],
                          "role": formValues["role"],
                          "active": "true",
                          "address": formValues["address"],
                          "birthDate": formValues["birthDate"],
                          "gender": formValues["gender"],
                        });
                      } else {
                        print(formValues);
                        showAlert(context, "No se han completado todos los datos del formulario");
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ThemeApp.appRed,
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

  void showAlert(BuildContext context, String alertMessage) => showDialog(
        context: context,
        builder: (_) => AlertGlobal(alertText: alertMessage),
      );
  void showTerms(BuildContext context, String terms) => showDialog(
        context: context,
        builder: (_) => AlertGlobal(alertText: terms, title: "Terminos y condiciones", isScrollable: true),
      );
}
