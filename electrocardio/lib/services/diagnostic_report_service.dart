import 'dart:convert';
import 'dart:developer';

import 'package:electrocardio/models/fhir/app_fhir_clases.dart';

import '../communicators/all_communicator.dart';
import 'package:http/http.dart' as http;

import 'keys_service.dart';

class DiagnosticReportService {
  bool isLoading = true;
  bool isSaving = false;

  DiagnosticReportService() {
    //  loadDiagnosticReports();
  }
  Future loadDiagnosticReports(String idPractitioner) async {
    isLoading = true;

    final List<AppDiagosticReport> diagnosticReports = [];

    String _baseUrl = await obtainURL();
    final url = Uri.https(_baseUrl, 'diagnosticReport.json');
    final respuesta = await http.get(url);
    final Map<String, dynamic> diagnosticReportsMap = json.decode(respuesta.body);
    diagnosticReportsMap.forEach((key, value) {
      final tempDiaRep = AllCommunicator.fromMap(value);
      AppDiagosticReport actualReport = AppDiagosticReport();
      actualReport.loadFromJson(tempDiaRep.jsonVar);
      if (actualReport.practitionerIdReferenceCardio == idPractitioner || actualReport.practitionerIdReferenceOnco == idPractitioner) diagnosticReports.add(actualReport);
    });
    this.isLoading = false;

    return Future.value(diagnosticReports);
  }

  Future createNewDiagnosticReport(AllCommunicator diagnosticReport) async {
    isSaving = true;

    if (diagnosticReport.isNew) await createDiagnosticReport(diagnosticReport);

    diagnosticReport.isNew = false;
    isSaving = false;
  }

  Future createDiagnosticReport(AllCommunicator diagnosticReport) async {
    String _baseUrl = await obtainURL();
    final url = Uri.https(_baseUrl, 'diagnosticReport/${diagnosticReport.id}.json');
    final respuesta = await http.put(url, body: diagnosticReport.toJson());
    final decodeData = json.decode(respuesta.body);
  }
}
