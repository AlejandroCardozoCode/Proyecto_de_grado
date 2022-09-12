import 'package:electrocardio/models/fhir/patient_contact_fhir.dart';
import 'package:fhir/r4.dart' as r4;
import 'package:flutter/cupertino.dart';

class AppPatient with ChangeNotifier {
  late String id;
  late String firstName;
  late String lastName;
  late String phone;
  late String gender;
  late String birthDate;
  late String address;
  late String maritalCode;
  late String maritalText;
  late AppPatientContact emergencyContact;
  late r4.Patient patientFHIR;
  AppPatient();
  void setPatient(AppPatient patient) {
    id = patient.id;
    firstName = patient.firstName;
    lastName = patient.lastName;
    phone = patient.phone;
    gender = patient.gender;
    birthDate = patient.birthDate;
    address = patient.address;
    maritalCode = patient.maritalCode;
    maritalText = patient.maritalText;
  }

  void setValues(
    id,
    firstName,
    lastName,
    phone,
    gender,
    birthDate,
    address,
    maritalCode,
    maritalText,
  ) {
    this.id = id;
    this.firstName = firstName;
    this.lastName = lastName;
    this.phone = phone;
    this.gender = gender;
    this.birthDate = birthDate;
    this.address = address;
    this.maritalCode = maritalCode;
    this.maritalText = maritalText;
  }

  addEmergencyContact(AppPatientContact contact) {
    emergencyContact = contact;
  }

  r4.Patient generateFhirPatient() {
    final patient = r4.Patient(
      active: r4.Boolean("true"),
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
          system: r4.ContactPointSystem.phone,
          value: phone,
        ),
      ],
      gender: r4.Code(gender),
      birthDate: r4.Date(birthDate),
      address: <r4.Address>[
        r4.Address(
          use: r4.AddressUse.home,
          type: r4.AddressType.both,
          text: address,
        )
      ],
      maritalStatus: r4.CodeableConcept(
        coding: <r4.Coding>[
          r4.Coding(
            display: maritalCode,
          ),
        ],
        text: maritalText,
      ),
      contact: <r4.PatientContact>[
        r4.PatientContact(
          relationship: <r4.CodeableConcept>[
            r4.CodeableConcept(
              coding: <r4.Coding>[
                r4.Coding(
                  display: emergencyContact.contactCode,
                )
              ],
              text: emergencyContact.contactTextCode,
            ),
          ],
          name: r4.HumanName(
            use: r4.HumanNameUse.official,
            given: [emergencyContact.contactFirstName],
            family: emergencyContact.contactLastName,
          ),
          telecom: <r4.ContactPoint>[
            r4.ContactPoint(
              use: r4.ContactPointUse.work,
              system: r4.ContactPointSystem.phone,
              value: emergencyContact.contactPhone,
            ),
          ],
          gender: r4.Code(emergencyContact.contactGender),
          address: r4.Address(
            use: r4.AddressUse.home,
            type: r4.AddressType.both,
            text: emergencyContact.contactAddress,
          ),
        ),
      ],
    );
    this.patientFHIR = patient;
    return patient;
  }
}
