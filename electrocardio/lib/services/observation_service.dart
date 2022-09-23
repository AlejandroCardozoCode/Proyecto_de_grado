import 'dart:convert';

import 'package:electrocardio/communicators/all_communicator.dart';

import 'package:http/http.dart' as http;

class ObservationService{
  final String _baseUrl = 'test2-64528-default-rtdb.firebaseio.com';
  final List<AllCommunicator> observations = [];

  bool isLoading = true;
  bool isSaving = false;

  ObservationService(){
    loadObservations();
  }
  
  Future loadObservations()async{
    isLoading = true;

    final url = Uri.https(_baseUrl,'observation.json');
    final respuesta = await http.get(url);
    final Map<String,dynamic> observationsMap = json.decode(respuesta.body);
    observationsMap.forEach((key,value){
      final tempObser = AllCommunicator.fromMap(value);
      tempObser.id = key;
      this.observations.add(tempObser);
    });
    this.isLoading = false;
    
    return this.observations;
  }
  
  Future createNewObservation( AllCommunicator observation)async{
    isSaving = true;

    if(observation.isNew)
    await createObservation(observation);
    
    observation.isNew = false;
    isSaving = false;
  }
  
  Future createObservation(AllCommunicator observation)async{
    final url = Uri.https(_baseUrl,'observation/${observation.id}.json');
    final respuesta = await http.put(url, body: observation.toJson());
    final decodeData = json.decode(respuesta.body);
    this.observations.add(observation);
  }

}