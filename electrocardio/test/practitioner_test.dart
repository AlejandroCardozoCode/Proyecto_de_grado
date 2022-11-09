// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
import 'dart:developer';

import 'package:electrocardio/main.dart';
import 'package:electrocardio/models/fhir/app_fhir_clases.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Create a practitioner', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());
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
    testPractitioner.create();
    var result = await testPractitioner.uploadToFirebase(testPractitioner.idFirebase, testPractitioner.role);
    expect(result, "200");
  });
  testWidgets('Obtain a practitioner', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());
    AppPractitioner testPractitioner = AppPractitioner();
    testPractitioner.active = "true";
    testPractitioner.id = "idTest";
    testPractitioner.idFirebase = "IdFirebaseTest";
    testPractitioner.firstName = "NameTest";
    testPractitioner.lastName = "LastTest";
    testPractitioner.email = "TestEmail";
    testPractitioner.address = "AddressTest";
    testPractitioner.gender = "male";
    testPractitioner.birthDate = "10/12/1998";
    testPractitioner.role = "Oncologo";
    testPractitioner.imgUrl = "ImageDataTest";
    testPractitioner.create();
    log(await testPractitioner.uploadToFirebase(testPractitioner.idFirebase, testPractitioner.role) as String);
  });
}
