import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

Future<List<dynamic>> fetchUserDetails() async {
  const String apiUrl = 'http://10.0.2.2:8000/api/user'; // API URL
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final token = prefs.get('userToken');

  try {
    final response = await http
        .get(Uri.parse(apiUrl), headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200) {
      // Decode the entire JSON response
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);

      // Convert 'user' and 'mentor' fields into User instances
      User user = User.fromJson(jsonResponse['user']);
      User? mentor = jsonResponse['mentor'].isNotEmpty
          ? User.fromJson(jsonResponse['mentor'])
          : null;
      return [user, mentor];
    } else {
      print("Request failed with status: ${response.statusCode}");
      throw Exception('Failed to load data');
    }
  } catch (e) {
    print("Request failed with exception: $e");
    throw Exception('Failed to load data');
  }
}

class User {
  final int id;
  final int userTypeId;
  final String firstname;
  final String surname;
  final String? birthdate;
  final String email;
  final String? emailVerifiedAt;
  final String? phoneNumber;
  final String? gender;
  final String? street;
  final String? houseNumber;
  final String? city;
  final String? zipcode;
  final String? survey;
  final String? createdAt;
  final String? updatedAt;

  const User({
    required this.id,
    required this.userTypeId,
    required this.firstname,
    required this.surname,
    required this.email,
    this.birthdate,
    this.emailVerifiedAt,
    this.phoneNumber,
    this.gender,
    this.street,
    this.houseNumber,
    this.city,
    this.zipcode,
    this.survey,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        userTypeId: json['user_type_id'],
        firstname: json['firstname'],
        surname: json['surname'],
        birthdate: json['birthdate'],
        email: json['email'],
        emailVerifiedAt: json['email_verified_at'],
        phoneNumber: json['phoneNumber'],
        gender: json['gender'],
        street: json['street'],
        houseNumber: json['houseNumber'],
        city: json['city'],
        zipcode: json['zipcode'],
        survey: json['survey'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at']);
  }
}
