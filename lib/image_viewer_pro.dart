library;

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

/// A full-screen image viewer that supports network, asset, and memory images.
///
/// This widget allows you to display images in a full-screen gallery with
/// support for gestures like zooming, panning, and swiping between images.
class ImageViewerPro extends StatefulWidget {
  /// List of images to display in the gallery.
  ///
  /// The images can be provided as URLs (String), asset paths (String), or
  /// raw bytes (Uint8List).
  final List<dynamic> images;

  /// The initial index of the image to display when the gallery is opened.
  ///
  /// Defaults to `0`.
  final int initialIndex;

  /// Whether to show a page indicator at the bottom of the screen.
  ///
  /// Defaults to `true`.
  final bool showIndicator;

  /// Whether to show a close button in the top-right corner.
  ///
  /// Defaults to `true`.
  final bool showCloseButton;

  /// The background color of the full-screen viewer.
  ///
  /// Defaults to `Colors.black`.
  final Color backgroundColor;

  /// The alignment of the page indicator.
  ///
  /// Defaults to `Alignment.bottomCenter`.
  final Alignment indicatorAlignment;

  /// The color of the active dot in the page indicator.
  ///
  /// Defaults to `Colors.white`.
  final Color activateIndicatorDotColor;

  /// The color of the inactive dots in the page indicator.
  ///
  /// Defaults to `Colors.grey`.
  final Color indicatorColor;

  /// The height of the dots in the page indicator.
  ///
  /// Defaults to `8.0`.
  final double indicatorDotHeight;

  /// The width of the dots in the page indicator.
  ///
  /// Defaults to `8.0`.
  final double indicatorDotWidth;

  /// The spacing between the dots in the page indicator.
  ///
  /// Defaults to `16.0`.
  final double indicatorSpacing;

  /// The padding around the page indicator.
  ///
  /// Defaults to `EdgeInsets.only(bottom: 30)`.
  final EdgeInsets indicatorPadding;

  /// The size of the close button.
  ///
  /// Defaults to `30.0`.
  final double closeButtonSize;

  /// The color of the close button icon.
  ///
  /// Defaults to `Colors.white`.
  final Color closeButtonColor;

  /// The background color of the close button.
  ///
  /// Defaults to `Colors.black54`.
  final Color closeButtonBackgroundColor;

  /// The alignment of the close button.
  ///
  /// Defaults to `Alignment.topRight`.
  final Alignment closeButtonAlignment;

  /// The padding around the close button.
  ///
  /// Defaults to `EdgeInsets.only(top: 50, right: 20)`.
  final EdgeInsets closeButtonPadding;

  /// Whether to enable page fling gestures for swiping between images.
  ///
  /// Defaults to `true`.
  final bool enablePageFling;

  /// Whether to enable image rotation gestures.
  ///
  /// Defaults to `false`.
  final bool enableImageRotation;

  /// The prefix for the hero tag used for image transitions.
  ///
  /// Defaults to `"fullscreen_image_"`.
  final String heroTagPrefix;

  /// Optional headers for network images.
  ///
  /// This is useful for authenticated image requests.
  final Map<String, String>? networkHeaders;

  /// The minimum scale for zooming out the image.
  ///
  /// Defaults to `PhotoViewComputedScale.contained`.
  final dynamic minScale;

  /// The BoxFit mode for the image.
  ///
  /// Defaults to `BoxFit.contain`.
  final BoxFit imageFit;

  /// Whether to enable swipe-to-dismiss gesture.
  ///
  /// Defaults to `false`.
  final bool enableSwipeToDismiss;

  /// A custom close button widget.
  ///
  /// If provided, this will override the default close button.
  final Widget? customCloseButton;

  /// A custom page indicator widget.
  ///
  /// If provided, this will override the default page indicator.
  final Widget? customIndicator;

  /// The duration of the transition when switching between images.
  ///
  /// Defaults to `Duration(milliseconds: 300)`.
  final Duration transitionDuration;

  /// The curve of the transition when switching between images.
  ///
  /// Defaults to `Curves.easeInOut`.
  final Curve transitionCurve;

  /// Whether to allow implicit scrolling when the image is zoomed in.
  ///
  /// Defaults to `true`.
  final bool allowImplicitScrolling;

  /// The padding around the image.
  ///
  /// Defaults to `EdgeInsets.zero`.
  final EdgeInsets imagePadding;

  /// Indicator Type for indicator animation
  ///
  /// Defaults to `indicatorEffect.wormEffect`.
  final IndicatorEffect indicatorEffect;

  const ImageViewerPro({
    super.key,
    required this.images,
    this.initialIndex = 0,
    this.showIndicator = true,
    this.showCloseButton = true,
    this.backgroundColor = Colors.black,
    this.indicatorAlignment = Alignment.bottomCenter,
    this.activateIndicatorDotColor = Colors.white,
    this.indicatorColor = Colors.grey,
    this.indicatorDotHeight = 8.0,
    this.indicatorDotWidth = 8.0,
    this.indicatorSpacing = 16.0,
    this.indicatorPadding = const EdgeInsets.only(bottom: 30),
    this.closeButtonSize = 30.0,
    this.closeButtonColor = Colors.white,
    this.closeButtonBackgroundColor = Colors.black54,
    this.closeButtonAlignment = Alignment.topRight,
    this.closeButtonPadding = const EdgeInsets.only(top: 50, right: 20),
    this.enablePageFling = true,
    this.enableImageRotation = false,
    this.heroTagPrefix = "fullscreen_image_",
    this.networkHeaders,
    this.minScale = PhotoViewComputedScale.contained,
    this.imageFit = BoxFit.contain,
    this.enableSwipeToDismiss = false,
    this.customCloseButton,
    this.customIndicator,
    this.transitionDuration = const Duration(milliseconds: 300),
    this.transitionCurve = Curves.easeInOut,
    this.allowImplicitScrolling = true,
    this.imagePadding = EdgeInsets.zero,
    this.indicatorEffect = IndicatorEffect.wormEffect,
  });

  @override
  State<ImageViewerPro> createState() => _ImageViewerProState();
}

class _ImageViewerProState extends State<ImageViewerPro> {
  late final PageController pageController;
  final ValueNotifier<int> currentIndexNotifier = ValueNotifier<int>(0);
  late final List<ImageProvider> imageProvider;
  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: widget.initialIndex);
    currentIndexNotifier.value = widget.initialIndex;

    imageProvider = widget.images.map<ImageProvider>((image) {
      if (image is String) {
        if (image.startsWith('http') || image.startsWith('https')) {
          return NetworkImage(image);
        } else {
          return AssetImage(image);
        }
      } else if (image is Uint8List) {
        return MemoryImage(image);
      } else {
        throw ArgumentError('Unsupported image format: $image');
      }
    }).toList();
  }

  @override
  void dispose() {
    pageController.dispose();
    currentIndexNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body: GestureDetector(
        onVerticalDragEnd: (details) {
          if (widget.enableSwipeToDismiss && details.primaryVelocity! > 100) {
            Navigator.pop(context);
          }
        },
        child: Stack(
          children: [
            PhotoViewGallery.builder(
              itemCount: widget.images.length,
              builder: (context, index) {
                return PhotoViewGalleryPageOptions(
                  imageProvider: imageProvider[index],
                  minScale: widget.minScale,
                  maxScale: PhotoViewComputedScale.covered * 2,
                  heroAttributes: PhotoViewHeroAttributes(
                      tag: '${widget.heroTagPrefix}$index'),
                  initialScale: widget.imageFit == BoxFit.cover
                      ? PhotoViewComputedScale.covered
                      : PhotoViewComputedScale.contained,
                );
              },
              scrollPhysics: const BouncingScrollPhysics(),
              backgroundDecoration:
                  BoxDecoration(color: widget.backgroundColor),
              pageController: pageController,
              onPageChanged: (index) => currentIndexNotifier.value = index,
              enableRotation: widget.enableImageRotation,
              allowImplicitScrolling: widget.allowImplicitScrolling,
            ),
            if (widget.showCloseButton)
              Align(
                alignment: widget.closeButtonAlignment,
                child: Padding(
                  padding: widget.closeButtonPadding,
                  child: widget.customCloseButton ??
                      Container(
                        decoration: BoxDecoration(
                          color: widget.closeButtonBackgroundColor,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(Icons.close,
                              color: widget.closeButtonColor,
                              size: widget.closeButtonSize),
                        ),
                      ),
                ),
              ),
            if (widget.showIndicator && widget.images.length > 1)
              Align(
                alignment: widget.indicatorAlignment,
                child: Padding(
                  padding: widget.indicatorPadding,
                  child: widget.customIndicator ??
                      SmoothPageIndicator(
                        controller: pageController,
                        count: widget.images.length,
                        effect: indicatorEffect(
                          widget.indicatorEffect,
                        ),
                      ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  dynamic indicatorEffect(effect) {
    switch (effect) {
      case IndicatorEffect.wormEffect:
        return SlideEffect(
          dotColor: widget.indicatorColor,
          activeDotColor: widget.activateIndicatorDotColor,
          dotHeight: widget.indicatorDotHeight,
          dotWidth: widget.indicatorDotWidth,
          spacing: widget.indicatorSpacing,
        );
      case IndicatorEffect.wormEffectThin:
        return WormEffect(
          dotColor: widget.indicatorColor,
          type: WormType.thin,
          activeDotColor: widget.activateIndicatorDotColor,
          dotHeight: widget.indicatorDotHeight,
          dotWidth: widget.indicatorDotWidth,
          spacing: widget.indicatorSpacing,
        );
      case IndicatorEffect.expandingDotsEffect:
        return ExpandingDotsEffect(
          dotColor: widget.indicatorColor,
          activeDotColor: widget.activateIndicatorDotColor,
          dotHeight: widget.indicatorDotHeight,
          dotWidth: widget.indicatorDotWidth,
          spacing: widget.indicatorSpacing,
        );
      case IndicatorEffect.scaleEffect:
        return ScaleEffect(
          dotColor: widget.indicatorColor,
          activeDotColor: widget.activateIndicatorDotColor,
          dotHeight: widget.indicatorDotHeight,
          dotWidth: widget.indicatorDotWidth,
          spacing: widget.indicatorSpacing,
        );
      case IndicatorEffect.jumpingDotEffect:
        return JumpingDotEffect(
          dotColor: widget.indicatorColor,
          activeDotColor: widget.activateIndicatorDotColor,
          dotHeight: widget.indicatorDotHeight,
          dotWidth: widget.indicatorDotWidth,
          spacing: widget.indicatorSpacing,
        );
      case IndicatorEffect.scrollingDotsEffect:
        return ScrollingDotsEffect(
          dotColor: widget.indicatorColor,
          activeDotColor: widget.activateIndicatorDotColor,
          dotHeight: widget.indicatorDotHeight,
          dotWidth: widget.indicatorDotWidth,
          spacing: widget.indicatorSpacing,
        );
      case IndicatorEffect.swapEffectNormal:
        return SwapEffect(
          dotColor: widget.indicatorColor,
          activeDotColor: widget.activateIndicatorDotColor,
          dotHeight: widget.indicatorDotHeight,
          dotWidth: widget.indicatorDotWidth,
          spacing: widget.indicatorSpacing,
        );
      case IndicatorEffect.ySwapEffectRotation:
        return SwapEffect(
          dotColor: widget.indicatorColor,
          type: SwapType.yRotation,
          activeDotColor: widget.activateIndicatorDotColor,
          dotHeight: widget.indicatorDotHeight,
          dotWidth: widget.indicatorDotWidth,
          spacing: widget.indicatorSpacing,
        );
      case IndicatorEffect.slideEffect:
        return SlideEffect(
          dotColor: widget.indicatorColor,
          activeDotColor: widget.activateIndicatorDotColor,
          dotHeight: widget.indicatorDotHeight,
          dotWidth: widget.indicatorDotWidth,
          spacing: widget.indicatorSpacing,
        );
      default:
        return SlideEffect(
          dotColor: widget.indicatorColor,
          activeDotColor: widget.activateIndicatorDotColor,
          dotHeight: widget.indicatorDotHeight,
          dotWidth: widget.indicatorDotWidth,
          spacing: widget.indicatorSpacing,
        );
    }
  }
}

enum IndicatorEffect {
  wormEffect,
  wormEffectThin,
  scaleEffect,
  jumpingDotEffect,
  scrollingDotsEffect,
  expandingDotsEffect,
  swapEffectNormal,
  ySwapEffectRotation,
  slideEffect,
}
