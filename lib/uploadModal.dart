import 'dart:convert';

UploadModal uploadModalFromJson(String str) =>
    UploadModal.fromJson(json.decode(str));

String uploadModalToJson(UploadModal data) => json.encode(data.toJson());

class UploadModal {
  UploadModal({
    this.detail,
    this.status,
  });

  String detail;
  String status;

  factory UploadModal.fromJson(Map<String, dynamic> json) => UploadModal(
        detail: json["detail"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "detail": detail,
        "status": status,
      };
}
