import 'dart:convert';

List<InformationSegment> informationSegmentFromJson(String str) => List<InformationSegment>.from(json.decode(str).map((x) => InformationSegment.fromJson(x)));

String informationSegmentToJson(List<InformationSegment> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class InformationSegment {
    InformationSegment({
        this.infoSegmentId,
        this.titel,
        this.isVolwassenen,
        this.volgordeNr,
        this.createdAt,
    });

    int infoSegmentId;
    String titel;
    int isVolwassenen;
    int volgordeNr;
    DateTime createdAt;

    factory InformationSegment.fromJson(Map<String, dynamic> json) => InformationSegment(
        infoSegmentId: json["infoSegmentId"] == null ? null : json["infoSegmentId"],
        titel: json["titel"] == null ? null : json["titel"],
        isVolwassenen: json["isVolwassenen"] == null ? null : json["isVolwassenen"],
        volgordeNr: json["volgordeNr"] == null ? null : json["volgordeNr"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    );

    Map<String, dynamic> toJson() => {
        "infoSegmentId": infoSegmentId == null ? null : infoSegmentId,
        "titel": titel == null ? null : titel,
        "isVolwassenen": isVolwassenen == null ? null : isVolwassenen,
        "volgordeNr": volgordeNr == null ? null : volgordeNr,
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
    };
}