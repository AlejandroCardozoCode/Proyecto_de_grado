import 'dart:io';

import 'package:electrocardio/models/fhir/diagnostic_report_fhir.dart';
import 'package:electrocardio/models/fhir/observation_fhir.dart';
import 'package:electrocardio/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ElectroCard extends StatefulWidget {
  ElectroCard({Key? key}) : super(key: key);

  @override
  State<ElectroCard> createState() => _ElectroCardState();
}

class _ElectroCardState extends State<ElectroCard> {
  String imagePath = "assets/img/electro_placeholder.png";
  File fileImage = File('');
  bool loadImage = false;

  @override
  Widget build(BuildContext context) {
    AppDiagosticReport currentDiagnostic = context.watch<AppDiagosticReport>();
    return GestureDetector(
      onTap: () async {
        XFile? image =
            await ImagePicker().pickImage(source: ImageSource.camera);
        setState(() {
          if (image != null) {
            //imagePath = image.path;
            fileImage = File(image.path);
            loadImage = true;
            currentDiagnostic.imageReference =
                "https://i1.wp.com/electrocardiografia.wordpress.com/files/2008/11/ecg-2.png";
          }
        });
      },
      child: Card(
        margin: const EdgeInsets.all(30),
        elevation: 5,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: SizedBox(
          height: 325,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Image(
                image: loadImage
                    ? FileImage(fileImage)
                    : const AssetImage("assets/img/electro_placeholder.png")
                        as ImageProvider,
                fit: BoxFit.cover,
                height: 250,
              ),
              const SizedBox(
                height: 20,
              ),
              FittedBox(
                child: Text(
                  "Tomar foto de electrocardiograma (EGC)",
                  style: GoogleFonts.rubik(
                    color: ThemeApp.appRed,
                    fontSize: 15,
                  ),
                ),
              ),
              FittedBox(
                child: Text(
                  "Por favor, intente hacer la toma lo mejor posible",
                  style: GoogleFonts.rubik(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
