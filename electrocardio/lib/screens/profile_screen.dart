import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/fhir/practitioner_fhir.dart';
import '../models/payment/payment_method.dart';
import '../theme/theme.dart';
import '../widgets/widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppPractitioner practitioner = context.watch<AppPractitioner>();
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                ClipOval(
                  child: Image.memory(
                    Uint8List.fromList(practitioner.imgUrl.codeUnits),
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                const ProfileInfoCard(),
                getChild(context, practitioner),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(context, "login", (route) => false);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ThemeApp.appRed,
                  ),
                  child: SizedBox(
                    height: 50,
                    width: 150,
                    child: Center(
                      child: Text(
                        "Cerrar sesión",
                        style: GoogleFonts.rubik(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getChild(BuildContext context, AppPractitioner practitioner) {
    if (practitioner.role == "Cardiologo") {
      return Container();
    }
    if (practitioner.paymentMethodList == null) {
      return Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 40),
            alignment: Alignment.centerLeft,
            child: Text(
              "Método de pago",
              style: GoogleFonts.rubik(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            height: 100,
            width: 500,
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: FittedBox(
                  child: Text(
                    "No tienes métodos de pago",
                    style: GoogleFonts.rubik(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, "addPaymentMethod");
            },
            child: Icon(Icons.add),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      );
    }
    PaymentMethod? paymentMethod = practitioner.paymentMethodList;
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 40),
            alignment: Alignment.centerLeft,
            child: Text(
              "Método de pago",
              style: GoogleFonts.rubik(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          CreditCardWidget(
            cardNumber: paymentMethod!.cardNumber,
            expiryDate: paymentMethod.expiryDate,
            cardHolderName: paymentMethod.cardHolderName,
            cvvCode: paymentMethod.cvvCode,
            showBackView: false,
            onCreditCardWidgetChange: (CreditCardBrand) {},
            cardBgColor: ThemeApp.primary,
          ),
        ],
      ),
    );
  }
}
