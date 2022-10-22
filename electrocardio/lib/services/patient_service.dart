import 'dart:convert';

import '../communicators/all_communicator.dart';
import '../models/fhir/app_fhir_clases.dart';

import 'package:http/http.dart' as http;

import 'keys_service.dart';

class PatientService {
  bool isLoading = true;
  bool isSaving = false;
  String _baseUrl = "";

  PatientService() {
    // loadPatients();
  }

  Future<List<AppPatient>> loadPatients(String id) async {
    isLoading = true;
    final List<AppPatient> patients = [];
    if (this._baseUrl == "") {
      this._baseUrl = await obtainURL();
    }
    final url = Uri.https(_baseUrl, 'patient.json');
    final response = await http.get(url);
    var jsonDecoded = json.decode(response.body);
    if (jsonDecoded != null) {
      final Map<String, dynamic> patientsMap = jsonDecoded;
      patientsMap.forEach((key, value) {
        final tempPati = AllCommunicator.fromMap(value);
        tempPati.id = key;
        AppPatient actualPatient = AppPatient();
        actualPatient.loadFromJson(tempPati.jsonVar);
        if (actualPatient.practitionerId == id) {
          patients.add(actualPatient);
        }
      });
      this.isLoading = false;

      return Future.value(patients);
    }
    return [];
  }

  Future createNewPatient(AllCommunicator patient) async {
    isSaving = true;

    if (patient.isNew) await createpatient(patient);

    patient.isNew = false;
    isSaving = false;
  }

  Future createpatient(AllCommunicator patient) async {
    String _baseUrl = await obtainURL();
    final url = Uri.https(_baseUrl, 'patient/${patient.id}.json');
    final respuesta = await http.put(url, body: patient.toJson());
    //log(json.decode(respuesta.body));
  }
}
