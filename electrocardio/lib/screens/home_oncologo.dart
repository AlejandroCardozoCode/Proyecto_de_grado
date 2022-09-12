import 'package:electrocardio/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/fhir/patient_fhir.dart';
import '../models/fhir/practitioner_fhir.dart';
import 'screens.dart';

class HomeOncologo extends StatefulWidget {
  const HomeOncologo({Key? key}) : super(key: key);

  @override
  State<HomeOncologo> createState() => _HomeOncologoState();
}

class _HomeOncologoState extends State<HomeOncologo> {
  int index = 0;
  AppNavBar? navBar;
  @override
  void initState() {
    super.initState();

    navBar = AppNavBar(
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
    context.read<AppPractitioner>().setValues(
          firstName: "Diego",
          lastName: "Cardozo",
          id: "1023974032",
          role: "Cardiologo",
          active: "true",
          address: "calle 15 sur # 10 - 60",
          birthDate: "31-12-1998",
          email: "d.alejandro198@gmail.com",
          gender: "Hombre",
          imgUrl:
              "https://pps.whatsapp.net/v/t61.24694-24/263593069_462535585801501_2048855126496712424_n.jpg?ccb=11-4&oh=01_AVznr0Ttssh_q-XCoeuWLUqCjRfMEcwANHXeR88WbK-WSQ&oe=632CC9E4",
        );

    return SafeArea(
        child: Scaffold(
      body: _body[index],
      bottomNavigationBar: navBar,
    ));
  }
}
