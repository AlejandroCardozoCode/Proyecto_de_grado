import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_view/photo_view.dart';

import '../widgets/widgets.dart';

class ReportListScreen extends StatelessWidget {
  const ReportListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ListView(
          padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
          children: [
            Text(
              "Listado de reportes",
              textAlign: TextAlign.left,
              style: GoogleFonts.rubik(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: w * 0.05,
            ),
            Text(
              "Aqui encontrara un listado de todos los reportes enviados junto con su respectivo analisis",
              textAlign: TextAlign.left,
              style: GoogleFonts.rubik(
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const CardReportElectro(
              reportDate: '20 Agosto',
              patientName: 'Diego',
              textReport:
                  'Ejemplo de texto que va en el reporte del electro generado por el cardiologo',
              textResume:
                  'Stet sadipscing sanctus tempor invidunt et diam. Dolor sed dolore sanctus tempor sed erat lorem, stet sit et amet rebum. Dolore amet gubergren stet ipsum sed eos amet, at takimata kasd ea sadipscing stet, dolor dolor erat gubergren sanctus amet sit elitr, erat sanctus amet ea nonumy sed sit kasd. Aliquyam et sanctus dolor et tempor amet, kasd sanctus et sed ipsum diam sed, clita rebum tempor dolore voluptua sed. Invidunt ea tempor sit sit accusam amet, dolor ipsum diam accusam consetetur sed et sit, sit dolores sanctus dolor stet no elitr lorem. Sadipscing sed takimata sadipscing stet dolore et lorem consetetur, sit magna dolor sadipscing eos sea ea erat, erat dolore labore rebum elitr, et lorem no aliquyam duo lorem erat sed diam. Accusam rebum clita no magna tempor. Voluptua lorem dolore dolor invidunt. Tempor dolore ipsum consetetur dolor sed takimata, amet accusam invidunt aliquyam ut diam elitr ipsum ipsum voluptua. Diam tempor no et sea dolor diam. Clita et no ea erat consetetur tempor ipsum dolor, nonumy gubergren lorem sed sea sit. Et est sanctus nonumy diam ipsum lorem lorem stet dolores. Ea justo lorem dolor aliquyam. Ea sit no clita est ea ipsum gubergren at diam. Et gubergren sed est ut. Et diam et stet ea nonumy, rebum tempor eirmod ipsum dolor dolor voluptua, eirmod et lorem diam magna justo sadipscing est amet. Amet sadipscing consetetur ipsum lorem sea erat, sit sea magna et dolore et est est, sit elitr duo dolor sanctus aliquyam sea erat, diam elitr dolor lorem amet dolor labore lorem, labore sadipscing eos et est no amet clita et, et elitr ipsum lorem ipsum sed sit sea ipsum. Amet dolores vero et rebum sit sanctus et dolor. Voluptua nonumy est at vero sit clita at et. Nonumy elitr erat ipsum sadipscing clita, kasd sit ut ipsum at sea magna dolores. Ut dolore voluptua sed ea. Et clita ea vero dolores, ipsum clita clita no diam, sed et vero sea sadipscing accusam, et lorem sanctus consetetur elitr. Et lorem accusam ut lorem. Consetetur consetetur et sed rebum. Vero amet voluptua kasd at invidunt at, diam labore clita dolor justo dolor takimata ipsum et, ea sadipscing eirmod stet ipsum labore clita, tempor sed sed sed consetetur amet lorem tempor ut dolores. Elitr accusam sit sadipscing dolor voluptua gubergren. Et labore gubergren stet no eos. Dolor et sit at rebum tempor est est. Sea est clita.',
            ),
          ],
        ),
      ),
    );
  }
}
