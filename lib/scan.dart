// import 'dart:io';
// import 'dart:typed_data';

// ignore_for_file: prefer_typing_uninitialized_variables

// import 'package:flutter/cupertino.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';
// import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'package:fab_learner/video.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:url_launcher/url_launcher.dart';

class ScanQR extends StatefulWidget {
  const ScanQR({Key? key}) : super(key: key);

  @override
  State<ScanQR> createState() => _ScanQRState();
}

class _ScanQRState extends State<ScanQR> {
  @override
  initState() {
    super.initState();
    // this._inputController = new TextEditingController();
    _outputController = TextEditingController();
  }

  var link;
  late TextEditingController _outputController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 200,
          child: Column(
            children: <Widget>[
              InkWell(
                onTap: _scan,
                child: const Expanded(
                    flex: 4,
                    child: Icon(
                      Icons.qr_code_scanner_outlined,
                      size: 50,
                      color: Colors.red,
                    )),
              ),
              // Divider(height: 20),
              const Expanded(
                  flex: 1,
                  child: Text(
                    "Scan",
                    style: TextStyle(fontSize: 20, color: Colors.red),
                  )),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Videos(),
                      ));
                },
                child: Column(
                  children: [
                    TextField(
                      readOnly: true,
                      controller: _outputController,
                      maxLines: 2,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        // prefixIcon: Icon(Icons.wrap_text),
                        // helperText:
                        //     'The barcode or qrcode you scan will be displayed in this area.',
                        hintText:
                            'The barcode or qrcode you scan will be displayed in this area.',
                        hintStyle: TextStyle(fontSize: 15),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                      ),
                      onTap: () {
                        // if (_outputController.text != "") {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => const Videos(),
                        //     ));

                        link = _outputController.text;
                        _launchUrl;
                        // ElevatedButton(
                        //   child: const Text('Open Video'),
                        //   onPressed: () => _launchUrl,
                        // );
                        // }
                        // print(link);
                      },
                    ),
                    //TextFeild is used as a form
                  ],
                ),
              ),
              //Inkwell is used to make any Widget clickable.
            ],
          ),
        ),
      ),
    );
  }

  Future _scan() async {
    await Permission.camera.request();
    String? barcode = await scanner.scan();
    if (barcode == null) {
      // print('nothing return.');
    } else {
      _outputController.text = barcode;
    }
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(Uri.parse(link))) {
      throw 'Could not launch $link';
    }
  }
}
