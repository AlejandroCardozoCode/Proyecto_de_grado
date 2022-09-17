import 'package:electrocardio/models/fhir/observation_fhir.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/fhir/app_fhir_clases.dart';
import '../theme/theme.dart';
import '../widgets/widgets.dart';

class ObservationScreen extends StatefulWidget {
  const ObservationScreen({Key? key}) : super(key: key);

  @override
  State<ObservationScreen> createState() => _ObservationScreenState();
}

class _ObservationScreenState extends State<ObservationScreen> {
  String observationValue = "";
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    AppObservation currentObservation = context.watch<AppObservation>();
    final w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(children: [
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
              height: 10,
            ),
            Text(
              "Detalles del electrocardiograma",
              textAlign: TextAlign.center,
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
                  hintText:
                      "Por favor ingrese informacion relevante para el cardiologo",
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
                if (observationValue.length < 75) {
                  showAlert(context);
                } else {
                  currentObservation.actualObservation = observationValue;
                  showSendElectroDialog(context);
                }
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
          ]),
        ),
      ),
    );
  }

  void showAlert(BuildContext context) => showDialog(
        context: context,
        builder: (_) => AlertGlobal(
            alertText:
                "Se necesitan al menos 75 caracteres, usted a escrito ${controller.text.length}"),
      );

  void showSendElectroDialog(BuildContext context) => showDialog(
        context: context,
        builder: (_) => const AlertSendElectro(),
      );
}
