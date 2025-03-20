# Image Viewer Pro for Flutter

A Flutter package that provides a full-screen image viewer supporting **AssetImage, NetworkImage, and MemoryImage** with customizable features such as indicators, close buttons, swipe-to-dismiss, and more.

## Features
- Supports **AssetImage, NetworkImage, and MemoryImage**.
- Swipe to navigate between images.
- Customizable **indicators** and **close button**.
- Supports **image zooming** and **panning**.
- Swipe to **dismiss the viewer**.
- Customizable **transition animations**.
- Hero animation support.
- Option to provide network headers for images.

## Example

![Example](https://raw.githubusercontent.com/Jeeva0604/image_viewer_pro/refs/heads/main/assets/example.gif)

## Installation
Add the following dependency to your `pubspec.yaml`:

```yaml
dependencies:
  image_viewer_pro: latest_version
```

## Usage
Import the package:

```dart
import 'package:image_viewer_pro/image_viewer_pro.dart';
```

### Example

```dart
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

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    List<dynamic> images = [
      "assets/images/flutter_logo.png", // Asset image
      "https://example.com/sample.png", // Network image
      Uint8List.fromList([137, 80, 78, 71, 13, 10, 26, 10,]) // Memory image
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
          child: Text("Open Image Viewer Pro"),
        ),
      ),
    );
  }
}
```

## Customization
This package provides several customization options:
- **Background Color**: Change the viewer's background.
- **Indicators**: Customizable page indicators.
- **Close Button**: Modify the close button’s style and position.
- **Image Fit**: Choose how images should be displayed.

## Developer
**Jeeva G**
- GitHub: [Jeeva0604](https://github.com/Jeeva0604)
- LinkedIn: [Jeeva G](https://www.linkedin.com/in/jeeva-g-r0628/)

## License
This package is available under the [MIT License](LICENSE).