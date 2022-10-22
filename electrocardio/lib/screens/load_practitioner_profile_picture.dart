import 'package:electrocardio/services/images_service.dart';
import 'package:electrocardio/theme/theme.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../models/fhir/app_fhir_clases.dart';
import '../services/auth_service.dart';
import '../widgets/widgets.dart';

class LoadPractitionerProfilePictureScreen extends StatefulWidget {
  const LoadPractitionerProfilePictureScreen({Key? key}) : super(key: key);

  @override
  State<LoadPractitionerProfilePictureScreen> createState() => _LoadPractitionerProfilePictureScreenState();
}

class _LoadPractitionerProfilePictureScreenState extends State<LoadPractitionerProfilePictureScreen> {
  String imagePath = "assets/img/profile_placeholder.png";
  File fileImage = File('');
  bool loadImage = false;

  @override
  Widget build(BuildContext context) {
    AppPractitioner practitioner = context.read<AppPractitioner>();
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    var w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: SizedBox(
              width: w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Image(
                    image: AssetImage("assets/img/user_creation_logo.png"),
                    height: 100,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  ClipOval(
                    child: Image(
                      image: loadImage ? FileImage(fileImage) : const AssetImage("assets/img/profile_placeholder.png") as ImageProvider,
                      fit: BoxFit.cover,
                      height: 200,
                      width: 200,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ThemeApp.primary,
                    ),
                    onPressed: () async {
                      XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery, maxHeight: 1500, maxWidth: 1500, imageQuality: 70);
                      setState(
                        () {
                          if (image != null) {
                            fileImage = File(image.path);
                            ImageService imageService = ImageService();
                            var binaryImage = imageService.convertToBinary(image);
                            practitioner.imgUrl = binaryImage;
                            loadImage = true;
                          }
                        },
                      );
                    },
                    child: const SizedBox(
                      height: 40,
                      width: 200,
                      child: Center(child: Text("Cargar imagen")),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ThemeApp.primary,
                    ),
                    onPressed: () async {
                      XFile? image = await ImagePicker().pickImage(source: ImageSource.camera, maxHeight: 1500, maxWidth: 1500, imageQuality: 70);
                      setState(
                        () {
                          if (image != null) {
                            fileImage = File(image.path);
                            ImageService imageService = ImageService();
                            var binaryImage = imageService.convertToBinary(image);
                            practitioner.imgUrl = binaryImage;
                            loadImage = true;
                          }
                        },
                      );
                    },
                    child: const SizedBox(
                      height: 40,
                      width: 200,
                      child: Center(child: Text("Tomar foto")),
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: ThemeApp.appRed,
                    ),
                    onPressed: () async {
                      if (!loadImage) {
                        showAlert(context);
                        return;
                      }
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        barrierColor: Color.fromARGB(99, 0, 0, 0),
                        builder: (context) {
                          return customProgressIndicator(text: "Enviando datos");
                        },
                      );

                      final authService = Provider.of<AuthService>(context, listen: false);
                      final String? userId = await authService.createUser(arguments["email"]!, arguments["pwd"]!);
                      if (!userId!.isEmpty) {
                        practitioner.firstName = arguments["firstName"]!;
                        practitioner.lastName = arguments["lastName"]!;
                        practitioner.id = arguments["id"]!;
                        practitioner.idFirebase = userId;
                        practitioner.role = arguments["role"]!;
                        practitioner.active = "true";
                        practitioner.address = arguments["address"]!;
                        practitioner.birthDate = arguments["birthDate"]!;
                        practitioner.email = arguments["email"]!;
                        practitioner.gender = arguments["gender"]!;

                        practitioner.create();
                        await practitioner.uploadToFirebase(practitioner.idFirebase, practitioner.role);
                        Navigator.of(context).pop();
                        Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
                      } else {
                        Navigator.of(context).pop();
                        showAlertAccount(context);
                      }
                    },
                    child: SizedBox(
                      height: 40,
                      width: 200,
                      child: Center(child: Text("Finalizar")),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showAlert(BuildContext context) => showDialog(
        context: context,
        builder: (_) => AlertGlobal(
          alertText: "No se ha seleccionado una imagen",
        ),
      );

  void showAlertAccount(BuildContext context) => showDialog(
        context: context,
        builder: (_) => AlertAccountCreation(
          alertText: "No se ha podido crear la cuenta, es posible que ya exista una con este correo",
        ),
      );
}
