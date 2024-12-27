import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class QrCodePage extends StatefulWidget {
  const QrCodePage({super.key});

  @override
  State<QrCodePage> createState() => _QrCodePageState();
}

class _QrCodePageState extends State<QrCodePage> {
  late QrImage qrCodeImage;

  final inputController = TextEditingController();

  void gotData(
      [String data =
          "https://www.youtube.com/channel/UC9xf1YLgUQbbZChQjG7V2wQ"]) {
    setState(() {
      QrCode qrCode = QrCode(
        8,
        QrErrorCorrectLevel.H,
      )..addData(data);
      debugPrint(data);
      qrCodeImage = QrImage(qrCode);
    });
  }

  @override
  void initState() {
    super.initState();
    gotData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: PrettyQrView(qrImage: qrCodeImage),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          alertShow(context);
        },
        child: const Icon(Icons.change_circle_outlined),
      ),
    );
  }

  Future<void> alertShow(BuildContext context) {
    return showDialog<void>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Modify Qrcode"),
            content: TextField(
              controller: inputController,
              decoration: const InputDecoration(),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    gotData(inputController.text.toString());
                    inputController.clear();

                    Navigator.of(context).pop();
                  },
                  child: const Text("done"))
            ],
          );
        });
  }
}
