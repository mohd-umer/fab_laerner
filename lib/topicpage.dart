import 'dart:convert';

// import 'package:fab_learner/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_html/flutter_html.dart';
import 'components/constants.dart';

class TopicPage extends StatefulWidget {
  int id;
  TopicPage({Key? key, required this.id}) : super(key: key);

  @override
  State<TopicPage> createState() => _TopicPageState();
}

class _TopicPageState extends State<TopicPage> {
  @override
  void initState() {
    super.initState();
    getTopics();
  }

  bool isloading = false;
  dynamic topics;
  Future<void> getTopics() async {
    topics = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getString('token');
    // print("under function $courseId");
    print("id----------------------${widget.id}");
    var token = prefs.getString('token');
    print(token);
    final res = await http.get(
        Uri.parse('${dotenv.env['APP_URL']}learnpress/v1/lessons/609'),
        headers: {
          'Content-Type': 'application/json,',
          'Authorization': 'Bearer $token',
        });
    var response = jsonDecode(res.body);
    topics = response;
    print(topics);
    if (topics != null) {
      setState(() {
        isloading = true;
      });
    }
    // print(topics[0]['title']['rendered']);
  }

// This is a topic screen
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fab Learner'),
      ),
      body: isloading == false
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Card(
                  elevation: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        child: Text(
                          topics['name'], // this is name of topic.
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Html(
                            data: topics[
                                'content']), //Html is use to embed html code in flutter
                      ),
                    ],
                  )),
            ),
    );
  }
}
