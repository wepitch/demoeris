import 'package:erisdemoapp/eris/ui/phone_screen_3.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.remove('isLoggedIn');
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PhoneScreen3()));
            },
          ),
        ],
      ),
      body: const Center(
        child: Text('Login Successfully'),
      ),
    );
  }
}