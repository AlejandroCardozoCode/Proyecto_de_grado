import 'dart:convert';

class AllCommunicator {
  AllCommunicator({
    required this.jsonVar,
  });

  Map<String, dynamic> jsonVar;
  String id = "";
  bool isNew = false;

  factory AllCommunicator.fromJson(String str) => AllCommunicator.fromMap(json.decode(str));

  String toJson() => json.encode(jsonVar);

  factory AllCommunicator.fromMap(Map<String, dynamic> json) => AllCommunicator(
        jsonVar: json,
      );

  Map<String, dynamic> toMap() => {
        "": jsonVar,
      };
}
