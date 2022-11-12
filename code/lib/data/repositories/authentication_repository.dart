import 'package:waaiburg_app/environment/environment.dart';
import 'package:waaiburg_app/data/models/response.dart';
import 'package:waaiburg_app/data/models/login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthenticationRepository {
  Future<Response> wachtwoordVergeten(String email) async {
    final response = await http.post(
      Uri.https(Environment().config.apiHost, "/api/authApp/wachtwoordVergeten.php"),
      body: ({  
        'titel': "Waaiburg App account",
        'html':"",
        'rawTekst':"",
        'linkTekst': "Verifieer account",
        'email': email,
      }),
    );
    print(response.body);
    return Response.fromJson(jsonDecode(response.body));
  }

  Future<Login> login(String email, String wachtwoord) async {
    final response = await http.post(
      Uri.https(Environment().config.apiHost, "/api/authApp/login.php"),
      body: ({  
        'email': email,
        'wachtwoord': wachtwoord,
      }),
    );
    return Login.fromJson(jsonDecode(response.body));
  }
}
