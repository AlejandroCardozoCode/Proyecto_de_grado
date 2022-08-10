import 'package:electrocardio/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, String> formValues = {
      "userName": "",
      "pwd": "",
    };

    final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/img/app_background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Form(
                key: myFormKey,
                child: Column(children: [
                  Image(
                    image: AssetImage("assets/img/logo.png"),
                    height: 400,
                  ),
                  CustomForm(
                    labelText: "Usuario",
                    formField: 'userName',
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
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: ThemeApp.appRed,
                    ),
                    onPressed: () {},
                    child: Container(
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
                    onPressed: () {},
                    child: Container(
                      height: 50,
                      width: 100,
                      child: Center(
                        child: Text("Registarme"),
                      ),
                    ),
                  ),
                ]),
              )),
        ),
      ),
    );
  }
}
