import 'package:flutter/cupertino.dart';
import "package:fhir/r4.dart" as r4;

class AppObservation with ChangeNotifier {
  late String observationId;
  late String patientIdReference;
  late String practitionerIdReference;
  late String dateTime;
  late String actualObservation;

  copy(AppObservation parameterObservation) {
    observationId = parameterObservation.observationId;
    patientIdReference = parameterObservation.patientIdReference;
    practitionerIdReference = parameterObservation.practitionerIdReference;
    dateTime = parameterObservation.dateTime;
    actualObservation = parameterObservation.actualObservation;
    return this;
  }

  setClassValues(
    String observationId,
    String patientIdReference,
    String practitionerIdReference,
    String dateTime,
    String actualObservation,
  ) {
    this.observationId = observationId;
    this.patientIdReference = patientIdReference;
    this.practitionerIdReference = practitionerIdReference;
    this.dateTime = dateTime;
    this.actualObservation = actualObservation;
  }

  loadFromYaml(String observationYaml) {
    r4.Observation observation = r4.Observation.fromYaml(observationYaml);
    observationId = observation.identifier![0].value!;
    patientIdReference = observation.subject!.reference!;
    practitionerIdReference = observation.performer![0].reference!;
    dateTime = observation.issued!.valueString;
    actualObservation = observation.valueString!;
  }

  create() {
    r4.Observation observation = r4.Observation(
      identifier: <r4.Identifier>[
        r4.Identifier(value: observationId),
      ],
      status: r4.Code("registered"),
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
          reference: practitionerIdReference,
          type: r4.FhirUri("Practitioner"),
        )
      ],
      valueString: actualObservation,
    );
  }
}
