import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/theme.dart';
import '../widgets/widgets.dart';

class NewPatientScreen extends StatefulWidget {
  const NewPatientScreen({Key? key}) : super(key: key);

  @override
  State<NewPatientScreen> createState() => _NewPatientScreenState();
}

class _NewPatientScreenState extends State<NewPatientScreen> {
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

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          physics: const BouncingScrollPhysics(),
          child: Form(
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
                  labelText: "Celular",
                  inputType: TextInputType.number,
                  formField: 'phone',
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
                      formValues["gender"] = value ?? "None";
                    }),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  width: w * 0.85,
                  child: Text(
                    "Fecha nacimiento",
                    style: GoogleFonts.rubik(
                      color: ThemeApp.primary,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.transparent,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    side: BorderSide(
                      width: 1,
                      color: ThemeApp.primary,
                    ),
                  ),
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
                  onPressed: () {
                    DatePicker.showDatePicker(
                      context,
                      maxTime: DateTime.now(),
                      onConfirm: (date) {
                        setState(() {
                          birthDate = "${date.year}-${date.month}-${date.day}";
                          formValues["birthDate"] = birthDate;
                        });
                      },
                    );
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () {
                    print(formValues);
                    Navigator.pushNamed(context, "contactPatientInfo");
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
}
