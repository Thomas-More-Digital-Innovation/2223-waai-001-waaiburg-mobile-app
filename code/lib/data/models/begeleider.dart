class Begeleider {
  Begeleider({
    this.voornaam,
    this.achternaam,
    this.email,
    this.telnummer, 
    this.afdelingen,
  });

  String voornaam;
  String achternaam;
  String email;
  String telnummer;
  List<dynamic> afdelingen;

  factory Begeleider.fromJson(Map<String, dynamic> json) => Begeleider(
      voornaam: json["voornaam"] == null ? null : json["voornaam"],
      achternaam: json["achternaam"] == null ? null : json["achternaam"],
      email: json["email"] == null ? "/" : json["email"],
      telnummer: json["telNummer"] == null ? "/" : json["telNummer"],
      afdelingen: json["overeenkomstigeAfdelingen"] == null ? [""] : json["overeenkomstigeAfdelingen"]
      // contentIsLoaded: true,
      );
}
