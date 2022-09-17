import 'package:fhir/r4.dart' as r4;
import 'package:flutter/cupertino.dart';

// implementacionde la clase de diagnostico con el estandar HL7 FHIR http://hl7.org/fhir/diagnosticreport.html
class AppDiagosticReport with ChangeNotifier {
  late String id;
  late String patientIdReference;
  late String dateTime;
  late String practitionerIdReferenceOnco;
  late String practitionerIdReferenceCardio;
  late String observationId;
  late String imageReference;
  late String diagnostic;

  copy(AppDiagosticReport currentDiagnostic) {
    id = currentDiagnostic.id;
    patientIdReference = currentDiagnostic.patientIdReference;
    dateTime = currentDiagnostic.dateTime;
    practitionerIdReferenceOnco = currentDiagnostic.practitionerIdReferenceOnco;
    practitionerIdReferenceCardio =
        currentDiagnostic.practitionerIdReferenceCardio;
    observationId = currentDiagnostic.observationId;
    imageReference = currentDiagnostic.imageReference;
    diagnostic = currentDiagnostic.diagnostic;
    return this;
  }

  loadFromYaml(String diagnosticYaml) {
    r4.DiagnosticReport diagnosticReport =
        r4.DiagnosticReport.fromYaml(diagnosticYaml);
    id = diagnosticReport.identifier![0].value!;
    patientIdReference = diagnosticReport.basedOn![0].reference!;
    dateTime = diagnosticReport.issued!.valueString;
    practitionerIdReferenceOnco = diagnosticReport.performer![0].reference!;
    practitionerIdReferenceCardio =
        diagnosticReport.resultsInterpreter![0].reference!;
    observationId = diagnosticReport.result![0].reference!;
    imageReference = diagnosticReport.media![0].link.reference!;
    diagnostic = diagnosticReport.conclusion!;
  }

  create() {
    r4.DiagnosticReport diagnosticReport = r4.DiagnosticReport(
      identifier: <r4.Identifier>[r4.Identifier(value: id)],
      //revisar
      basedOn: <r4.Reference>[
        r4.Reference(
          reference: patientIdReference,
          type: r4.FhirUri("Patient"),
        )
      ],
      //http://hl7.org/fhir/valueset-diagnostic-report-status.html
      status: r4.Code("final"),
      // http://hl7.org/fhir/valueset-diagnostic-service-sections.html
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
  }
}
