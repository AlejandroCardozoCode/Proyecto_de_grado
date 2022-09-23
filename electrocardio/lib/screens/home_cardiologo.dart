import 'package:electrocardio/widgets/nav_bar_cardio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/fhir/app_fhir_clases.dart';
import '../widgets/widgets.dart';
import 'screens.dart';

class HomeCardiologo extends StatefulWidget {
  const HomeCardiologo({Key? key}) : super(key: key);

  @override
  State<HomeCardiologo> createState() => _HomeCardiologoState();
}

class _HomeCardiologoState extends State<HomeCardiologo> {
  int index = 0;
  AppNavBarCardio? navBar;
  @override
  void initState() {
    super.initState();
    context.read<AppPractitioner>().create(
          firstName: "Ricardo",
          lastName: "Gomez",
          id: "1023974032",
          role: "Cardiologo",
          active: "true",
          address: "calle 15 sur # 10 - 60",
          birthDate: "31-12-1998",
          email: "abcdef@gmail.com",
          gender: "Hombre",
          imgUrl:
              "https://painlesshire.com/wp-content/uploads/2017/07/doctor.jpg",
        );
    context.read<AppPractitioner>()..diagnosticTestValues();

    navBar = AppNavBarCardio(
      currentIndex: (i) {
        setState(() {
          index = i;
        });
      },
    );
  }

  final List<Widget> _body = [
    const DiagnosticListScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    // crear el practitioner de la aplicacion
    //TODO se tiene que cargar desde un string ymal que va a estar en firebase
    return SafeArea(
      child: Scaffold(
        body: _body[index],
        bottomNavigationBar: navBar,
      ),
    );
  }
}
