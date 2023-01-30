// ignore_for_file: use_build_context_synchronously, prefer_typing_uninitialized_variables, unnecessary_null_comparison

import 'dart:async';
import 'dart:convert';
import 'package:fab_learner/lesson.dart';
import 'package:fab_learner/login.dart';
import 'package:fab_learner/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var finalToken;
  @override
  void initState() {
    super.initState();

    getValidation().whenComplete(() async {
      Timer(
          const Duration(seconds: 1),
          () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    finalToken == null ? const LoginPage() : const Screens(),
              )));
    });
  }

  Future getValidation() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      finalToken = prefs.getString('token');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'asset/images/fab_icon.jpg',
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Fab',
                style: TextStyle(
                    color: Color.fromARGB(255, 218, 38, 82),
                    fontSize: 45,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Learner',
                style: TextStyle(
                    color: Color.fromARGB(255, 121, 212, 228),
                    fontSize: 45,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          const SizedBox(
            height: 130,
          )
        ],
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    getCourse();
  }

  bool isloading = false;
  var courses = [];
  Future<void> getCourse() async {
    final res =
        await get(Uri.parse('${dotenv.env['APP_URL']}learnpress/v1/courses'));
    var response = jsonDecode(res.body);
    courses = response;
    if (courses != null) {
      setState(() {
        isloading = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: isloading == false
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(top: 15.0, left: 15),
                        child: Text(
                          "Courses:",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (var i = 0; i < courses.length; i++)
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SectionsPage(
                                    section: courses[i]['sections'],
                                  ),
                                ));
                          },
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                                side: const BorderSide(style: BorderStyle.none),
                                borderRadius: BorderRadius.circular(15)),
                            margin: const EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                    // color: Colors.indigo,
                                    // height: 100,
                                    width: width * 0.9,
                                    padding: const EdgeInsets.all(15),
                                    child: Text(
                                      courses[i]['name'],
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 20),
                                    )),
                                const Divider(
                                  height: 0,
                                  color: Colors.indigo,
                                  thickness: 1,
                                ),
                                SizedBox(
                                  height: 200,
                                  child: Image.network(
                                    courses[i]['image'],
                                    filterQuality: FilterQuality.high,
                                    // fit: BoxFit.fitWidth,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ) // inkwell is use to make any widget clickable
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
