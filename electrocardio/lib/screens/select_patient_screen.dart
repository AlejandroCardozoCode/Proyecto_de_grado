import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class SelectPatient extends StatelessWidget {
  const SelectPatient({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/img/app_background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              Image(
                image: const AssetImage("assets/img/logo.png"),
                height: w * 0.5,
              ),
              SizedBox(
                height: w * 0.15,
              ),
              const CustomPatientBanner(
                icon: Icons.person_add,
                text: "Agregar un nuevo paciente",
                route: "newPatient",
              ),
              const CustomPatientBanner(
                icon: Icons.format_list_bulleted_sharp,
                text: "Seleccionar paciente",
                route: "login",
              )
            ],
          ),
        ),
      ),
    );
  }
}
