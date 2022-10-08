import '../communicators/all_communicator.dart';
import '../models/fhir/app_fhir_clases.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class PractitionerService {
  final String _baseUrl = 'test2-64528-default-rtdb.firebaseio.com';

  //Doctores que se encuentran en la app
  final List<AllCommunicator> practitioners = [];

  late AppPractitioner selectedPractitioner;
  bool isLoading = true;
  bool isSaving = false;

  PractitionerService() {
    this.loadPractitioners();
  }

  Future loadPractitioners() async {
    isLoading = true;

    final url = Uri.https(_baseUrl, 'practitioner.json');
    final respuesta = await http.get(url);
    final Map<String, dynamic> practitionersMap = json.decode(respuesta.body);
    practitionersMap.forEach((key, value) {
      final tempPracti = AllCommunicator.fromMap(value);
      tempPracti.id = key;
      this.practitioners.add(tempPracti);
    });
    this.isLoading = false;

    return this.practitioners;
  }

  Future createNewPractitioner(AllCommunicator practitioner) async {
    isSaving = true;

    if (practitioner.isNew) await createPractitioner(practitioner);

    practitioner.isNew = false;
    isSaving = false;
  }

  Future<String> getPtactitioner(String uId) async {
    isLoading = true;

    final url = Uri.https(_baseUrl, 'practitioner/${uId}.json');
    final respuesta = await http.get(url);
    final decodeData = json.decode(respuesta.body);
    String yaml = decodeData['yaml'];
    return yaml;
  }

  Future createPractitioner(AllCommunicator practitioner) async {
    final url = Uri.https(_baseUrl, 'practitioner/${practitioner.id}.json');
    final respuesta = await http.put(url, body: practitioner.toJson());
    final decodeData = json.decode(respuesta.body);
    this.practitioners.add(practitioner);
  }
}
