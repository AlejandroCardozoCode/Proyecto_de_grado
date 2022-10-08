import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:electrocardio/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileData extends StatelessWidget {
  final String practitionerName;
  final String role;
  final String id;
  final String imgUrl;
  const ProfileData({Key? key, required this.practitionerName, required this.role, required this.id, required this.imgUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Container(
      height: w * 0.4,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipOval(
              child: Image.memory(
                base64Decode(imgUrl),
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              width: 30,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  practitionerName,
                  textAlign: TextAlign.left,
                  style: GoogleFonts.rubik(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: ThemeApp.appRed,
                  ),
                ),
                Text(
                  role,
                  textAlign: TextAlign.left,
                  style: GoogleFonts.rubik(
                    fontSize: 15,
                  ),
                ),
                Text(
                  id,
                  textAlign: TextAlign.left,
                  style: GoogleFonts.rubik(
                    fontSize: 12,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
