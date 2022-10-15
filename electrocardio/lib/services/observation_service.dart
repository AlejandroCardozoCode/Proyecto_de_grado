import 'dart:convert';

import 'package:electrocardio/communicators/all_communicator.dart';
import 'package:electrocardio/models/fhir/app_fhir_clases.dart';

import 'package:http/http.dart' as http;

import 'keys_service.dart';

class ObservationService {
  bool isLoading = true;
  bool isSaving = false;

  ObservationService() {
    // loadObservations();
  }

  Future loadObservations(String idPractitioner) async {
    isLoading = true;

    final List<AppObservation> observations = [];

    String _baseUrl = await obtainURL();
    final url = Uri.https(_baseUrl, 'observation.json');
    final response = await http.get(url);
    final Map<String, dynamic> observationsMap = json.decode(response.body);
    observationsMap.forEach((key, value) {
      final tempObser = AllCommunicator.fromMap(value);
      tempObser.id = key;
      AppObservation actualObservation = AppObservation();
      actualObservation.loadFromJson(tempObser.jsonVar);
      if (actualObservation.practitionerIdReference == idPractitioner || actualObservation.practitionerIdReference == idPractitioner) observations.add(actualObservation);
      observations.add(actualObservation);
    });
    this.isLoading = false;

    return Future.value(observations);
  }

  Future createNewObservation(AllCommunicator observation) async {
    isSaving = true;

    if (observation.isNew) await createObservation(observation);

    observation.isNew = false;
    isSaving = false;
  }

  Future createObservation(AllCommunicator observation) async {
    String _baseUrl = await obtainURL();
    final url = Uri.https(_baseUrl, 'observation/${observation.id}.json');
    final response = await http.put(url, body: observation.toJson());
    final decodeData = json.decode(response.body);
  }
}
