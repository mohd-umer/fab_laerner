// ignore_for_file: must_be_immutable, unnecessary_null_comparison

import 'package:fab_learner/topicpage.dart';
import 'package:flutter/material.dart';

class SectionsPage extends StatefulWidget {
  var section;
  SectionsPage({Key? key, required this.section}) : super(key: key);

  @override
  State<SectionsPage> createState() => _SectionsPageState();
}

class _SectionsPageState extends State<SectionsPage> {
  List lessons = [];
  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    var sections = widget.section;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Fab Learner'),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var i = 0; i < widget.section.length; i++)
                Card(
                  elevation: 5,
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ExpansionTile(
                          title: Text(
                            sections[i]['title'],
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                          onExpansionChanged: (value) async {
                            lessons = await sections[i]["items"];
                            if (lessons != null) {
                              setState(() {
                                isloading = true;
                              });
                            }
                          },
                          expandedAlignment: Alignment.centerLeft,
                          children: [
                            for (var j = 0; j < lessons.length; j++)
                              ListTile(
                                title: Text("${lessons[j]['title']}"),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => TopicPage(
                                          id: lessons[j]['id'],
                                        ),
                                      ));
                                },
                              ) // ListTile is a listItem
                          ],
                        ),
                      ]),
                )
            ],
          ),
        ));
  }
}
