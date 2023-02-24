import 'dart:convert';

// import 'package:fab_learner/components/constants.dart';
import 'package:fab_learner/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_html/flutter_html.dart';
import 'package:vimeo_video_player/vimeo_video_player.dart';
// import 'components/constants.dart';
// import 'package:html/dom.dart' as text;
// import 'package:html/parser.dart';

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
  String link = "";

  Future<void> getTopics() async {
    topics = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getString('token');
    // print("under function $courseId");
    // print("id----------------------${widget.id}");
    var token = prefs.getString('token');
    // print(token);
    final res = await http.get(
        Uri.parse('${dotenv.env['APP_URL']}learnpress/v1/lessons/${widget.id}'),
        headers: {
          'Content-Type': 'application/json,',
          'Authorization': 'Bearer $token',
        });
    var response = jsonDecode(res.body);

    topics = response;
    if (topics != null) {
      setState(() {
        isloading = true;
      });
    }
  }

// This is a topic screen
  @override
  Widget build(BuildContext context) {
    const String _vimeoVideoUrl = 'https://vimeo.com/9011932';
    // var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fab Learner'),
      ),
      body: isloading == false
          ? Center(
              child: Lottie.network(
                lottieUrl,
                filterQuality: FilterQuality.high,
              ),
            )
          : SingleChildScrollView(
              child: Center(
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
                          child: VimeoVideoPlayer(
                            vimeoPlayerModel: VimeoPlayerModel(
                              url: _vimeoVideoUrl,
                              systemUiOverlay: const [
                                SystemUiOverlay.top,
                                SystemUiOverlay.bottom,
                              ],
                            ),
                          ),
                          //Html is use to embed html code in flutter
                        ),
                        Text(topics['content'])
                      ],
                    )),
              ),
            ),
    );
  }
}
