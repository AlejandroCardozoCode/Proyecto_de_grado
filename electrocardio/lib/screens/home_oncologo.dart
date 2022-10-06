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
    context.read<AppPractitioner>().clearValues();
    context.read<AppPractitioner>().create(
          firstName: "Diego",
          lastName: "Cardozo",
          id: "1023974032",
          role: "Oncologo",
          active: "true",
          address: "calle 15 sur # 10 - 60",
          birthDate: "31-12-1998",
          email: "d.alejandro198@gmail.com",
          gender: "Hombre",
          imgUrl:
              "https://external-content.duckduckgo.com/iu/?u=http%3A%2F%2Fwww.forwardthinkinguk.com%2Fwp-content%2Fuploads%2F2015%2F08%2Fdoctor.jpg&f=1&nofb=1",
        );

    navBar = AppNavBarOnco(
      currentIndex: (i) {
        setState(() {
          index = i;
        });
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
