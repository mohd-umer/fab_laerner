import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Padding(
            padding: EdgeInsets.all(30.0),
            child: CircleAvatar(
              radius: 80,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Text('Your Profile page is here'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
            child: Text('Email@gmail.com'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Text('9300000000'),
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0), child: Divider()),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Text('Change Password'),
          ),
        ],
      ),
    );
  }
}
