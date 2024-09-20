import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'my_web_view.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'anchored_adaptive_banner.dart'; // yeni dosyayı import ettik

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: WebViewApp(),
    );
  }
}

class WebViewApp extends StatefulWidget {
  const WebViewApp({super.key});

  @override
  State<WebViewApp> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..loadRequest(
        Uri.parse('https://sadenot.com/'),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: MyWebView(controller: controller),
            ),
            AnchoredAdaptiveBanner(), // AdMob banner widget'ını ekledik
          ],
        ),
      ),
    );
  }
}
