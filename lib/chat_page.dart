import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        leading: InkWell(
          splashColor: Colors.transparent,
          onTap: () => Navigator.pop(context),
          child: Row(
            children: [
              const SizedBox(
                width: 12,
              ),
              CircleAvatar(
                child: Image.asset('asset/images/fab_icon.jpg'),
                radius: 22,
              )
            ],
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('USERNAME',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            Text(
              'lastseen',
              style: TextStyle(fontSize: 15),
            )
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_vert_rounded,
                size: 30,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Card(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(children: const [Text('Chat')]),
                Row(children: const [Text('Chat')]),
                Row(children: const [Text('Chat')]),
                Row(children: const [Text('Chat')]),
                Row(children: const [Text('Chat')]),
                Row(children: const [Text('Chat')]),
                Row(children: const [Text('Chat')]),
                Row(children: const [Text('Chat')]),
                Row(children: const [Text('Chat')]),
                Row(children: const [Text('Chat')]),
                Row(children: const [Text('Chat')]),
                Row(children: const [Text('Chat')]),
                Row(children: const [Text('Chat')]),
                Row(children: const [Text('Chat')]),
                Row(children: const [Text('Chat')]),
                Row(children: const [Text('Chat')]),
                Row(children: const [Text('Chat')]),
                Row(children: const [Text('Chat')]),
                Row(children: const [Text('Chat')]),
                Row(children: const [Text('Chat')]),
                Row(children: const [Text('Chat')]),
                Row(children: const [Text('Chat')]),
                Row(children: const [Text('Chat')]),
                Row(children: const [Text('Chat')]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
