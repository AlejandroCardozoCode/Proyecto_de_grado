import 'package:electrocardio/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/fhir/practitioner_fhir.dart';
import 'screens.dart';

class HomeOncologo extends StatefulWidget {
  const HomeOncologo({Key? key}) : super(key: key);

  @override
  State<HomeOncologo> createState() => _HomeOncologoState();
}

class _HomeOncologoState extends State<HomeOncologo> {
  int index = 0;
  AppNavBarOnco? navBar;
  @override
  void initState() {
    super.initState();
    navBar = AppNavBarOnco(
      currentIndex: (i) {
        setState(
          () {
            index = i;
            context.read<AppPractitioner>().loadPractitionerData();
          },
        );
      },
    );
  }

  final List<Widget> _body = [
    const SelectPatient(),
    const ReportListScreen(),
    const ProfileScreen(),
    const PaymentScreen(),
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
