import 'package:electrocardio/theme/theme.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/img/app_background.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Form(
              key: loginForm,
              child: Column(
                children: [
                  const Image(
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
                    onPressed: () {
                      Navigator.pushNamed(context, "newReport");
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
    );
  }
}
