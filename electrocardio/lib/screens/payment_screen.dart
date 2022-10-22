import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CreditCardWidget(
        cardNumber: "4099",
        expiryDate: "",
        cardHolderName: "",
        cvvCode: "444",
        isChipVisible: false,
        showBackView: false,
        onCreditCardWidgetChange: (CreditCardBrand) {},
        cardBgColor: Colors.black,
      ),
    );
  }
}
