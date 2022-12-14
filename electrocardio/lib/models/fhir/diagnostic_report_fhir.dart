import 'package:electrocardio/services/diagnostic_report_service.dart';
import 'package:fhir/r4.dart' as r4;
import 'package:flutter/cupertino.dart';

import '../../communicators/all_communicator.dart';

// implementacionde la clase de diagnostico con el estandar HL7 FHIR http://hl7.org/fhir/diagnosticreport.html
class AppDiagnosticReport with ChangeNotifier {
  late String id;
  late String patientIdReference;
  late String dateTime;
  late String practitionerIdReferenceOnco;
  late String practitionerIdReferenceCardio;
  late String observationId;
  late String imageReference;
  late String diagnostic;
  late String priority;
  late String status;

  late r4.DiagnosticReport diagnosticReportFHIR;

  copy(AppDiagnosticReport currentDiagnostic) {
    id = currentDiagnostic.id;
    patientIdReference = currentDiagnostic.patientIdReference;
    dateTime = currentDiagnostic.dateTime;
    practitionerIdReferenceOnco = currentDiagnostic.practitionerIdReferenceOnco;
    practitionerIdReferenceCardio = currentDiagnostic.practitionerIdReferenceCardio;
    observationId = currentDiagnostic.observationId;
    imageReference = currentDiagnostic.imageReference;
    diagnostic = currentDiagnostic.diagnostic;
    priority = currentDiagnostic.priority;
    status = currentDiagnostic.status;
    return this;
  }

  loadFromJson(Map<String, dynamic> diagnosticYaml) {
    r4.DiagnosticReport diagnosticReport = r4.DiagnosticReport.fromJson(diagnosticYaml);
    id = diagnosticReport.identifier![0].value!;
    patientIdReference = diagnosticReport.basedOn![0].reference!;
    dateTime = diagnosticReport.issued!.valueString;
    practitionerIdReferenceOnco = diagnosticReport.performer![0].reference!;
    practitionerIdReferenceCardio = diagnosticReport.resultsInterpreter![0].reference!;
    observationId = diagnosticReport.result![0].reference!;
    imageReference = diagnosticReport.media![0].link.reference!;
    diagnostic = diagnosticReport.conclusion!;
    priority = diagnosticReport.identifier![1].value!;
    status = diagnosticReport.status.toString();
  }

  uploadToFirebase(String uId) async {
    //Firebase
    final DiagnosticReportService diagnosticReportService = DiagnosticReportService();
    AllCommunicator diagnosticCommunicator = AllCommunicator(jsonVar: this.diagnosticReportFHIR.toJson());
    diagnosticCommunicator.id = uId;
    diagnosticCommunicator.isNew = true;
    await diagnosticReportService.createNewDiagnosticReport(diagnosticCommunicator);
  }

  create() {
    r4.DiagnosticReport diagnosticReport = r4.DiagnosticReport(
      identifier: <r4.Identifier>[
        r4.Identifier(value: id),
        r4.Identifier(value: priority),
      ],
      basedOn: <r4.Reference>[
        r4.Reference(
          reference: patientIdReference,
          type: r4.FhirUri("Patient"),
        )
      ],
      status: r4.Code(status),
      category: <r4.CodeableConcept>[
        r4.CodeableConcept(
          coding: <r4.Coding>[
            r4.Coding(
              code: r4.Code("EC"),
            ),
          ],
          text: "Electrocardiac",
        ),
      ],
      code: r4.CodeableConcept(
        coding: <r4.Coding>[
          r4.Coding(code: r4.Code("10168-3")),
        ],
        text: "History of Cardiovascular system disorders Narrative",
      ),
      subject: r4.Reference(
        reference: patientIdReference,
        type: r4.FhirUri("Patient"),
      ),
      issued: r4.Instant(dateTime),
      performer: <r4.Reference>[
        r4.Reference(
          reference: practitionerIdReferenceOnco,
          type: r4.FhirUri("Practitioner"),
        )
      ],
      resultsInterpreter: <r4.Reference>[
        r4.Reference(
          reference: practitionerIdReferenceCardio,
          type: r4.FhirUri("Practitioner"),
        )
      ],
      result: <r4.Reference>[
        r4.Reference(
          reference: observationId,
          type: r4.FhirUri("Observation"),
        ),
      ],
      media: <r4.DiagnosticReportMedia>[
        r4.DiagnosticReportMedia(
          link: r4.Reference(
            reference: imageReference,
            type: r4.FhirUri("Binary"),
          ),
        ),
      ],
      conclusion: diagnostic,
    );
    this.diagnosticReportFHIR = diagnosticReport;
  }

  void resetValues() {
    id = "";
    patientIdReference = "";
    dateTime = "";
    practitionerIdReferenceOnco = "";
    practitionerIdReferenceCardio = "";
    observationId = "";
    imageReference = "";
    diagnostic = "";
    priority = "";
  }
}
