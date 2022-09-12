import 'package:electrocardio/models/fhir/patient_fhir.dart';
import 'package:fhir/r4.dart' as r4;
import 'package:flutter/cupertino.dart';

class AppPractitioner with ChangeNotifier {
  late String active;
  late String id;
  late String firstName;
  late String lastName;
  late String email;
  late String address;
  late String gender;
  late String birthDate;
  late String role;
  late String imgUrl;
  late r4.Practitioner practitionerFHIR;

  late List<AppPatient> patientList = [];

  addPatientToList(AppPatient patient) {
    patientList.add(patient);
  }

  generatePatients() {
    AppPatient newPatient = AppPatient();
    newPatient.setValues(
      "123123",
      "Estiben",
      "Giraldo",
      "319192929",
      "Hombre",
      "12-12-2001",
      "calle 100",
      "F2",
      "Casado",
    );
    patientList.add(newPatient);
    newPatient = AppPatient();
    newPatient.setValues(
      "456456",
      "diego",
      "Giraldo",
      "319192929",
      "Hombre",
      "12-12-2001",
      "calle 100",
      "F2",
      "Casado",
    );
    patientList.add(newPatient);
  }

  Future<void> setValues({
    required active,
    required id,
    required firstName,
    required lastName,
    required email,
    required address,
    required gender,
    required birthDate,
    required role,
    required imgUrl,
  }) async {
    this.active = active;
    this.id = id;
    this.firstName = firstName;
    this.lastName = lastName;
    this.email = email;
    this.address = address;
    this.gender = gender;
    this.birthDate = birthDate;
    this.role = role;
    this.imgUrl = imgUrl;
    await Future.delayed(const Duration(microseconds: 1));
    notifyListeners();
  }

  r4.Practitioner get generatePractitioner {
    final practitioner = r4.Practitioner(
      active: r4.Boolean(active),
      identifier: <r4.Identifier>[r4.Identifier(value: id)],
      name: <r4.HumanName>[
        r4.HumanName(
          use: r4.HumanNameUse.official,
          given: [firstName],
          family: lastName,
        ),
      ],
      telecom: <r4.ContactPoint>[
        r4.ContactPoint(
          use: r4.ContactPointUse.work,
          system: r4.ContactPointSystem.email,
          value: email,
        ),
      ],
      address: <r4.Address>[
        r4.Address(
          use: r4.AddressUse.home,
          type: r4.AddressType.both,
          text: address,
        )
      ],
      gender: r4.Code(gender),
      birthDate: r4.Date(birthDate),
    );
    practitionerFHIR = practitioner;
    return practitioner;
  }
}
