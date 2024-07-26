import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../service/login_service.dart';
import 'dashboard_screen.dart';

class PhoneScreen3 extends StatefulWidget {
  const PhoneScreen3({super.key});

  @override
  PhoneScreen3State createState() => PhoneScreen3State();
}

class PhoneScreen3State extends State<PhoneScreen3> {
  bool isChecked = false;
  bool isLoading = false;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  void _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    if (isLoggedIn) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const DashBoardScreen()));
    }
  }

  void _handleLogin() async {
    setState(() {
      isLoading = true;
    });

    String username = _usernameController.text;
    String password = _passwordController.text;

    Map<String, dynamic> response =
    await LoginService.login(username, password);

    setState(() {
      isLoading = false;
    });

    if (response.containsKey("access_token")) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('isLoggedIn', true);
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const DashBoardScreen()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No User'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Image.asset(
            'assets/images/backgroundImg.jpeg',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Positioned(
            child: Center(
              child: Material(
                color: Colors.white,
                surfaceTintColor: Colors.white,
                borderRadius: BorderRadius.circular(20),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    double height = constraints.maxHeight;
                    double width = constraints.maxWidth;
                    bool isTablet = MediaQuery.of(context).size.shortestSide >= 600;
                    Orientation orientation = MediaQuery.of(context).orientation;

                    double containerHeight = isTablet
                        ? (orientation == Orientation.portrait ? height * 0.42 : height * 0.5)
                        : (orientation == Orientation.portrait ? height * 0.6 : height * 1.1);

                    double containerWidth = isTablet
                        ? (orientation == Orientation.portrait ? width * 0.5 : width * 0.34)
                        : (orientation == Orientation.portrait ? width * 0.8 : width * 0.6);

                    return SingleChildScrollView(
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 14),
                        padding: const EdgeInsets.all(20),
                        width: containerWidth,
                        height: containerHeight,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              '  Scientific\nInformation',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff056EAB),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.03,
                            ),
                            Container(
                              height: 46,
                              decoration: BoxDecoration(
                                color: const Color(0xffEBEBED),
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: TextField(
                                controller: _usernameController,
                                textAlign: TextAlign.center,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Username',
                                  hintStyle: TextStyle(
                                    color: Color(0xffCBCAD0),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.03,
                            ),
                            Container(
                              height: 46,
                              decoration: BoxDecoration(
                                color: const Color(0xffEBEBED),
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: TextField(
                                controller: _passwordController,
                                textAlign: TextAlign.center,
                                obscureText: true,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Password',
                                  hintStyle: TextStyle(
                                    color: Color(0xffCBCAD0),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.03,
                            ),
                            InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () {
                                setState(() {
                                  isChecked = !isChecked;
                                });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.all(2),
                                    child: Image.asset(
                                      isChecked
                                          ? 'assets/images/check.jpeg'
                                          : 'assets/images/unCheck.jpeg',
                                      height: 25,
                                      width: 26,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  const Text(
                                    'Remember Me',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: height * 0.03),
                            SizedBox(
                              width: double.infinity,
                              child: SizedBox(
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: _handleLogin,
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        const Color(0xffF48533)),
                                    elevation: MaterialStateProperty.all(0),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Login',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
