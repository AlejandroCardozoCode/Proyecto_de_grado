// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester

import 'dart:convert';

import 'package:electrocardio/main.dart';
import 'package:electrocardio/models/fhir/app_fhir_clases.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Create practitioner', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    AppPractitioner testPractitioner = createTestPractitioner();
    testPractitioner.create();
    testPractitioner.uploadToFirebase(testPractitioner.idFirebase, testPractitioner.role);
  });
  testWidgets('Create full patient', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    AppPatient testPatient = createTestPatient();
    testPatient.create();
    testPatient.uploadToFirebase(testPatient.id);
  });
  testWidgets('Create simple patient', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    AppPatient testPatient = createSimpleTestPatient();

    testPatient.create();
    testPatient.uploadToFirebase(testPatient.id);
  });
  testWidgets('Create observation', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    AppPractitioner testPractitioner = createTestPractitioner();
    AppPatient testPatient = createSimpleTestPatient();
    AppObservation testObservation = createTestObservation(testPatient, testPractitioner);

    testObservation.create();
    testObservation.uploadToFirebase(testObservation.observationId);
  });
  testWidgets('Create diagnostic', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    AppPractitioner testPractitioner = createTestPractitioner();
    AppPatient testPatient = createSimpleTestPatient();
    AppObservation testObservation = createTestObservation(testPatient, testPractitioner);

    AppDiagnosticReport testDiagnostic = createTestDiagnostic(testObservation, testPractitioner, testPatient);
    testDiagnostic.create();
    testDiagnostic.uploadToFirebase(testDiagnostic.observationId);
  });

  testWidgets('Obtain practitioner', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    AppPractitioner testPractitioner = AppPractitioner();
    Map<String, dynamic> map = await json.decode(
        "{\"active\":\"true\",\"address\":[{\"text\":\"Calle200\",\"type\":\"both\",\"use\":\"home\"}],\"birthDate\":\"2022-11-6\",\"gender\":\"male\",\"identifier\":[{\"value\":\"6464646\"},{\"value\":\"zf5Fl0kWARRCyf03ZqFVFJbruzC2\"}],\"name\":[{\"family\":\"Giraldo\",\"given\":[\"Estiben\"],\"use\":\"official\"}],\"photo\":[{\"data\":\"\"}],\"qualification\":[{\"code\":{\"text\":\"Cardiologo\"}}],\"resourceType\":\"Practitioner\",\"telecom\":[{\"system\":\"email\",\"use\":\"work\",\"value\":\"d.alejandro198@gmail.com\"}]}");
    testPractitioner.loadFromJson(map);
  });
}

AppPractitioner createTestPractitioner() {
  AppPractitioner testPractitioner = AppPractitioner();
  testPractitioner.active = "true";
  testPractitioner.id = "idTest";
  testPractitioner.idFirebase = "LbDfjlsalaj3taNO961ntKDbSCz2";
  testPractitioner.firstName = "NameTest";
  testPractitioner.lastName = "LastTest";
  testPractitioner.email = "TestEmail";
  testPractitioner.address = "AddressTest";
  testPractitioner.gender = "male";
  testPractitioner.birthDate = "10/12/1998";
  testPractitioner.role = "Oncologo";
  testPractitioner.imgUrl = "ImageDataTest";
  return testPractitioner;
}

AppPatient createTestPatient() {
  AppPatient testPatient = AppPatient();
  testPatient.id = "1111111";
  testPatient.firstName = "firstTest";
  testPatient.lastName = "lastNameTest";
  testPatient.phone = "00000000";
  testPatient.gender = "male";
  testPatient.birthDate = "31/12/1998";
  testPatient.address = "addressTest";
  testPatient.maritalCode = "UNK";
  testPatient.maritalText = "Desconocido";
  testPatient.practitionerId = "practitionerIdTest";

  //contact information
  AppPatientContact patientContact = AppPatientContact();
  patientContact.contactRelationCode = "UNK";
  patientContact.contactFirstName = "firstTest";
  patientContact.contactLastName = "lastTest";
  patientContact.contactPhone = "0000000000";
  patientContact.contactGender = "male";
  patientContact.contactAddress = "addressTest";

  testPatient.emergencyContact = patientContact;

  return testPatient;
}

AppPatient createSimpleTestPatient() {
  AppPatient testPatient = AppPatient();
  testPatient.id = "1111111";
  testPatient.firstName = "1111111";
  testPatient.lastName = "1111111";
  testPatient.phone = "11111111";
  testPatient.gender = "male";
  testPatient.birthDate = "31/12/1998";
  testPatient.address = "11111111";
  testPatient.maritalCode = "UNK";
  testPatient.maritalText = "Desconocido";
  testPatient.practitionerId = "practitionerIdTest";
  AppPatientContact patientContact = AppPatientContact();
  patientContact.contactRelationCode = "UNK";
  patientContact.contactFirstName = "1111111";
  patientContact.contactLastName = "1111111";
  patientContact.contactPhone = "1111111";
  patientContact.contactGender = "11111111";
  patientContact.contactAddress = "11111111";

  testPatient.emergencyContact = patientContact;

  return testPatient;
}

AppObservation createTestObservation(AppPatient testPatient, AppPractitioner testPractitioner) {
  AppObservation testObservation = AppObservation();
  testObservation.observationId = "87aed173-695d-49ef-95a5-2963ad53657e";
  testObservation.patientIdReference = testPatient.id;
  testObservation.practitionerIdReference = testPractitioner.id;
  testObservation.dateTime = "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}";
  testObservation.actualObservation = "";

  return testObservation;
}

AppDiagnosticReport createTestDiagnostic(AppObservation testObservation, AppPractitioner testPractitioner, AppPatient testPatient) {
  AppDiagnosticReport testDiagnostic = AppDiagnosticReport();
  testDiagnostic.id = "c8bf017d-a099-4430-834d-ecca82949e0d";
  testDiagnostic.patientIdReference = testPatient.id;
  testDiagnostic.dateTime = "";
  testDiagnostic.practitionerIdReferenceOnco = testPatient.practitionerId;
  testDiagnostic.practitionerIdReferenceCardio = testPractitioner.id;
  testDiagnostic.observationId = testObservation.observationId;
  testDiagnostic.imageReference = "ImageData";
  testDiagnostic.diagnostic = "diagnostic text";
  testDiagnostic.priority = "TOP";
  testDiagnostic.status = "final";

  return testDiagnostic;
}
