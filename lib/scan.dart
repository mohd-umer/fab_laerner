import 'dart:async';
import 'dart:convert';

import 'package:fab_learner/components/constants.dart';
import 'package:fab_learner/topicpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ScanQR extends StatefulWidget {
  const ScanQR({Key? key}) : super(key: key);

  @override
  State<ScanQR> createState() => _ScanQRState();
}

class _ScanQRState extends State<ScanQR> {
  dynamic _scanQRCode = 'Unknown';

  @override
  void initState() {
    super.initState();
  }

  var oldId;
  var newId;
  Future<void> scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    var res = jsonDecode(barcodeScanRes);
    oldId = res['id'];
    int constId = 339;
    int tempId;
    for (var i = 0; i <= 150; i++) {
      constId++;
      print('dsfdsf+$constId');
      if (i.toString() == oldId) {
        print(
            '---+++++;++++++++++++++++++++++++++++++++++++++++++++++++++++$i');
        newId = constId;
        break;
      }
    }

    print(newId);
    print(
        "---------------------------------------------------------------------------------$barcodeScanRes");
    if (!mounted) return;
    setState(() {
      _scanQRCode = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Builder(builder: (BuildContext context) {
      return Container(
          alignment: Alignment.center,
          child: Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                    onPressed: () {
                      scanQR();
                      if (_scanQRCode == null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TopicPage(id: newId),
                            ));
                      }
                    },
                    child: Text('Start QR scan')),
                Text('Scan result : $_scanQRCode\nNew Id is : $newId',
                    style: const TextStyle(fontSize: 20))
              ]));
    }));
  }
}
