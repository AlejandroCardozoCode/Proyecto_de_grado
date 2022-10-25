import 'package:electrocardio/models/fhir/app_fhir_clases.dart';
import 'package:electrocardio/models/payment/payment_method.dart';
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
  late List<AppDiagnosticReport> diagnosticList = [];

  List<PaymentMethod> paymentMethodList = [];
  PatientService patientService = PatientService();
  ObservationService observationService = ObservationService();
  DiagnosticReportService diagnosticReportService = DiagnosticReportService();

  AppPractitioner() {}

  void addPaymentMethod(
    String expiryDate,
    String cardHolderName,
    String cvvCode,
    String address,
    String country,
    String state,
    String city,
  ) {
    PaymentMethod paymentMethod = PaymentMethod(expiryDate, cardHolderName, cvvCode, address, country, state, city);
    this.paymentMethodList.add(paymentMethod);
    notifyListeners();
  }

  void loadFromJson(Map<String, dynamic> practitionerYaml) async {
    r4.Practitioner practitioner = r4.Practitioner.fromJson(practitionerYaml);
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

  loadPractitionerOncoData() async {
    final result = await Future.wait([
      patientService.loadPatients(this.idFirebase),
      observationService.loadObservations(this.idFirebase),
      diagnosticReportService.loadDiagnosticReports(this.idFirebase),
    ]);
    this.patientList.clear();
    this.observationList.clear();
    this.diagnosticList.clear();

    if (result[0] != null) {
      result[0].forEach((patient) {
        if (patient.practitionerId == this.idFirebase) {
          patientList.add(patient);
        }
      });
    }

    if (result[1] != null) {
      result[1].forEach((observation) {
        if (observation.practitionerIdReference == this.idFirebase) {
          observationList.add(observation);
        }
      });
    }

    if (result[2] != null) {
      result[2].forEach((diagnostic) {
        if (diagnostic.practitionerIdReferenceOnco == this.idFirebase) {
          diagnosticList.add(diagnostic);
        }
      });
    }
    notifyListeners();
  }

  loadPractitionerCardioData() async {
    final result = await Future.wait([
      diagnosticReportService.loadDiagnosticReports(this.idFirebase),
      observationService.loadObservations(this.idFirebase),
    ]);

    this.diagnosticList.clear();
    this.observationList.clear();
    List<AppDiagnosticReport> topList = [];
    List<AppDiagnosticReport> midList = [];
    List<AppDiagnosticReport> lowList = [];

    if (result[0] != null) {
      result[0].forEach(
        (diagnostic) {
          if (diagnostic.diagnostic == "") {
            if (diagnostic.priority.substring(0, 3) == "TOP") {
              topList.add(diagnostic);
            } else if (diagnostic.priority.substring(0, 3) == "MID") {
              midList.add(diagnostic);
            } else {
              lowList.add(diagnostic);
            }
            ;
          }
        },
      );
      diagnosticList.addAll(topList);
      diagnosticList.addAll(midList);
      diagnosticList.addAll(lowList);
    }

    if (result[1] != null) {
      this.observationList.addAll(result[1]);
    }
    notifyListeners();
  }

  generatePatients() async {
    List<AppPatient> allPatients = await patientService.loadPatients(this.idFirebase);
    this.patientList.clear();
    allPatients.forEach((patient) {
      if (patient.practitionerId == this.idFirebase) {
        patientList.add(patient);
      }
    });
    notifyListeners();
  }

  generateObservations() async {
    List<AppObservation> allObservations = await observationService.loadObservations(this.idFirebase);
    this.observationList.clear();
    this.observationList.addAll(allObservations);
    notifyListeners();
  }

  generateDiagnostic() async {
    List<AppDiagnosticReport> allDiagnostics = await diagnosticReportService.loadDiagnosticReports(this.idFirebase);
    this.diagnosticList.clear();
    this.diagnosticList.addAll(allDiagnostics);
    notifyListeners();
  }

  generateDiagnosticCardio() async {
    List<AppDiagnosticReport> allDiagnostics = await diagnosticReportService.loadDiagnosticReports(this.idFirebase);
    this.diagnosticList.clear();
    List<AppDiagnosticReport> topList = [];
    List<AppDiagnosticReport> midList = [];
    List<AppDiagnosticReport> lowList = [];
    allDiagnostics.forEach(
      (diagnostic) {
        if (diagnostic.status == "partial") {
          if (diagnostic.priority.substring(0, 3) == "TOP") {
            topList.add(diagnostic);
          } else if (diagnostic.priority.substring(0, 3) == "MID") {
            midList.add(diagnostic);
          } else {
            lowList.add(diagnostic);
          }
          ;
        }
      },
    );
    diagnosticList.addAll(topList);
    diagnosticList.addAll(midList);
    diagnosticList.addAll(lowList);
    notifyListeners();
  }

  generateObservationsCardio() async {
    List<AppObservation> allObservations = await observationService.loadObservations(this.idFirebase);
    this.observationList.clear();
    this.observationList.addAll(allObservations);
    notifyListeners();
  }

  addObservationToList(AppObservation observation) {
    AppObservation newObservation = AppObservation().copy(observation);
    this.observationList.add(newObservation);
    notifyListeners();
  }

  addDiagnosticToList(AppDiagnosticReport diagnosticReport) {
    AppDiagnosticReport newDiagnostic = AppDiagnosticReport().copy(diagnosticReport);
    this.diagnosticList.add(newDiagnostic);
    notifyListeners();
  }

  addPatientToList(AppPatient patient) {
    AppPatient newPatient = AppPatient().copyPatient(patient);
    this.patientList.add(newPatient);
    notifyListeners();
  }

  removeDiagnosticFromList(AppDiagnosticReport diagnosticReport) {
    this.diagnosticList.removeWhere((AppDiagnosticReport element) => element.id == diagnosticReport.id);
    notifyListeners();
  }

  uploadToFirebase(String uId, String role) async {
    //Firebase
    final PractitionerService practitionerService = PractitionerService();
    AllCommunicator practitionerCommunicator = AllCommunicator(jsonVar: this.r4Class.toJson());
    practitionerCommunicator.id = uId;
    practitionerCommunicator.isNew = true;
    await practitionerService.createPractitioner(practitionerCommunicator, role);
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
