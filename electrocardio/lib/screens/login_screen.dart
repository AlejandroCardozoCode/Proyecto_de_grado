import 'package:electrocardio/theme/theme.dart';
import 'package:flutter/material.dart';
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
              child: Expanded(
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
                      validator: (value) {},
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomForm(
                      labelText: "Contraseña",
                      protectedText: true,
                      formField: 'pwd',
                      formValues: formValues,
                      validator: (value) {},
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ThemeApp.appRed,
                      ),
                      onPressed: () async {
                        final authService = Provider.of<AuthService>(context, listen: false);
                        final practitionerService = PractitionerService();
                        final String? uId = await authService.loginUser(formValues["userName"]!, formValues["pwd"]!);
                        if (uId != null) {
                          context.read<AppPractitioner>().loadFromYaml(await practitionerService.getPtactitioner(uId));
                          if (context.read<AppPractitioner>().role == "Oncologo") {
                            context.read<AppPractitioner>().loadPractitionerData();
                            Navigator.pushNamedAndRemoveUntil(context, "homeOnc", (route) => false);
                          } else if (context.read<AppPractitioner>().role == "Cardiologo") {
                            context.read<AppPractitioner>().loadPractitionerData();
                            Navigator.pushNamedAndRemoveUntil(context, "homeCar", (route) => false);
                          }
                        } else {
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
                    const SizedBox(
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
                          child: Text("Registarme"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showAlert(BuildContext context) => showDialog(
        context: context,
        builder: (_) => AlertGlobal(alertText: "Datos incorrectos"),
      );
}
