import 'package:electrocardio/models/payment/payment_method.dart';
import 'package:electrocardio/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../models/fhir/app_fhir_clases.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppPractitioner currentPractitioner = context.watch<AppPractitioner>();
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          getChild(context, currentPractitioner),
        ],
      ),
    );
  }

  Widget getChild(BuildContext context, AppPractitioner practitioner) {
    if (practitioner.paymentMethodList == null) {
      return Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 10,
              ),
              child: Text(
                "No se tienen métodos de pago",
                style: GoogleFonts.rubik(
                  fontSize: 22,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, "addPaymentMethod");
            },
            child: Icon(Icons.add),
          )
        ],
      );
    }
    PaymentMethod? paymentMethod = practitioner.paymentMethodList;
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            "Ya ingresaste un método de pago",
            style: GoogleFonts.rubik(
              fontSize: 22,
            ),
          ),
          CreditCardWidget(
            cardNumber: paymentMethod!.cardNumber,
            expiryDate: paymentMethod.expiryDate,
            cardHolderName: paymentMethod.cardHolderName,
            cvvCode: paymentMethod.cvvCode,
            showBackView: false,
            onCreditCardWidgetChange: (CreditCardBrand) {},
            cardBgColor: ThemeApp.appRed,
          ),
        ],
      ),
    );
  }
}
