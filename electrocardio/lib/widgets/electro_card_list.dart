import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ElectroCardList extends StatelessWidget {
   
  const ElectroCardList({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
           ListTile(
            leading: Image(image: NetworkImage("https://www.arterismedica.com/wp-content/uploads/2020/01/electrocardiograma-min.png")),
            title: Text(
              "Nombre paciente",
              style:GoogleFonts.rubik()
              ),
            subtitle: Text(
              "Información",
              style: GoogleFonts.rubik()
              ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(onPressed: (){
                  Navigator.pushNamed(context, "profile");
                },
                child: const Text(
                  "Ver \n electrocardiograma",
                  textAlign: TextAlign.center,
                  )
                ),
                TextButton(onPressed: (){},
                child: const Text(
                  "Ver resumen",
                  )
                ),
                TextButton(onPressed: (){},
                child: const Text(
                  "Ver reporte",
                  )
                )
              ],
          ),
      )
        ]
        ),
    );
  }
}