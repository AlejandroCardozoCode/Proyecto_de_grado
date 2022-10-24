import 'package:electrocardio/models/payment/payment_method.dart';
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
          getChild(currentPractitioner.paymentMethodList),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            onPressed: () {
              Navigator.pushNamed(context, "addPaymentMethod");
            },
            child: Icon(Icons.add),
          )
        ],
      ),
    );
  }

  Widget getChild(List<PaymentMethod> paymentMethodList) {
    if (paymentMethodList.isEmpty) {
      return Card(
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
      );
    }
    return CreditCardWidget(
      cardNumber: "4099",
      expiryDate: "",
      cardHolderName: "",
      cvvCode: "444",
      isChipVisible: false,
      showBackView: false,
      onCreditCardWidgetChange: (CreditCardBrand) {},
      cardBgColor: Colors.black,
    );
  }
}
