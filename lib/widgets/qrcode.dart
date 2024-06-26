import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCode extends StatelessWidget {
  String url;
  QRCode({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Text(
            "Share this QR Code to join the tricount !",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26.0),
            textAlign: TextAlign.center,
          ),
          QrImageView(data: url, version: QrVersions.auto, size: 300.0),
          const Text(
            "OR",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26.0),
            textAlign: TextAlign.center,
          ),
          const Text(
            "You can share the following link",
            style: TextStyle(fontSize: 26.0),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 15.0),
          Text(
            url,
            style: const TextStyle(fontSize: 16.0),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
