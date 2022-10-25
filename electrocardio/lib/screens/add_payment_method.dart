import 'package:csc_picker/csc_picker.dart';
import 'package:electrocardio/theme/theme.dart';
import 'package:electrocardio/widgets/custom_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class AddPaymentMethod extends StatefulWidget {
  AddPaymentMethod({super.key});

  @override
  State<AddPaymentMethod> createState() => _AddPaymentMethodState();
}

class _AddPaymentMethodState extends State<AddPaymentMethod> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool useGlassMorphism = false;
  bool useBackgroundImage = false;
  OutlineInputBorder? border;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Map<String, String> formValues = {
    "cardNumber": "",
    "ownerName": "",
    "date": "",
    "cvc": "",
  };

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.all(20),
          child: SingleChildScrollView(
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
                /*
                CreditCardWidget(
                  cardNumber: this.cardNumber,
                  expiryDate: "",
                  cardHolderName: "",
                  cvvCode: "",
                  cardBgColor: ThemeApp.appRed,
                  showBackView: false, onCreditCardWidgetChange: (CreditCardBrand) {}, //true when you want to show cvv(back) view
                ),
                creditCardForm(context),
                Container(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: Text(
                    "Información de dirección",
                    style: GoogleFonts.rubik(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                */
                CreditCardWidget(
                  cardNumber: cardNumber,
                  expiryDate: expiryDate,
                  cardHolderName: cardHolderName,
                  cvvCode: cvvCode,
                  bankName: 'Axis Bank',
                  showBackView: true,
                  obscureCardNumber: true,
                  obscureCardCvv: true,
                  isHolderNameVisible: true,
                  cardBgColor: Colors.red,
                  isSwipeGestureEnabled: true,
                  onCreditCardWidgetChange: (CreditCardBrand creditCardBrand) {},
                ),
                Column(
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
                      textColor: Colors.white,
                      cardNumberDecoration: InputDecoration(
                        labelText: 'Number',
                        hintText: 'XXXX XXXX XXXX XXXX',
                        hintStyle: const TextStyle(color: Colors.white),
                        labelStyle: const TextStyle(color: Colors.white),
                        focusedBorder: border,
                        enabledBorder: border,
                      ),
                      expiryDateDecoration: InputDecoration(
                        hintStyle: const TextStyle(color: Colors.white),
                        labelStyle: const TextStyle(color: Colors.white),
                        focusedBorder: border,
                        enabledBorder: border,
                        labelText: 'Expired Date',
                        hintText: 'XX/XX',
                      ),
                      cvvCodeDecoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        errorMaxLines: 2,
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      cardHolderDecoration: InputDecoration(
                        hintStyle: const TextStyle(color: Colors.white),
                        labelStyle: const TextStyle(color: Colors.white),
                        focusedBorder: border,
                        enabledBorder: border,
                        labelText: 'Card Holder',
                      ),
                      onCreditCardModelChange: onCreditCardModelChange,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          'Glassmorphism',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          'Card Image',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        backgroundColor: const Color(0xff1b447b),
                      ),
                      child: Container(
                        margin: const EdgeInsets.all(12),
                        child: const Text(
                          'Validate',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'halter',
                            fontSize: 14,
                            package: 'flutter_credit_card',
                          ),
                        ),
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          print('valid!');
                        } else {
                          print('invalid!');
                        }
                      },
                    ),
                  ],
                ),
                Card(
                  shadowColor: ThemeApp.primary,
                  elevation: 2.5,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: CSCPicker(
                      onCityChanged: (value) {},
                      onCountryChanged: (value) {},
                      onStateChanged: (value) {},
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
                  inputType: TextInputType.number,
                  validator: (value) {
                    if (value!.length < 3 || value.isEmpty || value.length > 3) {
                      return "Ingrese un valor valido";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
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

  Widget creditCardForm(BuildContext context) {
    return Column(
      children: [
        CustomForm(
          labelText: "Nombre titular",
          formField: "ownerName",
          formValues: formValues,
          inputType: TextInputType.name,
          validator: (value) {
            return;
          },
        ),
        SizedBox(
          height: 20,
        ),
        CustomForm(
          labelText: "Numero de tarjeta",
          formField: "creditCard",
          formValues: formValues,
          inputType: TextInputType.number,
          validator: (value) {
            if (value!.length != 16) {
              return "Ingrese un numero valido";
            } else {
              this.cardNumber = value;
            }
            return null;
          },
        ),
        SizedBox(
          height: 20,
        ),
        FittedBox(
          child: Row(
            children: [
              Container(
                width: 200,
                child: CustomForm(
                  labelText: "Fecha expiración",
                  formField: "creditCard",
                  formValues: formValues,
                  inputType: TextInputType.number,
                  validator: (value) {
                    if (value!.length < 16) {
                      return "Ingrese un numero valido";
                    }
                    return null;
                  },
                ),
              ),
              Container(
                width: 200,
                child: CustomForm(
                  labelText: "CVC",
                  formField: "creditCard",
                  formValues: formValues,
                  inputType: TextInputType.number,
                  validator: (value) {
                    if (value!.length < 3 || value.isEmpty || value.length > 3) {
                      return "Ingrese un valor valido";
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget addressForm() {
    return Column(
      children: [
        CustomForm(
          labelText: "Ciudad",
          formField: "city",
          formValues: formValues,
          inputType: TextInputType.number,
          validator: (value) {
            if (value!.length < 3 || value.isEmpty || value.length > 3) {
              return "Ingrese un valor valido";
            }
            return null;
          },
        ),
        SizedBox(
          height: 20,
        ),
        CustomForm(
          labelText: "CVC",
          formField: "creditCard",
          formValues: formValues,
          inputType: TextInputType.number,
          validator: (value) {
            if (value!.length < 3 || value.isEmpty || value.length > 3) {
              return "Ingrese un valor valido";
            }
            return null;
          },
        ),
        SizedBox(
          height: 20,
        ),
        CustomForm(
          labelText: "CVC",
          formField: "creditCard",
          formValues: formValues,
          inputType: TextInputType.number,
          validator: (value) {
            if (value!.length < 3 || value.isEmpty || value.length > 3) {
              return "Ingrese un valor valido";
            }
            return null;
          },
        ),
        SizedBox(
          height: 20,
        ),
        CustomForm(
          labelText: "CVC",
          formField: "creditCard",
          formValues: formValues,
          inputType: TextInputType.number,
          validator: (value) {
            if (value!.length < 3 || value.isEmpty || value.length > 3) {
              return "Ingrese un valor valido";
            }
            return null;
          },
        ),
        SizedBox(
          height: 20,
        ),
        CustomForm(
          labelText: "CVC",
          formField: "creditCard",
          formValues: formValues,
          inputType: TextInputType.number,
          validator: (value) {
            if (value!.length < 3 || value.isEmpty || value.length > 3) {
              return "Ingrese un valor valido";
            }
            return null;
          },
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
