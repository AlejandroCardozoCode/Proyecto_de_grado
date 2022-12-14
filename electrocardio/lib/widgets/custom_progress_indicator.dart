import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class customProgressIndicator extends StatelessWidget {
  final String text;
  final String asset;
  const customProgressIndicator({
    Key? key,
    required this.text,
    required this.asset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 200,
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(15),
                child: Lottie.asset(
                  asset,
                ),
              ),
              Card(
                elevation: 0,
                color: Colors.transparent,
                child: FittedBox(
                  child: Text(
                    text,
                    style: GoogleFonts.rubik(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
