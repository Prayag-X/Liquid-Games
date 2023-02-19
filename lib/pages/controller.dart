import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Controller extends StatefulWidget {
  const Controller({Key? key, this.game}) : super(key: key);
  final int? game;

  @override
  State<Controller> createState() => _ControllerState();
}

class _ControllerState extends State<Controller> {
  late WebViewController controller;
  late String ip;
  late int snakePort;
  late int asteroidPort;
  late SharedPreferences prefs;
  bool isLoading = true;

  getSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    ip = prefs.getString('ip') ?? '192.168.56.101';
    snakePort = prefs.getInt('snakePort') ?? 8114;
    asteroidPort = prefs.getInt('asteroidPort') ?? 8129;
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..loadRequest(Uri.parse(widget.game == null
          ? 'http://$ip:$asteroidPort/'
          : 'http://$ip:$snakePort/controller'));
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getSharedPrefs();
    if(widget.game == null) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ]);
    }
  }

  @override
  dispose() {
    if(widget.game == null) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            SizedBox(
              width: 0,
            ),
            Text(
              'Game Controller',
            ),
            SizedBox(
              width: 56,
            ),
          ],
        ),
      ),
      body: !isLoading
          ? WebViewWidget(
              controller: controller,
            )
          : const Center(
              child: SizedBox(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(),
              ),
            ),
    );
  }
}
