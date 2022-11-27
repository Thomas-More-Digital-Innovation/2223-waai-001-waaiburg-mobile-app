import 'package:waaiburg_app/data/models/mijn_gegevens.dart';
import 'package:waaiburg_app/data/models/begeleider.dart';
import 'package:waaiburg_app/environment/environment.dart';
import 'package:waaiburg_app/app_state.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

// import '../custom_cache_manager.dart';

class LogedInRepository {
  Future<MijnGegevens> getMijnGegevens(appState) async {
    final response = await http.get(
        Uri.https(
            Environment().config.apiHost, "/api/client/read_mijnGegevens.php"),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ' + appState.bearerToken,
        });
    return MijnGegevens.fromJson(jsonDecode(response.body));
  }

  Future<List<Begeleider>> getBegeleiders(appState) async {
    final response = await http.get(
        Uri.https(Environment().config.apiHost,
            "/api/begeleider/read_mijnBegeleiders.php"),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ' + appState.bearerToken,
        });

    var jsonData = jsonDecode(response.body);

    var begeleiders = List<Begeleider>();
    for (var item in jsonData) {
      begeleiders.add(Begeleider.fromJson(item));
    }

    return begeleiders;
  }
}
