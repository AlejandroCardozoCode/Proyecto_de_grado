import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ElectroCardList extends StatelessWidget {
  const ElectroCardList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Card(
      child: Column(children: [
        ListTile(
          leading: Image(
              image: NetworkImage(
                  "https://www.arterismedica.com/wp-content/uploads/2020/01/electrocardiograma-min.png")),
          title: Text("Nombre paciente", style: GoogleFonts.rubik()),
          subtitle: Text("Información", style: GoogleFonts.rubik()),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: w * 0.4,
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, "profile");
                },
                child: Text(
                  "Ver \n electrocardiograma",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.rubik(
                    fontSize: 13,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: w * 0.2,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  "Ver resumen",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.rubik(
                    fontSize: 13,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: w * 0.2,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  "Ver reporte",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.rubik(
                    fontSize: 13,
                  ),
                ),
              ),
            )
          ],
        )
      ]),
    );
  }
}
