/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $Assets300x420Gen {
  const $Assets300x420Gen();

  /// File path: assets/300x420/sample1.jpg
  AssetGenImage get sample1 =>
      const AssetGenImage('assets/300x420/sample1.jpg');

  /// File path: assets/300x420/sample2.jpg
  AssetGenImage get sample2 =>
      const AssetGenImage('assets/300x420/sample2.jpg');

  /// File path: assets/300x420/sample3.jpg
  AssetGenImage get sample3 =>
      const AssetGenImage('assets/300x420/sample3.jpg');

  /// File path: assets/300x420/sample4.jpg
  AssetGenImage get sample4 =>
      const AssetGenImage('assets/300x420/sample4.jpg');

  /// File path: assets/300x420/sample5.jpg
  AssetGenImage get sample5 =>
      const AssetGenImage('assets/300x420/sample5.jpg');

  /// List of all assets
  List<AssetGenImage> get values =>
      [sample1, sample2, sample3, sample4, sample5];
}

class $Assets600x400Gen {
  const $Assets600x400Gen();

  /// File path: assets/600x400/sample1.jpg
  AssetGenImage get sample1 =>
      const AssetGenImage('assets/600x400/sample1.jpg');

  /// File path: assets/600x400/sample2.jpg
  AssetGenImage get sample2 =>
      const AssetGenImage('assets/600x400/sample2.jpg');

  /// File path: assets/600x400/sample3.jpg
  AssetGenImage get sample3 =>
      const AssetGenImage('assets/600x400/sample3.jpg');

  /// File path: assets/600x400/sample4.jpg
  AssetGenImage get sample4 =>
      const AssetGenImage('assets/600x400/sample4.jpg');

  /// List of all assets
  List<AssetGenImage> get values => [sample1, sample2, sample3, sample4];
}

class $Assets700x150Gen {
  const $Assets700x150Gen();

  /// File path: assets/700x150/sample1.jpg
  AssetGenImage get sample1 =>
      const AssetGenImage('assets/700x150/sample1.jpg');

  /// File path: assets/700x150/sample2.jpg
  AssetGenImage get sample2 =>
      const AssetGenImage('assets/700x150/sample2.jpg');

  /// File path: assets/700x150/sample3.jpg
  AssetGenImage get sample3 =>
      const AssetGenImage('assets/700x150/sample3.jpg');

  /// List of all assets
  List<AssetGenImage> get values => [sample1, sample2, sample3];
}

class $AssetsLoginPageImagesGen {
  const $AssetsLoginPageImagesGen();

  /// File path: assets/login_page_images/apple.png
  AssetGenImage get apple =>
      const AssetGenImage('assets/login_page_images/apple.png');

  /// File path: assets/login_page_images/github.png
  AssetGenImage get github =>
      const AssetGenImage('assets/login_page_images/github.png');

  /// File path: assets/login_page_images/google.png
  AssetGenImage get google =>
      const AssetGenImage('assets/login_page_images/google.png');

  /// List of all assets
  List<AssetGenImage> get values => [apple, github, google];
}

class $AssetsLogoGen {
  const $AssetsLogoGen();

  /// File path: assets/logo/logo_1.png
  AssetGenImage get logo1 => const AssetGenImage('assets/logo/logo_1.png');

  /// File path: assets/logo/logo_2.png
  AssetGenImage get logo2 => const AssetGenImage('assets/logo/logo_2.png');

  /// File path: assets/logo/logo_3.png
  AssetGenImage get logo3 => const AssetGenImage('assets/logo/logo_3.png');

  /// File path: assets/logo/logo_4.png
  AssetGenImage get logo4 => const AssetGenImage('assets/logo/logo_4.png');

  /// File path: assets/logo/logo_5.png
  AssetGenImage get logo5 => const AssetGenImage('assets/logo/logo_5.png');

  /// List of all assets
  List<AssetGenImage> get values => [logo1, logo2, logo3, logo4, logo5];
}

class Assets {
  Assets._();

  static const $Assets300x420Gen a300x420 = $Assets300x420Gen();
  static const $Assets600x400Gen a600x400 = $Assets600x400Gen();
  static const $Assets700x150Gen a700x150 = $Assets700x150Gen();
  static const $AssetsLoginPageImagesGen loginPageImages =
      $AssetsLoginPageImagesGen();
  static const $AssetsLogoGen logo = $AssetsLogoGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
