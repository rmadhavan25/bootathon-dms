import 'dart:convert';

AttendingModel attendingModelFromJson(String str) => AttendingModel.fromJson(json.decode(str));

String attendingModelToJson(AttendingModel data) => json.encode(data.toJson());

class AttendingModel {
  AttendingModel({
    this.id,
    this.patientId,
    this.createdAt,
    this.recordName,
  });

  int id;
  PatientId patientId;
  DateTime createdAt;
  String recordName;

  factory AttendingModel.fromJson(Map<String, dynamic> json) => AttendingModel(
    id: json["id"],
    patientId: PatientId.fromJson(json["patient_id"]),
    createdAt: DateTime.parse(json["created_at"]),
    recordName: json["record_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "patient_id": patientId.toJson(),
    "created_at": createdAt.toIso8601String(),
    "record_name": recordName,
  };
}

class PatientId {
  PatientId({
    this.id,
    this.patient,
  });

  int id;
  Patient patient;

  factory PatientId.fromJson(Map<String, dynamic> json) => PatientId(
    id: json["id"],
    patient: Patient.fromJson(json["patient"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "patient": patient.toJson(),
  };
}

class Patient {
  Patient({
    this.id,
    this.name,
    this.phone,
  });

  int id;
  String name;
  String phone;

  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
    id: json["id"],
    name: json["name"],
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "phone": phone,
  };
}