import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/header.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool failedLogin = false;

  void login(String email, String password) async {
    try {
      Response response = await post(
          Uri.parse('https://dewaaiburgapp.eu/api/auth/login'),
          body: {'email': email, 'password': password});
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        // Save the user token to shared preferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('userToken', data['Token']);

        Map<String, dynamic> userData = data['User'];
        prefs.setInt('userId', userData['id']);

        Navigator.pushNamed(context, '/home');
      } else {
        setState(() {
          failedLogin = true;
          passwordController.clear();
          emailController.clear();
        });
      }
    } catch (e) {
      // TODO: show error
      print("THERE WAS AN EXCEPTION: ");
      print(e);
    }
  }

  void remember() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      // resizeToAvoidBottomInset: false,
      appBar: const Header(
        title: Text('Login'),
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (failedLogin) ...[
                Container(
                  margin: const EdgeInsets.all(5.0),
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                      color: Colors.red[100],
                      borderRadius:
                          const BorderRadius.all(Radius.circular(30))),
                  child: const Text(
                    'Email of wachtwoord incorrect',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
              TextField(
                controller: emailController,
                decoration: const InputDecoration(hintText: 'Email'),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(hintText: 'Password'),
                obscureText: true,
              ),
              const SizedBox(
                height: 40,
              ),
              GestureDetector(
                onTap: () {
                  login(emailController.text.toString(),
                      passwordController.text.toString());
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: const Color(0xFFb1b4dc),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Center(
                    child: Text('Login'),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    launchUrl(
                        Uri.parse("https://dewaaiburgapp.eu/forgot-password"));
                  },
                  child: Text(
                    'Wachtwoord vergeten?',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.blue[700]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
