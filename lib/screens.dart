// ignore_for_file: use_build_context_synchronously

import 'package:fab_learner/home.dart';
import 'package:fab_learner/profile.dart';
import 'package:fab_learner/scan.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'chat_page.dart';
import 'login.dart';

class Screens extends StatefulWidget {
  const Screens({Key? key}) : super(key: key);

  @override
  State<Screens> createState() => _ScreensState();
}

class _ScreensState extends State<Screens> {
  final Uri _url = Uri.parse('https://fablearner.online/');
  final Uri _tnCurl = Uri.parse('https://fablearner.online/tnc/');
  int selectedIndex = 0;
  // var userName;
  List screens = [const HomePage(), const ScanQR(), const Profile()];
  @override
  void initState() {
    super.initState();
    // getName();
  }

  // Future<void> getName() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   userName = prefs.getString('userName');
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          centerTitle: true,
          title: const Text('Fab Learner'),
          //Title is showing a text at top
          actions: [
            IconButton(
                splashRadius: 0.0000001,
                splashColor: Colors.transparent,
                onPressed: () {},
                icon: const Icon(Icons.notifications))
          ],
        ),
        //Appbar is header of Application
        drawer: Drawer(
          elevation: 5,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const UserAccountsDrawerHeader(
                  currentAccountPicture: Icon(Icons.person),
                  accountName: Text('userName'),
                  accountEmail: Text('accountEmail')),
              ListTile(
                leading: const Icon(Icons.home_outlined),
                title: const Text('Home'),
                onTap: () => Navigator.pop(context),
              ),
              const ListTile(
                leading: Icon(Icons.person_add_alt_1_outlined),
                title: Text('Add Child'),
              ),
              const ListTile(
                leading: Icon(Icons.file_upload_outlined),
                title: Text('Upload Report'),
              ),
              ListTile(
                leading: const Icon(Icons.chat_bubble_outline),
                title: const Text('Chat'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ChatPage()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.text_snippet_outlined),
                title: const Text('Terms & Condition'),
                onTap: _launchTNCUrl,
              ),
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: const Text('About'),
                onTap: () {
                  _launchUrl();
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.exit_to_app_outlined),
                title: const Text('Logout'),
                onTap: () async {
                  final SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.remove("token");
                  if (prefs.getString('token') == null) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ));
                  }
                },
              ),
              const Divider(),
            ],
          ),
        ),
        //Drawer is sideBar
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.qr_code_scanner), label: 'Scan'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
          currentIndex: selectedIndex,
          onTap: (value) => setState(() {
            selectedIndex = value;
          }),
        ),
        body: screens[selectedIndex]
        //Center is used for Center the widget
        );
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }

  Future<void> _launchTNCUrl() async {
    if (!await launchUrl(_tnCurl)) {
      throw 'Could not launch $_tnCurl';
    }
  }
}
