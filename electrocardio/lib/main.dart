import 'package:electrocardio/screens/screens.dart';
import 'package:electrocardio/services/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/fhir/app_fhir_clases.dart';
import 'theme/theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //creacion de providers para el manejo de los objetos dentro de la aplicacion
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthService(),
        ),
        ChangeNotifierProvider<AppPractitioner>(
          create: (_) => AppPractitioner(),
        ),
        ChangeNotifierProvider<AppPatient>(
          create: (_) => AppPatient(),
        ),
        ChangeNotifierProvider<AppPatientContact>(
          create: (_) => AppPatientContact(),
        ),
        ChangeNotifierProvider<AppDiagosticReport>(
          create: (_) => AppDiagosticReport(),
        ),
        ChangeNotifierProvider<AppObservation>(
          create: (_) => AppObservation(),
        ),
      ],
      builder: (context, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Electrocardio Telegraph',
          initialRoute: "login",
          routes: {
            "homeOnc": (context) => const HomeOncologo(),
            "homeCar": (context) => const HomeCardiologo(),
            "register": (context) => const RegistryScreen(),
            "login": (context) => const LoginScreen(),
            "profilePicture": (context) => const ProfilePictureScreen(),
            "selectPatient": (context) => const SelectPatient(),
            "newPatient": (context) => const RegisterPatient(),
            "contactPatientInfo": (context) => const RegisterPatientContact(),
            "newReport": (context) => const NewReportScreen(),
            "clinicalHistory": (context) => const ObservationScreen(),
            "reportList": (context) => const ReportListScreen(),
            "profile": (context) => const ProfileScreen(),
            "electroView": (context) => const ElectroViewScreen(),
            //"payment": (context) => const PaymentScreen(),
            "patientList": (context) => const PatientListScreen(),
            "writeDiagnostic": (context) => const WriteDiagnostic(),
          },
          theme: ThemeApp.light,
        );
      },
    );
  }
}
