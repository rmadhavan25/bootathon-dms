import 'dart:convert';

UserRecord userrecordFromJson(String str) => UserRecord.fromJson(json.decode(str));

String userrecordToJson(UserRecord data) => json.encode(data.toJson());

class UserRecord {
    UserRecord({
        this.id,
        this.doctorId,
        this.record,
        this.recordName,
        this.createdAt,
    });

    int id;
    DoctorId doctorId;
    String record;
    String recordName;
    DateTime createdAt;

    factory UserRecord.fromJson(Map<String, dynamic> json) => UserRecord(
        id: json["id"],
        doctorId: DoctorId.fromJson(json["doctor_id"]),
        record: json["record"],
        recordName: json["record_name"],
        createdAt: DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "doctor_id": doctorId.toJson(),
        "record": record,
        "record_name": recordName,
        "created_at": createdAt.toIso8601String(),
    };
}

class DoctorId {
    DoctorId({
        this.id,
        this.doctor,
    });

    int id;
    Doctor doctor;

    factory DoctorId.fromJson(Map<String, dynamic> json) => DoctorId(
        id: json["id"],
        doctor: Doctor.fromJson(json["doctor"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "doctor": doctor.toJson(),
    };
}

class Doctor {
    Doctor({
        this.id,
        this.name,
        this.phone,
        this.licenceNo,
    });

    int id;
    String name;
    String phone;
    String licenceNo;

    factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        licenceNo: json["licence_no"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "licence_no": licenceNo,
    };
}
