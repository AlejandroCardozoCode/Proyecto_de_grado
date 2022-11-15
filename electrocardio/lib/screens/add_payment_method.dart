import 'package:csc_picker/csc_picker.dart';
import 'package:electrocardio/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../models/fhir/app_fhir_clases.dart';
import '../widgets/widgets.dart';

class MySample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MySampleState();
  }
}

class MySampleState extends State<MySample> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  String city = '';
  String state = '';
  String country = '';
  bool isCvvFocused = false;
  bool useBackgroundImage = false;

  bool stateSelected = false;
  bool citySelected = false;
  bool countrySelected = false;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
  );

  late Map<String, String> formValues = {};
  late String address;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppPractitioner currentPractitioner = context.watch<AppPractitioner>();
    return Scaffold(
      appBar: ApplicationAppBar(
        darkIcons: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20, bottom: 20),
                child: Text(
                  "Nuevo método de pago",
                  style: GoogleFonts.rubik(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              CreditCardWidget(
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                showBackView: isCvvFocused,
                cardBgColor: ThemeApp.primary,
                onCreditCardWidgetChange: (CreditCardBrand creditCardBrand) {},
              ),
              Card(
                elevation: 2.5,
                shadowColor: ThemeApp.primary,
                child: Column(
                  children: <Widget>[
                    CreditCardForm(
                      formKey: formKey,
                      obscureCvv: true,
                      obscureNumber: true,
                      cardNumber: cardNumber,
                      cvvCode: cvvCode,
                      isHolderNameVisible: true,
                      isCardNumberVisible: true,
                      isExpiryDateVisible: true,
                      cardHolderName: cardHolderName,
                      expiryDate: expiryDate,
                      themeColor: Colors.blue,
                      cardNumberDecoration: InputDecoration(
                        labelText: 'Numero de la tarjeta',
                        hintText: 'XXXX XXXX XXXX XXXX',
                        border: outlineInputBorder,
                        labelStyle: GoogleFonts.rubik(),
                        hintStyle: GoogleFonts.rubik(),
                      ),
                      expiryDateDecoration: InputDecoration(
                        labelText: 'Fecha expiración',
                        hintText: 'MM/AA',
                        border: outlineInputBorder,
                        labelStyle: GoogleFonts.rubik(),
                        hintStyle: GoogleFonts.rubik(),
                      ),
                      cvvCodeDecoration: InputDecoration(
                        labelText: 'CVV',
                        hintText: 'XXX',
                        labelStyle: GoogleFonts.rubik(),
                        border: outlineInputBorder,
                        hintStyle: GoogleFonts.rubik(),
                      ),
                      cardHolderDecoration: InputDecoration(
                        labelText: 'Nombre propietario',
                        border: outlineInputBorder,
                        labelStyle: GoogleFonts.rubik(),
                        hintStyle: GoogleFonts.rubik(),
                      ),
                      onCreditCardModelChange: onCreditCardModelChange,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.only(top: 20, bottom: 20, left: 15),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Información de dirección",
                  style: GoogleFonts.rubik(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Card(
                shadowColor: ThemeApp.primary,
                elevation: 2.5,
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: CSCPicker(
                    onCityChanged: (city) {
                      citySelected = true;
                      if (city != null) this.city = city;
                    },
                    onCountryChanged: (country) {
                      countrySelected = true;
                      if (country != null) this.country = country;
                    },
                    onStateChanged: (state) {
                      stateSelected = true;
                      if (state != null) this.state = state;
                    },
                    defaultCountry: DefaultCountry.Colombia,
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              CustomForm(
                labelText: "Dirección",
                formField: "address",
                formValues: formValues,
                inputType: TextInputType.streetAddress,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Ingrese un valor valido";
                  }
                  address = value;
                  this.address = address;
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 50,
                width: 200,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(ThemeApp.appRed),
                  ),
                  onPressed: () {
                    if (stateSelected && countrySelected && citySelected && !address.isEmpty) {
                      currentPractitioner.addPaymentMethod(expiryDate, cardHolderName, cvvCode, address, country, state, city, cardNumber);
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    "Agregar",
                    style: GoogleFonts.rubik(),
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

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
