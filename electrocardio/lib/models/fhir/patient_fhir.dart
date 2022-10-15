import 'package:electrocardio/models/fhir/patient_contact_fhir.dart';
import 'package:electrocardio/services/patient_service.dart';
import 'package:fhir/r4.dart' as r4;
import 'package:flutter/cupertino.dart';

import '../../communicators/all_communicator.dart';

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
  late String practitionerId;
  late AppPatientContact emergencyContact;
  late r4.Patient patientFHIR;
  AppPatient();

  void loadFromJson(Map<String, dynamic> patientYaml) {
    r4.Patient patient = r4.Patient.fromJson(patientYaml);
    id = patient.identifier![0].value!;
    firstName = patient.name![0].given![0];
    lastName = patient.name![0].family!;
    phone = patient.telecom![0].value!;
    gender = patient.gender!.value!;
    birthDate = patient.birthDate!.valueString;
    address = patient.address![0].text!;
    maritalCode = patient.maritalStatus!.coding![0].display!;
    maritalText = patient.maritalStatus!.text!;
    practitionerId = patient.generalPractitioner![0].reference!;
  }

  void clearValues() {
    id = "";
    firstName = "";
    lastName = "";
    phone = "";
    gender = "";
    birthDate = "";
    address = "";
    maritalCode = "";
    maritalText = "";
    practitionerId = "";
  }

  void setPatientValues(
    id,
    firstName,
    lastName,
    phone,
    gender,
    birthDate,
    address,
    maritalCode,
    maritalText,
    practitionerId,
    emergencyContact,
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
    this.practitionerId = practitionerId;
    this.emergencyContact = emergencyContact;
  }

  AppPatient copyPatient(AppPatient patient) {
    this.id = patient.id;
    this.firstName = patient.firstName;
    this.lastName = patient.lastName;
    this.phone = patient.phone;
    this.gender = patient.gender;
    this.birthDate = patient.birthDate;
    this.address = patient.address;
    this.maritalCode = patient.maritalCode;
    this.maritalText = patient.maritalText;
    this.practitionerId = patient.practitionerId;
    return this;
  }

  addEmergencyContact(AppPatientContact contact) {
    emergencyContact = contact;
  }

  uploadToFirebase(String uId) async {
    //Firebase
    final PatientService patientService = PatientService();
    AllCommunicator patientComunicator = AllCommunicator(jsonVar: this.patientFHIR.toJson());
    patientComunicator.id = uId;
    patientComunicator.isNew = true;
    await patientService.createNewpatient(patientComunicator);
  }

  void create() {
    final patient = r4.Patient(
      generalPractitioner: <r4.Reference>[
        r4.Reference(
          reference: practitionerId,
          type: r4.FhirUri("Practitioner"),
        ),
      ],
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
                  code: r4.Code(emergencyContact.contactRelationCode),
                )
              ],
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
    patientFHIR = patient;
  }
}
