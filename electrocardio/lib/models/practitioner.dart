import 'package:fhir/r4.dart' as r4;

class AppPractitioner {
  AppPractitioner({
    required this.active,
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.address,
    required this.gender,
    required this.birthDate,
  });

  String? active;
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? address;
  String? gender;
  String? birthDate;

  get generatePractitioner {
    final practitioner = r4.Practitioner(
      active: r4.Boolean(active),
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
          system: r4.ContactPointSystem.email,
          value: email,
        ),
      ],
      address: <r4.Address>[
        r4.Address(
          use: r4.AddressUse.home,
          type: r4.AddressType.both,
          text: address,
        )
      ],
      gender: r4.Code(gender),
      birthDate: r4.Date(birthDate),
    );
    return practitioner;
  }
}
