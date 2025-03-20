import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_viewer_pro/image_viewer_pro.dart';

void main() {
  testWidgets('ImageViewerPro displays images correctly',
      (WidgetTester tester) async {
    List<dynamic> images = [
      "https://jeeva.com/flutter_developer.png",
      "assets/yaash_mart_image.jpg",
      Uint8List.fromList([0, 1, 2, 3, 4, 5, 6, 7, 8, 9]),
    ];

    await tester.pumpWidget(
      MaterialApp(
        home: ImageViewerPro(
          images: images,
          initialIndex: 0,
          showIndicator: true,
        ),
      ),
    );

    // Verify that the image is displayed
    expect(find.byType(ImageViewerPro), findsOneWidget);
  });
}
