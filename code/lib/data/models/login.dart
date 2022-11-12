// Placeholder, should be generated from the api.

class Login {
  Login(
    {
      this.status, 
      this.message, 
      this.token,
      this.voornaam,
      this.achternaam
    });

  bool status; // Request status
  String message; // Request message
  String token;
  String voornaam;
  String achternaam;


  factory Login.fromJson(Map<String, dynamic> json) => Login(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        token: json["token"] == null ? null : json["token"] ,
        voornaam: json["voornaam"] == null ? null : json["voornaam"],
        achternaam: json["achternaam"] == null ? null : json["achternaam"],
      );
}
