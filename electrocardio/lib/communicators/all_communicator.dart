import 'dart:convert';

class AllCommunicator {
    AllCommunicator({
      required  this.yaml,
    });

    String yaml;
    String id = "";
    bool isNew = false;

    factory AllCommunicator.fromJson(String str) => AllCommunicator.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AllCommunicator.fromMap(Map<String, dynamic> json) => AllCommunicator(
        yaml: json["yaml"],
    );

    Map<String, dynamic> toMap() => {
        "yaml": yaml,
    };
}