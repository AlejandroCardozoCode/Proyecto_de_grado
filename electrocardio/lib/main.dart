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
        ChangeNotifierProvider<AppDiagnosticReport>(
          create: (_) => AppDiagnosticReport(),
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
            "homeOnc": (context) => const HomeOncologist(),
            "homeCar": (context) => const HomeCardiologist(),
            "register": (context) => const RegisterPractitioner(),
            "login": (context) => const LoginScreen(),
            "profilePicture": (context) => const LoadPractitionerProfilePictureScreen(),
            "selectPatient": (context) => const SelectPatient(),
            "newPatient": (context) => const RegisterPatient(),
            "newReport": (context) => const TakeElectroPictureScreen(),
            "clinicalHistory": (context) => const WriteObservationScreen(),
            "reportList": (context) => const ObservationList(),
            "profile": (context) => const ProfileScreen(),
            "electroView": (context) => const ShowImageScreen(),
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
