import 'dart:convert';

Userentries UserentriesFromJson(String str) => Userentries.fromJson(json.decode(str));

String UserentriesToJson(Userentries data) => json.encode(data.toJson());

class Userentries{
  String name;
  String id;
  String Offered;
  String Priority;
  String Current;
  String DueDate;
  String level;
  String DaysLeft;
  String Contact ;

  Userentries({
    required this.name,
    required this.id,
    required this.Offered,
    required this.Priority,
    required this.Current,
    required this.DueDate,
    required this.level,
    required this.DaysLeft,
    required this.Contact
  }
      );

  factory Userentries.fromJson(Map<String, dynamic> json) => Userentries(
    name: json["name"],
    id: json["id"],
    Offered: json["Offered"],
    Priority: json["Priority"],
    Current: json["Current"],
    DueDate: json["DueDate"],
    level: json["level"],
    DaysLeft: json["DaysLeft"],
    Contact: json["Contact"],

  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'id': id,
    'Offered': Offered,
    'Priority': Priority,
    'Current': Current,
    'DueDate': DueDate,
    'level': level,
    'DaysLeft': DaysLeft,
    'Contact': Contact,
  };
}