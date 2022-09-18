import 'package:electrocardio/models/fhir/diagnostic_report_fhir.dart';
import 'package:electrocardio/models/fhir/observation_fhir.dart';
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

  late List<AppPatient> patientList = [];
  late List<AppObservation> observationList = [];
  late List<AppDiagosticReport> diagnosticList = [];

  addPatientToList(AppPatient patient) {
    patientList.add(patient);
  }

  generatePatients() {
    AppPatient newPatient = AppPatient();
    newPatient.setPatientValues(
      "123123",
      "Estiben",
      "Giraldo",
      "319192929",
      "Hombre",
      "12-12-2001",
      "calle 100",
      "F2",
      "Casado",
      this.id,
    );
    patientList.insert(0, newPatient);
    newPatient = AppPatient();
    newPatient.setPatientValues(
      "456456",
      "diego",
      "Giraldo",
      "319192929",
      "Hombre",
      "12-12-2001",
      "calle 100",
      "F2",
      "Casado",
      this.id,
    );
    patientList.insert(0, newPatient);
  }

  void loadFromYaml(String practitionerYaml) async {
    r4.Practitioner practitioner = r4.Practitioner.fromYaml(practitionerYaml);
    active = practitioner.active.toString();
    id = practitioner.identifier![0].value!;
    firstName = practitioner.name![0].given![0];
    lastName = practitioner.name![0].family!;
    email = practitioner.telecom![0].value!;
    address = practitioner.address![0].text!;
    gender = practitioner.gender!.value!;
    birthDate = practitioner.birthDate.toString();
    imgUrl = practitioner.photo![0].url.toString();
    role = practitioner.qualification![0].code.text!;
    await Future.delayed(const Duration(microseconds: 1));
    notifyListeners();
  }

  create({
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
      photo: <r4.Attachment>[
        r4.Attachment(
          url: r4.FhirUrl(imgUrl),
        )
      ],
      qualification: <r4.PractitionerQualification>[
        r4.PractitionerQualification(
            code: r4.CodeableConcept(
          text: role,
        ))
      ],
    );

    loadFromYaml(practitioner.toYaml());
    await Future.delayed(const Duration(microseconds: 1));
    notifyListeners();
    return practitioner.toYaml();
  }

  AppPatient? findPatientById(String patientId) {
    var patientFound = patientList.where((element) => element.id == patientId);
    if (patientFound.isNotEmpty) {
      return patientFound.first;
    } else {
      return null;
    }
  }

  AppObservation? findObservationById(String id) {
    var observationFound =
        observationList.where((element) => element.observationId == id);
    if (observationFound.isNotEmpty) {
      return observationFound.first;
    } else {
      return null;
    }
  }

  findDiagnosticById(String diagnosticId) {
    var diagnosticFound =
        diagnosticList.where((element) => element.id == diagnosticId);
    if (diagnosticFound.isNotEmpty) {
      return diagnosticFound.first;
    } else {
      return null;
    }
  }

  void addObservation(AppObservation currentObservation) {
    AppObservation observation = AppObservation().copy(currentObservation);
    observationList.insert(0, observation);
  }

  void addDiagnostic(AppDiagosticReport currentDiagnostic) {
    AppDiagosticReport diagnostic =
        AppDiagosticReport().copy(currentDiagnostic);
    diagnosticList.insert(0, diagnostic);
  }

  void diagnosticTestValues() {
    AppObservation observation = AppObservation();
    observation.observationId = "obs1";
    observation.patientIdReference = "testtest";
    observation.practitionerIdReference = "testtest";
    observation.dateTime = "2022-02";
    observation.actualObservation =
        "Dolor voluptua clita eos takimata sed rebum rebum takimata dolores. Labore accusam consetetur lorem sea eos kasd, et gubergren justo voluptua nonumy duo dolores erat. Diam kasd est sanctus magna et labore vero aliquyam, magna lorem sed lorem invidunt duo stet sanctus diam. Elitr accusam sea ipsum takimata, lorem et.";
    addObservation(observation);

    AppDiagosticReport diagnostic = AppDiagosticReport();
    diagnostic.id = "diag1";
    diagnostic.patientIdReference = "testtest";
    diagnostic.dateTime = "2022-02";
    diagnostic.practitionerIdReferenceOnco = "testtest";
    diagnostic.practitionerIdReferenceCardio = "testtest";
    diagnostic.observationId = "obs1";
    diagnostic.imageReference = "testtest";
    diagnostic.diagnostic = "";
    addDiagnostic(diagnostic);
  }
}
