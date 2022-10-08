import 'package:fhir/r4.dart' as r4;
import 'package:flutter/cupertino.dart';

class AppPatientContact with ChangeNotifier {
  late String contactRelationCode;
  late String contactFirstName;
  late String contactLastName;
  late String contactPhone;
  late String contactGender;
  late String contactAddress;

  AppPatientContact() {
    contactRelationCode = "None";
    contactFirstName = "None";
    contactLastName = "None";
    contactPhone = "None";
    contactGender = "None";
    contactAddress = "None";
  }
  void setPatient(AppPatientContact patient) {
    contactRelationCode = patient.contactRelationCode;
    contactFirstName = patient.contactFirstName;
    contactLastName = patient.contactLastName;
    contactPhone = patient.contactPhone;
    contactGender = patient.contactGender;
    contactAddress = patient.contactAddress;
  }

  void setValues(
    contactRelationCode,
    contactFirstName,
    contactLastName,
    contactPhone,
    contactGender,
    contactAddress,
  ) {
    this.contactRelationCode = contactRelationCode;
    this.contactFirstName = contactFirstName;
    this.contactLastName = contactLastName;
    this.contactPhone = contactPhone;
    this.contactGender = contactGender;
    this.contactAddress = contactAddress;
  }

  r4.PatientContact generateFhirPatientContact() {
    final patient = r4.PatientContact(
      relationship: <r4.CodeableConcept>[
        r4.CodeableConcept(
          coding: <r4.Coding>[
            r4.Coding(
              display: contactRelationCode,
            )
          ],
        ),
      ],
      name: r4.HumanName(
        use: r4.HumanNameUse.official,
        given: [contactFirstName],
        family: contactLastName,
      ),
      telecom: <r4.ContactPoint>[
        r4.ContactPoint(
          use: r4.ContactPointUse.work,
          system: r4.ContactPointSystem.phone,
          value: contactPhone,
        ),
      ],
      gender: r4.Code(contactGender),
      address: r4.Address(
        use: r4.AddressUse.home,
        type: r4.AddressType.both,
        text: contactAddress,
      ),
    );
    return patient;
  }
}
