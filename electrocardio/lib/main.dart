import 'package:electrocardio/screens/new_patient_contact_screen.dart';
import 'package:electrocardio/screens/screens.dart';
import 'package:flutter/material.dart';

import 'theme/theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Electrocardio',
      initialRoute: "homeOnc",
      routes: {
        "homeOnc": (context) => const HomeOncologo(),
        "register": (context) => const RegistryScreen(),
        "login": (context) => const LoginScreen(),
        "profilePicture": (context) => const ProfilePictureScreen(),
        "selectPatient": (context) => const SelectPatient(),
        "newPatient": (context) => const NewPatientScreen(),
        "contactPatientInfo": (context) => const ContactPatientInfo(),
        "newReport": (context) => const NewReportScreen(),
        "clinicalHistory": (context) => const ClinicalHistoryScreen(),
        "reportList": (context) => const ReportListScreen(),
        "profile": (context) => const ProfileScreen(),
        "electroView": (context) => const ElectroViewScreen(),
        "payment": (context) => const PaymentScreen(),
      },
      theme: ThemeApp.light,
    );
  }
}
