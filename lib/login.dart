// ignore_for_file: use_build_context_synchronously, prefer_collection_literals, prefer_typing_uninitialized_variables, unused_local_variable, unnecessary_null_comparison
// import 'package:fab_learner/home.dart';
import 'dart:convert';
import 'package:fab_learner/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'components/constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var loginres;
  bool istap = false;

  Future<dynamic> loginAPI() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var map = Map<String, dynamic>();
    map['username'] = emailController.text;
    map['password'] = passwordController.text;
    final response = await http.post(
      Uri.parse('${dotenv.env['APP_URL']}learnpress/v1/token'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(map),
    );
    loginres = jsonDecode(response.body);
    print(loginres);
    token = loginres['token'];
    if (token != null) {
      prefs.setString('token', token);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Screens(),
          ));
    } else {
      showDialog(
          context: context,
          builder: ((context) => AlertDialog(
                title: const Text('Invalid details entered'),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('ok'))
                ],
              )));
    }
  }

  Future<void> resetAPI() async {
    var reset;
    var resetmap = Map<String, dynamic>();
    resetmap['user_login'] = emailController.text;
    final res = await http.post(
      Uri.parse('${dotenv.env['APP_URL']}learnpress/v1/users/reset-password'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(resetmap),
    );
    reset = jsonDecode(res.body);
    //  = res;
    print(reset);
    // print(reset);
    if (reset['code'] == 'success') {
      showDialog(
          context: context,
          builder: ((context) => AlertDialog(
                title: Text(reset['message']),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        setState(() {
                          istap = false;
                        });
                      },
                      child: const Text('ok'))
                ],
              )));
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBox(
            //   height: height * 0.05,
            // ),
            SizedBox(
              height: height * 0.35,
              child: Center(
                  child: Image.asset(
                'asset/images/fab_logo.jpg',
                filterQuality: FilterQuality.high,
                // fit: BoxFit.,
              )),
            ),
            // SizedBox(
            //   height: height * 0.05,
            // ),
            if (istap == false) ...[
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // const Text('Login Page'),
                  Container(
                    height: 55,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: const ShapeDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(255, 218, 218, 218),
                          Color.fromARGB(255, 236, 250, 252)
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [0.0, 0.4],
                        tileMode: TileMode.clamp,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                    ),
                    child: Center(
                      child: TextField(
                        controller: emailController,
                        expands: false,
                        style: const TextStyle(
                            fontSize: 20.0, color: Colors.black54),
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(12.0),
                            prefixIcon: Icon(
                              Icons.email,
                              color: Color.fromARGB(255, 218, 38, 82),
                            ),
                            hintText: 'email',
                            hintStyle: TextStyle(color: Colors.black54),
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    height: 55,
                    decoration: const ShapeDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(255, 218, 218, 218),
                          Color.fromARGB(255, 236, 250, 252)
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [0.0, 0.4],
                        tileMode: TileMode.clamp,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                    ),
                    child: Center(
                      child: TextField(
                        controller: passwordController,
                        obscureText: true,
                        expands: false,
                        style: const TextStyle(
                            fontSize: 20.0, color: Colors.black54),
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(12.0),
                            prefixIcon: Icon(
                              Icons.password,
                              color: Color.fromARGB(255, 218, 38, 82),
                            ),
                            hintText: 'password',
                            hintStyle: TextStyle(color: Colors.black54),
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Card(
                    elevation: 2,
                    color: const Color.fromARGB(255, 121, 212, 228),
                    child: SizedBox(
                      height: 40,
                      width: 90,
                      child: TextButton(
                        onPressed: () async {
                          final SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setString('userName', emailController.text);
                          if (emailController.text != "" &&
                              passwordController.text != "") {
                            loginAPI();
                            print(prefs.getString('userName'));
                          }
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        if (istap == false) {
                          istap = true;
                        }
                      });
                      print(istap);
                    },
                    child: const Text(
                      'Reset Password',
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
            ] else ...[
              Container(
                height: 55,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: const ShapeDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 218, 218, 218),
                      Color.fromARGB(255, 236, 250, 252)
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.0, 0.4],
                    tileMode: TileMode.clamp,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                ),
                child: Center(
                  child: TextField(
                    controller: emailController,
                    expands: false,
                    style:
                        const TextStyle(fontSize: 20.0, color: Colors.black54),
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(12.0),
                        prefixIcon: Icon(
                          Icons.email,
                          color: Color.fromARGB(255, 218, 38, 82),
                        ),
                        hintText: 'email',
                        hintStyle: TextStyle(color: Colors.black54),
                        border: InputBorder.none),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Card(
                elevation: 2,
                color: const Color.fromARGB(255, 121, 212, 228),
                child: SizedBox(
                  height: 40,
                  width: 90,
                  child: TextButton(
                    onPressed: () async {
                      final SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setString('userName', emailController.text);
                      if (emailController.text != "") {
                        resetAPI();
                      }
                    },
                    child: const Text(
                      'Reset',
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    // if (istap == false) {
                    istap = false;
                    // }
                  });
                  print(istap);
                },
                child: const Text(
                  'Goto login Screen',
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.w500),
                ),
              )
            ],
          ],
        ),
      ),
    );
  }
}
