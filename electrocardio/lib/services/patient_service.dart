import 'dart:convert';

import '../communicators/all_communicator.dart';
import '../models/fhir/app_fhir_clases.dart';

import 'package:http/http.dart' as http;

class PatientService{

  final String _baseUrl = 'test2-64528-default-rtdb.firebaseio.com';
  final List<AllCommunicator> patients = [];

  bool isLoading = true;
  bool isSaving = false;

  PatientService(){
    loadPatients();
  }

  Future loadPatients()async{
    isLoading = true;

    final url = Uri.https(_baseUrl,'patient.json');
    final respuesta = await http.get(url);
    final Map<String,dynamic> patientsMap = json.decode(respuesta.body);
    patientsMap.forEach((key,value){
      final tempPati = AllCommunicator.fromMap(value);
      tempPati.id = key;
      this.patients.add(tempPati);
    });
    this.isLoading = false;
    
    return this.patients;
  }
  
  Future createNewpatient( AllCommunicator patient)async{
    isSaving = true;

    if(patient.isNew)
    await createpatient(patient);
    
    patient.isNew = false;
    isSaving = false;
  }
  
  Future createpatient(AllCommunicator patient)async{
    final url = Uri.https(_baseUrl,'patient/${patient.id}.json');
    final respuesta = await http.put(url, body: patient.toJson());
    final decodeData = json.decode(respuesta.body);
    this.patients.add(patient);
  }
}