class MijnGegevens {
  MijnGegevens({
    this.voornaam,
    this.achternaam,
    this.afdelingen,
    this.geboorteDatum,
    this.straat,
    this.huisNr,
    this.woonplaats,
    this.postcode,
    this.telNummer,
    this.email,
  });

  String voornaam;
  String achternaam;
  List<dynamic> afdelingen;
  String geboorteDatum;
  String straat;
  String huisNr;
  String woonplaats;
  String postcode;
  String telNummer;
  String email;

  factory MijnGegevens.fromJson(Map<String, dynamic> json) => MijnGegevens(
        voornaam: json["voornaam"] == null ? null : json["voornaam"],
        achternaam: json["achternaam"] == null ? null : json["achternaam"],
        afdelingen: json["afdelingen"] == null ? null : json["afdelingen"],
        geboorteDatum: json["geboorteDatum"] == null ? null : json["geboorteDatum"],
        straat: json["straat"] == null ? null : json["straat"],
        huisNr: json["huisNr"] == null ? null : json["huisNr"],
        woonplaats: json["woonplaats"] == null ? null : json["woonplaats"],
        postcode: json["postcode"] == null ? null : json["postcode"],
        telNummer: json["telNummer"] == null ? null : json["telNummer"],
        email: json["email"] == null ? null : json["email"],
        // contentIsLoaded: true,
      );
}
