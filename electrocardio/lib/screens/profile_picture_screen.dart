// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:electrocardio/services/images_service.dart';
import 'package:electrocardio/theme/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../models/fhir/app_fhir_clases.dart';

class ProfilePictureScreen extends StatefulWidget {
  const ProfilePictureScreen({Key? key}) : super(key: key);

  @override
  State<ProfilePictureScreen> createState() => _ProfilePictureScreenState();
}

class _ProfilePictureScreenState extends State<ProfilePictureScreen> {
  String imagePath = "assets/img/profile_placeholder.png";
  File fileImage = File('');
  bool loadImage = false;

  @override
  Widget build(BuildContext context) {
    AppPractitioner practitioner = context.read<AppPractitioner>();
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
                      XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
                      setState(
                        () {
                          if (image != null) {
                            fileImage = File(image.path);
                            ImageService imageService = ImageService();
                            var base64img = imageService.convertToBase64(image);
                            practitioner.imgUrl = base64img;
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
                      primary: ThemeApp.primary,
                    ),
                    onPressed: () async {
                      XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
                      setState(
                        () {
                          if (image != null) {
                            //imagePath = image.path;
                            fileImage = File(image.path);
                            ImageService imageService = ImageService();
                            var base64img = imageService.convertToBase64(image);
                            practitioner.imgUrl = base64img;
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
                    onPressed: () {
                      print(practitioner.imgUrl);
                      practitioner.create();
                      practitioner.uploadToFirebase(practitioner.idFirebase);
                      Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
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
}
