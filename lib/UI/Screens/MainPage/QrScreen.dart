import 'dart:io';

import 'package:Attendee/Data/Models/StateModel.dart';
import 'package:Attendee/Utils/Extintions.dart';
import 'package:Attendee/Utils/Snaks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../../../Data/Providers/UserProvider.dart';
import '../../Theme/AppColors.dart';

class QrScreen extends  ConsumerStatefulWidget {
  const QrScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<QrScreen> createState() => _QrScreenState();
}

class _QrScreenState extends ConsumerState<QrScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {

    ref.listen(setAttendanceNotifier, (previous, next) {
      next.handelStateWithoutWidget(
          onLoading: (state){},
          onFailure: (state){
            SnakeBar.showSnakeBar(context, isSuccess: false, message: context.getLocaleString(next.message ?? ""));
            controller?.resumeCamera();
          },
          onSuccess: (state){
            SnakeBar.showSnakeBar(context, isSuccess: true, message: context.getLocaleString(next.message ?? ""));
            controller?.resumeCamera();
          }
      );
    });

    return Scaffold(
      body: Stack(
        children: <Widget>[
          QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(overlayColor: Colors.white.withOpacity(0.5),cutOutSize: context.getScreenSize.width * 0.8,borderColor: AppColors.mainAppColorLight,borderWidth: 30,borderRadius: 20),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      result = scanData;
      if(result?.code != null){
        controller.pauseCamera();
        print("Scan Result ${result?.code}");
        ref.read(setAttendanceNotifier.notifier).setAttendance(result?.code ?? "");
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}


