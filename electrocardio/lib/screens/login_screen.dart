import 'dart:developer';

import 'package:electrocardio/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../models/fhir/app_fhir_clases.dart';
import '../services/services.dart';
import '../widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, String> formValues = {
      "userName": "",
      "pwd": "",
    };

    final GlobalKey<FormState> loginForm = GlobalKey<FormState>();
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: loginForm,
              child: Column(
                children: [
                  const Image(
                    image: AssetImage("assets/img/logo.png"),
                    height: 300,
                  ),
                  CustomForm(
                    labelText: "Correo",
                    formField: 'userName',
                    inputType: TextInputType.emailAddress,
                    formValues: formValues,
                    capitalization: TextCapitalization.none,
                    validator: (value) {
                      return;
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
                      return;
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ThemeApp.appRed,
                    ),
                    onPressed: () async {
                      loadingAlert(context, "Iniciando sesión");
                      final authService = Provider.of<AuthService>(context, listen: false);
                      final practitionerService = PractitionerService();
                      final String? uId = await authService.loginUser(formValues["userName"]!, formValues["pwd"]!);
                      Navigator.of(context).pop();
                      loadingAlert(context, "Obteniendo datos");
                      Map<String, dynamic> jsonValue = await practitionerService.getPractitioner(uId!);
                      if (jsonValue.isNotEmpty) {
                        context.read<AppPractitioner>().loadFromJson(jsonValue);
                        if (context.read<AppPractitioner>().role == "Oncologo") {
                          await context.read<AppPractitioner>().loadPractitionerOncoData();
                          Navigator.of(context).pop();
                          Navigator.pushNamedAndRemoveUntil(context, "homeOnc", (route) => false);
                        } else if (context.read<AppPractitioner>().role == "Cardiologo") {
                          await context.read<AppPractitioner>().loadPractitionerCardioData();
                          print(context.read<AppPractitioner>().id);
                          Navigator.of(context).pop();
                          Navigator.pushNamedAndRemoveUntil(context, "homeCar", (route) => false);
                        }
                      } else {
                        Navigator.of(context).pop();
                        showAlert(context);
                      }
                    },
                    child: const SizedBox(
                      height: 50,
                      width: 100,
                      child: Center(
                        child: Text("Ingresar"),
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 2,
                    color: ThemeApp.primary,
                    height: 40,
                  ),
                  Container(
                    child: Text(
                      "Ó puedes registrarte aquí",
                      style: GoogleFonts.rubik(
                        color: ThemeApp.primary,
                      ),
                    ),
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "register");
                    },
                    child: const SizedBox(
                      height: 50,
                      width: 100,
                      child: Center(
                        child: Text("Registrarme"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> loadingAlert(BuildContext context, String text) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Color.fromARGB(99, 0, 0, 0),
      builder: (context) {
        return customProgressIndicator(text: text);
      },
    );
  }

  void showAlert(BuildContext context) => showDialog(
        context: context,
        builder: (_) => AlertGlobal(alertText: "Datos incorrectos"),
      );
}
