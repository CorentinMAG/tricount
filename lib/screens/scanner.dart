import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {

  final qrKey = GlobalKey();
  Barcode? barcode;
  QRViewController? controller;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    super.reassemble();

    if (Platform.isAndroid) {
      await controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  void onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((barcode) => setState((){ this.barcode = barcode;}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          QRView(
            key: qrKey, 
            onQRViewCreated: onQRViewCreated,
            overlay: QrScannerOverlayShape(
              borderColor: Colors.blue,
              borderWidth: 10,
              borderLength: 20,
              borderRadius: 10,
              cutOutSize:  MediaQuery.of(context).size.width * 0.8
            ),
            ),
            Positioned(bottom: 10, child: Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), color: Colors.white24),
              child: Text(
                barcode != null ? 'Result: ${barcode!.code}': 'Scan a code!',
                maxLines: 3,
              ),
            ))
        ],
      )
    );
  }
}
