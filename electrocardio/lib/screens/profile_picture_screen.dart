// ignore_for_file: prefer_const_constructors

import 'package:electrocardio/theme/theme.dart';
import 'package:flutter/material.dart';

class ProfilePictureScreen extends StatelessWidget {
  const ProfilePictureScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Container(
      width: w,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/img/app_background.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
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
                    const CircleAvatar(
                      maxRadius: 100,
                      backgroundImage:
                          AssetImage("assets/img/profile_placeholder.png"),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: ThemeApp.primary,
                      ),
                      onPressed: () {},
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
                      onPressed: () {},
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
      ),
    );
  }
}
