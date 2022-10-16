import 'dart:developer';

import 'package:flutter/services.dart';

import '../communicators/all_communicator.dart';
import '../models/fhir/app_fhir_clases.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'keys_service.dart';

class PractitionerService {
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

    String _baseUrl = await obtainURL();
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

  Future<Map<String, dynamic>> getPtactitioner(String uId) async {
    isLoading = true;

    String _baseUrl = await obtainURL();
    final url = Uri.https(_baseUrl, 'practitioner/${uId}.json');
    final respuesta = await http.get(url);
    final decodeData = json.decode(respuesta.body);
    if (decodeData["active"] != null) {
      return decodeData;
    }
    return {};
  }

  Future<int> obtainCardilogistLenght() async {
    String _baseUrl = await obtainURL();
    final url = Uri.https(_baseUrl, 'cardiologistList/list.json');
    final response = await http.get(url);
    if (json.decode(response.body) != null) {
      List list = json.decode(response.body);
      return list.length;
    }
    return 0;
  }

  Future createPractitioner(AllCommunicator practitioner, String role) async {
    String _baseUrl = await obtainURL();
    final url = Uri.https(_baseUrl, 'practitioner/${practitioner.id}.json');
    final response = await http.put(url, body: practitioner.toJson());
    log(role);
    if (role == "Cardiologo") {
      int nextPosition = await obtainCardilogistLenght();
      final url2 = Uri.https(_baseUrl, 'cardiologistList/list/${nextPosition}.json');
      final response2 = await http.put(url2, body: json.encode(practitioner.id));
      log(response2.body.toString());
    }
  }

  Future<String> obtainCurrentIndexCardiologist() async {
    String _baseUrl = await obtainURL();
    final url = Uri.https(_baseUrl, 'cardiologistList.json');
    final response = await http.get(url);
    Map<String, dynamic> mapValues = json.decode(response.body);
    if (mapValues["counter"] != null) {
      int counter = mapValues["counter"];
      if (mapValues["list"] != null) {
        if (counter == mapValues.length) {
          counter = -1;
        }
        List listCardio = mapValues["list"];
        setCurrentIndexCardiologist(counter + 1);
        return listCardio[counter + 1];
      }
    }
    return "";
  }

  Future<void> setCurrentIndexCardiologist(int newValue) async {
    String _baseUrl = await obtainURL();
    final url = Uri.https(_baseUrl, 'cardiologistList.json');
    final response = await http.patch(url, body: json.encode({"counter": newValue}));
  }
}
