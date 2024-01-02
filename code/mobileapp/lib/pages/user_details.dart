import 'dart:async';
import 'package:mobileapp/api/user.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/components/header.dart';
import 'package:mobileapp/components/list_cards.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({super.key});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  late Future<List<dynamic>> futureUser;
  late User user;
  late User? mentor;

  Future<void> _initializeData() async {
    // Using `await` to wait for the future to complete before accessing its value
    List<dynamic> userData = await fetchUserDetails();

    // Now you can access the elements of the list
    user = userData[0];
    mentor = userData[1];

    debugPrint(
        "user: ${user.id} ${user.firstname} ${user.surname} ; mentor: ${mentor}");
  }

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: const Header(
        bgcolor: Colors.transparent,
        titleColor: 0xFFFFFFFF,
        title: Text("hey"),
      ),
      body: Center(
          child: Container(
              color: const Color(0xFF46ae93), child: const Text("jow"))),
    );
  }
}
