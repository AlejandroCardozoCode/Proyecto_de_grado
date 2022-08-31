import 'package:fhir/r4.dart' as r4;

class AppPatient {
  String? id;
  String? firstName;
  String? lastName;
  String? phone;
  String? gender;
  String? birthDate;
  String? address;
  String? maritalCode;
  String? maritalText;
  String? contactCode;
  String? contactTextCode;
  String? contactFirstName;
  String? contactLastName;
  String? contactPhone;
  String? contactGender;
  String? contactAddress;

  get generatePatient {
    final patient = r4.Patient(
      active: r4.Boolean("true"),
      identifier: <r4.Identifier>[r4.Identifier(value: id)],
      name: <r4.HumanName>[
        r4.HumanName(
          use: r4.HumanNameUse.official,
          given: [firstName!],
          family: lastName,
        ),
      ],
      telecom: <r4.ContactPoint>[
        r4.ContactPoint(
          use: r4.ContactPointUse.work,
          system: r4.ContactPointSystem.phone,
          value: phone,
        ),
      ],
      gender: r4.Code(gender),
      birthDate: r4.Date(birthDate),
      address: <r4.Address>[
        r4.Address(
          use: r4.AddressUse.home,
          type: r4.AddressType.both,
          text: address,
        )
      ],
      maritalStatus: r4.CodeableConcept(
        coding: <r4.Coding>[
          r4.Coding(
            display: maritalCode,
          ),
        ],
        text: maritalText,
      ),
      contact: <r4.PatientContact>[
        r4.PatientContact(
          relationship: <r4.CodeableConcept>[
            r4.CodeableConcept(
              coding: <r4.Coding>[
                r4.Coding(
                  display: contactCode,
                )
              ],
              text: contactTextCode,
            ),
          ],
          name: r4.HumanName(
            use: r4.HumanNameUse.official,
            given: [contactFirstName!],
            family: contactLastName,
          ),
          telecom: <r4.ContactPoint>[
            r4.ContactPoint(
              use: r4.ContactPointUse.work,
              system: r4.ContactPointSystem.phone,
              value: contactPhone,
            ),
          ],
          gender: r4.Code(contactGender),
          address: r4.Address(
            use: r4.AddressUse.home,
            type: r4.AddressType.both,
            text: contactAddress,
          ),
        ),
      ],
    );
  }
}
