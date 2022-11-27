import 'dart:convert';

List<InformationBlock> informationBlockFromJson(String str) =>
    List<InformationBlock>.from(
        json.decode(str).map((x) => InformationBlock.fromJson(x)));

String informationBlockToJson(List<InformationBlock> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class InformationBlock {
  InformationBlock({
    this.infoBlokId,
    this.titel,
    this.infoSegmentId,
    this.volgordeNr,
    this.createdAt,
    this.blokFotoUrl,
    this.inhoud,
  });

  int infoBlokId;
  String titel;
  int infoSegmentId;
  int volgordeNr;
  DateTime createdAt;
  String blokFotoUrl;
  String inhoud;
  String meerInfoLink;

  factory InformationBlock.fromJson(Map<String, dynamic> json) =>
      InformationBlock(
        infoBlokId: json["infoBlokId"] == null ? null : json["infoBlokId"],
        titel: json["titel"] == null ? null : json["titel"],
        infoSegmentId:
            json["infoSegmentId"] == null ? null : json["infoSegmentId"],
        volgordeNr: json["volgordeNr"] == null ? null : json["volgordeNr"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        blokFotoUrl: json["blokFotoUrl"] == null ? null : json["blokFotoUrl"],
        inhoud: json["inhoud"] == null ? null : json["inhoud"],
      );

  Map<String, dynamic> toJson() => {
        "infoBlokId": infoBlokId == null ? null : infoBlokId,
        "titel": titel == null ? null : titel,
        "infoSegmentId": infoSegmentId == null ? null : infoSegmentId,
        "volgordeNr": volgordeNr == null ? null : volgordeNr,
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "blokFotoUrl": blokFotoUrl == null ? null : blokFotoUrl,
        "inhoud": inhoud == null ? null : inhoud,
      };
}
