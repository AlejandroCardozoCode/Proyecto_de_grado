import 'package:electrocardio/models/fhir/observation_fhir.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/fhir/app_fhir_clases.dart';
import '../theme/theme.dart';
import '../widgets/widgets.dart';

class WriteObservationScreen extends StatefulWidget {
  const WriteObservationScreen({Key? key}) : super(key: key);

  @override
  State<WriteObservationScreen> createState() => _WriteObservationScreenState();
}

class _WriteObservationScreenState extends State<WriteObservationScreen> {
  String observationValue = "";
  String priority = "";
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    AppObservation currentObservation = context.watch<AppObservation>();
    AppDiagosticReport currentDiagnostic = context.watch<AppDiagosticReport>();
    final w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Image(
                image: const AssetImage("assets/img/banner.png"),
                width: w * 0.8,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Paso 2 de de 2",
                style: GoogleFonts.rubik(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Prioridad",
                textAlign: TextAlign.center,
                style: GoogleFonts.rubik(
                  color: Colors.red,
                  fontSize: 18,
                ),
              ),
              Card(
                child: DropdownButtonFormField(
                  items: [
                    DropdownMenuItem(
                      value: "TOP-",
                      child: Text("Alta"),
                    ),
                    DropdownMenuItem(
                      value: "MID-",
                      child: Text("Media"),
                    ),
                    DropdownMenuItem(
                      value: "LOW-",
                      child: Text("Baja"),
                    ),
                  ],
                  onChanged: (value) {
                    priority = value as String;
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Detalles del electrocardiograma",
                style: GoogleFonts.rubik(
                  fontSize: 18,
                  color: Colors.red,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Card(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CustomTextField(
                    hintText: "Por favor ingrese informacion relevante para el cardiologo",
                    controller: controller,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  observationValue = controller.text;
                  if (priority == "") {
                    showAlertPriority(context);
                    return;
                  }
                  if (observationValue.length < 10) {
                    showAlert(context);
                    return;
                  }
                  currentObservation.actualObservation = observationValue;
                  currentDiagnostic.priority = priority;
                  //guardar en firebase
                  showSendElectroDialog(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ThemeApp.appRed,
                ),
                child: SizedBox(
                  height: 50,
                  width: 150,
                  child: Center(
                    child: Text(
                      "Enviar",
                      style: GoogleFonts.rubik(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void showAlert(BuildContext context) => showDialog(
        context: context,
        builder: (_) => AlertGlobal(alertText: "Se necesitan al menos 10 caracteres, usted a escrito ${controller.text.length}"),
      );
  void showAlertPriority(BuildContext context) => showDialog(
        context: context,
        builder: (_) => AlertGlobal(alertText: "No se ha seleccionado una prioridad"),
      );

  void showSendElectroDialog(BuildContext context) => showDialog(
        context: context,
        builder: (_) => const AlertSendObservation(),
      );
}
