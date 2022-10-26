import 'dart:developer';

import 'package:electrocardio/services/keys_service.dart';
import 'package:mailjet/mailjet.dart';

class EmailService {
  late String apiKey;
  late String secretKey;
  late String myEmail = "electrocardiotelegraph@gmail.com";

  Future<void> sendEmail(String emailReceiver, String name) async {
    log(emailReceiver);
    apiKey = await obtainEmailApi();
    secretKey = await obtainEmailSecretKey();
    MailJet mailJet = MailJet(
      apiKey: apiKey,
      secretKey: secretKey,
    );
    String response = await mailJet.sendEmail(
      subject: "Electrocardio Telegraph nuevo reporte",
      sender: Sender(
        email: myEmail,
        name: "Soporte",
      ),
      reciepients: [
        Recipient(
          email: emailReceiver,
          name: name,
        ),
      ],
      htmlEmail: "<h3>Hola ${name}</h3><br />Se le informa que se la ha asignado un nuevo diagnóstico para que sea respondido en Electrocardio Telegraph, por favor de su diagnostico lo antes posible",
    );
    log(response);
  }
}
