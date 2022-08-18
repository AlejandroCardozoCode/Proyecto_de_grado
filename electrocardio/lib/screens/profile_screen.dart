import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/widgets.dart';

class ProfileScreen extends StatelessWidget {
   
  const ProfileScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      
      body: SafeArea(
        child: Center(
         child:
         Column(
          children: [
            const SizedBox (
              height: 40,
            ),
            Text("Perfil",
              textAlign: TextAlign.center,
              style: GoogleFonts.rubik(fontSize: 20, color: Colors.red), 
              ),
            const SizedBox (
              height: 40,
            ),
            ProfileData(),
            ],
          ) 
         )
        ) 
      );
  }
}