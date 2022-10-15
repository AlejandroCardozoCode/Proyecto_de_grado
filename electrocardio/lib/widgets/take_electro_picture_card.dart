import 'dart:io';

import 'package:electrocardio/models/fhir/diagnostic_report_fhir.dart';
import 'package:electrocardio/models/fhir/observation_fhir.dart';
import 'package:electrocardio/services/images_service.dart';
import 'package:electrocardio/theme/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'custom_progress_indicator.dart';

class TakeElectroPictureCard extends StatefulWidget {
  TakeElectroPictureCard({Key? key}) : super(key: key);

  @override
  State<TakeElectroPictureCard> createState() => _TakeElectroPictureCardState();
}

class _TakeElectroPictureCardState extends State<TakeElectroPictureCard> {
  String imagePath = "assets/img/electro_placeholder.png";
  File fileImage = File('');
  bool loadImage = false;

  @override
  Widget build(BuildContext context) {
    AppDiagosticReport currentDiagnostic = context.watch<AppDiagosticReport>();
    ImageService imageService = ImageService();
    return GestureDetector(
      onTap: () async {
        XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
        if (image != null) {
          showDialog(
            context: context,
            barrierDismissible: false,
            barrierColor: Color.fromARGB(99, 0, 0, 0),
            builder: (context) {
              return customProgressIndicator(text: "Procesando imagen");
            },
          );
          currentDiagnostic.imageReference = await compute(imageService.encryptImage, image);
          print(currentDiagnostic.imageReference);
          Navigator.of(context).pop();
        }
        setState(
          () {
            fileImage = File(image!.path);
            loadImage = true;
          },
        );
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
                image: loadImage ? FileImage(fileImage) : const AssetImage("assets/img/electro_placeholder.png") as ImageProvider,
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
