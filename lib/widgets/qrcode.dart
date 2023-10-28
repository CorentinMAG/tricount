import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCode extends StatelessWidget {
  const QRCode({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text("Share this QR Code to join the tricount !", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26.0), textAlign: TextAlign.center,),
          QrImageView(data: "http://127.0.0.1/join/tricount/AZhfuieh57Fshu", version: QrVersions.auto, size: 300.0),
          Text("OR", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26.0), textAlign: TextAlign.center,),
          Text("You can share the following link", style: TextStyle(fontSize: 26.0), textAlign: TextAlign.center,),
          const SizedBox(height: 15.0),
          Text("https://127.0.0.1/join/tricount/AZhfuieh57Fshu", style: TextStyle(fontSize: 16.0), textAlign: TextAlign.center,)
        ],),
    );
  }
}