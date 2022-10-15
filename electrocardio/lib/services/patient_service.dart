import 'dart:convert';

import '../communicators/all_communicator.dart';
import '../models/fhir/app_fhir_clases.dart';

import 'package:http/http.dart' as http;

import 'keys_service.dart';

class PatientService {
  bool isLoading = true;
  bool isSaving = false;

  PatientService() {
    // loadPatients();
  }

  Future<List<AppPatient>> loadPatients() async {
    isLoading = true;

    final List<AppPatient> patients = [];
    String _baseUrl = await obtainURL();
    final url = Uri.https(_baseUrl, 'patient.json');
    final respuesta = await http.get(url);
    final Map<String, dynamic> patientsMap = json.decode(respuesta.body);
    patientsMap.forEach((key, value) {
      final tempPati = AllCommunicator.fromMap(value);
      tempPati.id = key;
      AppPatient actualPatient = AppPatient();
      actualPatient.loadFromJson(tempPati.jsonVar);
      patients.add(actualPatient);
    });
    this.isLoading = false;

    return Future.value(patients);
  }

  Future createNewpatient(AllCommunicator patient) async {
    isSaving = true;

    if (patient.isNew) await createpatient(patient);

    patient.isNew = false;
    isSaving = false;
  }

  Future createpatient(AllCommunicator patient) async {
    String _baseUrl = await obtainURL();
    final url = Uri.https(_baseUrl, 'patient/${patient.id}.json');
    final respuesta = await http.put(url, body: patient.toJson());
    final decodeData = json.decode(respuesta.body);
  }
}
