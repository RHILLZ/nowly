import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nowly/Controllers/controller_exporter.dart';
import 'package:nowly/Widgets/widget_exporter.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScanScreen extends StatefulWidget {
  const QRScanScreen({Key? key}) : super(key: key);
  static const routeName = '/qrCodeScreen';
  @override
  State<StatefulWidget> createState() => _QRScanScreenState();
}

class _QRScanScreenState extends State<QRScanScreen> {
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      _controller.qrController!.pauseCamera();
    }
    _controller.qrController!.resumeCamera();
  }

  late QRController _controller;

  @override
  void initState() {
    _controller = Get.find();
    super.initState();
  }

  bool isPausedCamera = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: false,
      appBar: AppBar(
        title: const Text('Scan QR Code'),
        centerTitle: true,
        backgroundColor:
            Theme.of(context).appBarTheme.backgroundColor!.withOpacity(0.5),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Positioned.fill(child: _buildQrView(context)),
          if (_controller.qrController != null)
            Positioned(
              bottom: 30,
              right: 0,
              left: 0,
              child: Center(
                child: Material(
                    type: MaterialType.transparency,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Visibility(
                          visible: isPausedCamera,
                          child: RoundedCornerButton(
                              radius: 100,
                              color: Colors.grey.withOpacity(0.6),
                              onTap: () {
                                _controller.qrController!.resumeCamera();
                                setState(() {
                                  isPausedCamera = false;
                                });
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(25),
                                child: Icon(Icons.replay_rounded),
                              )),
                        ),
                        const SizedBox(width: 10),
                        RoundedCornerButton(
                            radius: 100,
                            color: Colors.grey.withOpacity(0.6),
                            onTap: () {
                              setState(() {});
                              _controller.qrController!.toggleFlash();
                            },
                            child: FutureBuilder<bool?>(
                              future:
                                  _controller.qrController!.getFlashStatus(),
                              builder: (context, snapshot) {
                                return Padding(
                                  padding: const EdgeInsets.all(25),
                                  child: snapshot.data == true
                                      ? const Icon(Icons.flash_off)
                                      : const Icon(Icons.flash_on),
                                );
                              },
                            )),
                      ],
                    )),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 250.0
        : 400.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: _controller.qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.white,
          overlayColor: const Color.fromRGBO(0, 0, 0, 100),
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) =>
          _controller.onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController qrViewController) {
    setState(() {
      _controller.qrController = qrViewController;
    });
    qrViewController.scannedDataStream.listen((scanData) {
      _controller.scaningData(scanData);
      qrViewController.pauseCamera();
      setState(() {
        isPausedCamera = true;
      });
    });
  }

  @override
  void dispose() {
    _controller.qrController!.dispose();
    super.dispose();
  }
}
