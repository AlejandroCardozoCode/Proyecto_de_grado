import 'dart:convert';

import '../communicators/all_communicator.dart';
import 'package:http/http.dart' as http;

class DiagnosticReportService{
  final String _baseUrl = 'test2-64528-default-rtdb.firebaseio.com';
  final List<AllCommunicator> diagnosticReports = [];

  bool isLoading = true;
  bool isSaving = false;

  DiagnosticReportService(){
    loadDiagnosticReports();
  }

  Future loadDiagnosticReports()async{
    isLoading = true;

    final url = Uri.https(_baseUrl,'diagnosticReport.json');
    final respuesta = await http.get(url);
    final Map<String,dynamic> diagnosticReportsMap = json.decode(respuesta.body);
    diagnosticReportsMap.forEach((key,value){
      final tempDiaRep = AllCommunicator.fromMap(value);
      tempDiaRep.id = key;
      this.diagnosticReports.add(tempDiaRep);
    });
    this.isLoading = false;
    
    return this.diagnosticReports;
  }

  Future createNewDiagnosticReport( AllCommunicator diagnosticReport)async{
    isSaving = true;

    if(diagnosticReport.isNew)
    await createDiagnosticReport(diagnosticReport);
    
    diagnosticReport.isNew = false;
    isSaving = false;
  }
  
  Future createDiagnosticReport(AllCommunicator diagnosticReport)async{
    final url = Uri.https(_baseUrl,'diagnosticReport/${diagnosticReport.id}.json');
    final respuesta = await http.put(url, body: diagnosticReport.toJson());
    final decodeData = json.decode(respuesta.body);
    this.diagnosticReports.add(diagnosticReport);
  }
}