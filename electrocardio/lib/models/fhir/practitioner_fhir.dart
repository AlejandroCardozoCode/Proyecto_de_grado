import 'package:electrocardio/models/fhir/app_fhir_clases.dart';
import 'package:electrocardio/models/fhir/diagnostic_report_fhir.dart';
import 'package:electrocardio/models/fhir/observation_fhir.dart';
import 'package:electrocardio/models/fhir/patient_fhir.dart';
import 'package:fhir/r4.dart' as r4;
import 'package:flutter/cupertino.dart';

import '../../communicators/all_communicator.dart';
import '../../services/services.dart';

class AppPractitioner with ChangeNotifier {
  late String active;
  late String id;
  late String idFirebase;
  late String firstName;
  late String lastName;
  late String email;
  late String address;
  late String gender;
  late String birthDate;
  late String role;
  late String imgUrl;

  late r4.Practitioner r4Class;

  late List<AppPatient> patientList = [];
  late List<AppObservation> observationList = [];
  late List<AppDiagosticReport> diagnosticList = [];

  AppPractitioner() {}

  clearValues() {
    active = "";
    id = "";
    idFirebase = "";
    firstName = "";
    lastName = "";
    email = "";
    address = "";
    gender = "";
    birthDate = "";
    role = "";
    imgUrl = "";
  }

  loadPractitionerData() {
    generateDiagnostic();
    generateObservations();
    generatePatients();
  }

  generatePatients() async {
    PatientService patientService = PatientService();
    List<AppPatient> allPatients = await patientService.loadPatients();
    this.patientList.clear();
    allPatients.forEach((patient) {
      if (patient.practitionerId == this.id) {
        patientList.add(patient);
      }
    });
    notifyListeners();
  }

  generateObservations() async {
    ObservationService observationService = ObservationService();
    List<AppObservation> allObservations = await observationService.loadObservations();
    this.observationList.clear();
    allObservations.forEach((observation) {
      if (observation.practitionerIdReference == this.id) {
        observationList.add(observation);
      }
    });
    notifyListeners();
  }

  generateDiagnostic() async {
    DiagnosticReportService diagnosticReportService = DiagnosticReportService();
    List<AppDiagosticReport> allDiagnostics = await diagnosticReportService.loadDiagnosticReports();
    this.diagnosticList.clear();
    allDiagnostics.forEach((diagnostic) {
      if (diagnostic.practitionerIdReferenceOnco == this.id) {
        diagnosticList.add(diagnostic);
      }
    });

    notifyListeners();
  }

  void loadFromYaml(String practitionerYaml) async {
    r4.Practitioner practitioner = r4.Practitioner.fromYaml(practitionerYaml);
    active = practitioner.active.toString();
    id = practitioner.identifier![0].value!;
    idFirebase = practitioner.identifier![1].value!;
    firstName = practitioner.name![0].given![0];
    lastName = practitioner.name![0].family!;
    email = practitioner.telecom![0].value!;
    address = practitioner.address![0].text!;
    gender = practitioner.gender!.value!;
    birthDate = practitioner.birthDate.toString();
    imgUrl = practitioner.photo![0].data.toString();
    role = practitioner.qualification![0].code.text!;
    await Future.delayed(const Duration(microseconds: 1));
    notifyListeners();
  }

  create() {
    final practitioner = r4.Practitioner(
      active: r4.Boolean(active),
      identifier: <r4.Identifier>[
        r4.Identifier(value: id),
        r4.Identifier(value: idFirebase),
      ],
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
          data: r4.Base64Binary(imgUrl),
        )
      ],
      qualification: <r4.PractitionerQualification>[
        r4.PractitionerQualification(
            code: r4.CodeableConcept(
          text: role,
        ))
      ],
    );
    this.r4Class = practitioner;
  }

  uploadToFirebase(String uId) {
    //Firebase
    final PractitionerService practitionerService = PractitionerService();
    AllCommunicator practitionerComunicator = AllCommunicator(yaml: this.r4Class.toYaml());
    practitionerComunicator.id = uId;
    practitionerComunicator.isNew = true;
    practitionerService.createNewPractitioner(practitionerComunicator);
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
    var observationFound = observationList.where((element) => element.observationId == id);
    if (observationFound.isNotEmpty) {
      return observationFound.first;
    } else {
      return null;
    }
  }

  findDiagnosticById(String diagnosticId) {
    var diagnosticFound = diagnosticList.where((element) => element.id == diagnosticId);
    if (diagnosticFound.isNotEmpty) {
      return diagnosticFound.first;
    } else {
      return null;
    }
  }
}
