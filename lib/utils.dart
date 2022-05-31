import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:path_provider/path_provider.dart' as path;

class Utils {
  static final TextEditingController _qrData = TextEditingController();

  TextEditingController get qrData => _qrData;

  static capture(GlobalKey? key, BuildContext context) async {
    if (key == null) return;
    final renderObject =
        key.currentContext!.findRenderObject() as RenderRepaintBoundary?;
    if (renderObject == null) return;
    final render = await renderObject.toImage();
    final byData = await render.toByteData(format: ImageByteFormat.png);
    if (byData == null) return;
    final buffer8 = byData.buffer.asUint8List();
    final dir = await path.getExternalStorageDirectories(
        type: path.StorageDirectory.pictures);
    final name = DateTime.now().toString();
    if (dir == null) return;
    final file = File("${dir.first.path}/$name.png");
    file.writeAsBytesSync(buffer8);
    print(dir);
    print(file.path);

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Image.file(file),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Sair"))
            ],
          );
        });
  }

  static Future<void> scanCode() async {
    await FlutterBarcodeScanner.scanBarcode(
            "#ff6666", "Cancel", true, ScanMode.QR)
        .then((value) => _qrData.text = value)
        .catchError((onError) {
      print(onError.toString());
    });
  }
}
