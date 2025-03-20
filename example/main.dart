import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_viewer_pro/image_viewer_pro.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    List<dynamic> images = [
      /// Asset image path
      "assets/images/flutter_logo.png",

      /// Network image link
      "https://cdn.iconscout.com/icon/free/png-512/free-flutter-logo-icon-download-in-svg-png-gif-file-formats--technology-social-media-vol-3-pack-logos-icons-2944876.png?f=webp&w=256",

      // Example bytes (Replace with actual image bytes)
      Uint8List.fromList([
        137,
        80,
        78,
        71,
        13,
      ]),
    ];
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ImageViewerPro(
                  images: images,
                  initialIndex: 0,
                  showIndicator: true,
                  showCloseButton: true,
                  backgroundColor: Colors.black,
                  indicatorAlignment: Alignment.bottomCenter,
                  activateIndicatorDotColor: Colors.white,
                  indicatorColor: Colors.grey,
                  indicatorDotHeight: 8.0,
                  indicatorDotWidth: 8.0,
                  indicatorSpacing: 16.0,
                  indicatorPadding: EdgeInsets.only(bottom: 30),
                  closeButtonSize: 30.0,
                  closeButtonColor: Colors.white,
                  closeButtonBackgroundColor: Colors.black54,
                  closeButtonAlignment: Alignment.topRight,
                  closeButtonPadding: EdgeInsets.only(top: 50, right: 20),
                  enablePageFling: true,
                  enableImageRotation: false,
                  heroTagPrefix: "fullscreen_image_",
                  networkHeaders: {"Authorization": "Bearer token"},
                  enableSwipeToDismiss: true,
                  transitionDuration: Duration(milliseconds: 500),
                  transitionCurve: Curves.easeInOutCubic,
                  allowImplicitScrolling: true,
                  imagePadding: EdgeInsets.all(10),
                  indicatorEffect: IndicatorEffect.wormEffect,
                  imageFit: BoxFit.contain,
                  customCloseButton: IconButton(
                    icon: Icon(Icons.cancel, color: Colors.red, size: 40),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            );
          },
          child: Text("Open Full Screen Viewer"),
        ),
      ),
    );
  }
}
