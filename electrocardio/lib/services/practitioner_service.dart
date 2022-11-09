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
  String _baseUrl = "";
  PractitionerService() {
//    this.loadPractitioners();
  }

  Future loadPractitioners() async {
    isLoading = true;

    if (this._baseUrl == "") {
      KeyService keyService = KeyService();
      this._baseUrl = await keyService.obtainURL();
    }

    final url = Uri.https(_baseUrl, 'practitioner.json');
    final response = await http.get(url);
    var jsonDecoded = json.decode(response.body);
    if (jsonDecoded != null) {
      final Map<String, dynamic> practitionersMap = jsonDecoded;
      practitionersMap.forEach((key, value) {
        final tempPracti = AllCommunicator.fromMap(value);
        tempPracti.id = key;
        this.practitioners.add(tempPracti);
      });
      this.isLoading = false;

      return this.practitioners;
    }
    return null;
  }

  Future<Map<String, dynamic>> getPractitioner(String uId) async {
    isLoading = true;

    KeyService keyService = KeyService();
    String _baseUrl = await keyService.obtainURL();

    final url = Uri.https(_baseUrl, 'practitioner/${uId}.json');
    final respuesta = await http.get(url);
    final decodeData = json.decode(respuesta.body);
    if (decodeData == null) {
      return {};
    }
    if (decodeData["active"] != null) {
      return decodeData;
    }
    return {};
  }

  Future<int> obtainCardiologistLength() async {
    KeyService keyService = KeyService();
    String _baseUrl = await keyService.obtainURL();
    final url = Uri.https(_baseUrl, 'cardiologistList/list.json');
    final response = await http.get(url);
    if (json.decode(response.body) != null || json.decode(response.body) != "") {
      List list = json.decode(response.body);
      return list.length;
    }
    return 0;
  }

  createPractitioner(AllCommunicator practitioner, String role) async {
    KeyService keyService = KeyService();
    String _baseUrl = await keyService.obtainURL();

    final url = Uri.https(_baseUrl, 'practitioner/${practitioner.id}.json');
    final response = await http.put(url, body: practitioner.toJson());
    if (role == "Cardiologo") {
      int nextPosition = await obtainCardiologistLength();
      final url2 = Uri.https(_baseUrl, 'cardiologistList/list/${nextPosition}.json');
      final url3 = Uri.https(_baseUrl, 'cardiologistList/counter.json');
      final response2 = await http.put(url2, body: json.encode(practitioner.id));
      final response3 = await http.get(url3);
      if (json.decode(response3.body) == null) {
        final url4 = Uri.https(_baseUrl, 'cardiologistList.json');
        await http.patch(url4, body: json.encode({"counter": 0}));
      }
    }
    log(response.body);
    return response.statusCode.toString();
  }

  Future<String> obtainCurrentIndexCardiologist() async {
    KeyService keyService = KeyService();
    String _baseUrl = await keyService.obtainURL();

    final url = Uri.https(_baseUrl, 'cardiologistList.json');
    final response = await http.get(url);
    if (json.decode(response.body) != null) {
      Map<String, dynamic> mapValues = json.decode(response.body);
      if (mapValues["counter"] != null) {
        int counter = mapValues["counter"];
        if (mapValues["list"] != null) {
          List listCardio = mapValues["list"];
          if (counter == listCardio.length - 1) {
            counter = 0;

            setCurrentIndexCardiologist(counter);

            return listCardio[counter];
          }
          if (listCardio.length == 1) {
            setCurrentIndexCardiologist(counter);
            return listCardio[counter];
          }
          setCurrentIndexCardiologist(counter + 1);
          return listCardio[counter + 1];
        }
      }
    }
    return "";
  }

  Future<void> setCurrentIndexCardiologist(int newValue) async {
    KeyService keyService = KeyService();
    String _baseUrl = await keyService.obtainURL();

    final url = Uri.https(_baseUrl, 'cardiologistList.json');
    final response = await http.patch(url, body: json.encode({"counter": newValue}));
  }
}
