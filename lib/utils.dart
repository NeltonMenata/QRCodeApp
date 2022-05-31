import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:path_provider/path_provider.dart';

class Utils {
  static capture(GlobalKey? key) async {
    if (key == null) return;
    final renderObject =
        key.currentContext!.findRenderObject() as RenderRepaintBoundary?;
    if (renderObject == null) return;
    final render = await renderObject.toImage();
    final byData = await render.toByteData(format: ImageByteFormat.png);
    if (byData == null) return;
    final buffer8 = byData.buffer.asUint8List();
    final dir = await getApplicationDocumentsDirectory();
    final path = dir.path;
    print(path);
  }

  static Future<void> scanCode() async {
    final codeScanner = await FlutterBarcodeScanner.scanBarcode(
            "#ff6666", "Cancel", true, ScanMode.QR)
        .then((value) => value)
        .catchError((onError) {
      print(onError.toString());
    });
  }
}
