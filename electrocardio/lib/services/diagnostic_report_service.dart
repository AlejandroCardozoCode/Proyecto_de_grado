import 'dart:convert';
import 'dart:developer';

import 'package:electrocardio/models/fhir/app_fhir_clases.dart';

import '../communicators/all_communicator.dart';
import 'package:http/http.dart' as http;

import 'keys_service.dart';

class DiagnosticReportService {
  bool isLoading = true;
  bool isSaving = false;

  String _baseUrl = "";
  DiagnosticReportService() {
    //  loadDiagnosticReports();
  }
  Future loadDiagnosticReports(String idPractitioner) async {
    isLoading = true;

    final List<AppDiagnosticReport> diagnosticReports = [];

    if (this._baseUrl == "") {
      KeyService keyService = KeyService();
      this._baseUrl = await keyService.obtainURL();
    }

    final url = Uri.https(_baseUrl, 'diagnosticReport.json');
    final response = await http.get(url);
    var jsonDecoded = json.decode(response.body);
    if (jsonDecoded != null) {
      final Map<String, dynamic> diagnosticReportsMap = jsonDecoded;
      diagnosticReportsMap.forEach((key, value) {
        final tempDiaRep = AllCommunicator.fromMap(value);
        AppDiagnosticReport actualReport = AppDiagnosticReport();
        actualReport.loadFromJson(tempDiaRep.jsonVar);
        if (actualReport.practitionerIdReferenceCardio == idPractitioner || actualReport.practitionerIdReferenceOnco == idPractitioner) diagnosticReports.add(actualReport);
      });
      this.isLoading = false;

      return Future.value(diagnosticReports);
    }
    return null;
  }

  Future createNewDiagnosticReport(AllCommunicator diagnosticReport) async {
    isSaving = true;

    await createDiagnosticReport(diagnosticReport);

    diagnosticReport.isNew = false;
    isSaving = false;
  }

  Future createDiagnosticReport(AllCommunicator diagnosticReport) async {
    KeyService keyService = KeyService();
    String _baseUrl = await keyService.obtainURL();
    final url = Uri.https(_baseUrl, 'diagnosticReport/${diagnosticReport.id}.json');
    String jsonValue = await diagnosticReport.toJson();
    final respuesta = await http.put(url, body: jsonValue);
    final decodeData = json.decode(respuesta.body);
  }
}
