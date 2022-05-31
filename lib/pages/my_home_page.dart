import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qrcodeapp/utils.dart';
import 'package:qrcodeapp/widget_to_image.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _qrcodeRefresh() {
    setState(() {
      //Utils.capture(globalKey1);
    });
  }

  GlobalKey globalKey1 = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(fontWeight: FontWeight.w300),
        ),
        actions: [
          PopupMenuButton(
              itemBuilder: (context) => [
                    PopupMenuItem(
                      child: const Text("Salvar QRCode como imagem"),
                      onTap: () {
                        Utils.capture(globalKey1, context);
                      },
                    )
                  ])
        ],
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'Digite algum texto para transformar em QRCode',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.width * 0.6,
                child: WidgetToImage(builder: (key) {
                  globalKey1 = key;
                  return QrImage(
                    data: Utils().qrData.text,
                    foregroundColor: Colors.tealAccent,
                  );
                }),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 150),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.tealAccent)),
                    child: TextField(
                      maxLines: null,
                      onChanged: (text) {
                        setState(() {});
                      },
                      controller: Utils().qrData,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () async {
              Utils.scanCode();
            },
            child: const Icon(Icons.search_rounded),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
