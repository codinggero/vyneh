import 'package:flutter/material.dart';

class Img extends StatelessWidget {
  final String src;
  final String? alt;
  final AlignmentGeometry alignment;
  final Animation<double>? opacity;
  final BlendMode? colorBlendMode;
  final BoxFit? fit;
  final Color? color;
  final FilterQuality filterQuality;
  final ImageRepeat repeat;
  final Rect? centerSlice;
  final String? semanticLabel;
  final bool excludeFromSemantics;
  final bool gaplessPlayback;
  final bool isAntiAlias;
  final bool matchTextDirection;
  final double? height;
  final double? width;

  const Img({
    super.key,
    required this.src,
    this.alt = 'assets/drawable/placeholder.gif',
    this.alignment = Alignment.center,
    this.centerSlice,
    this.color,
    this.colorBlendMode,
    this.excludeFromSemantics = false,
    this.filterQuality = FilterQuality.low,
    this.fit,
    this.gaplessPlayback = false,
    this.height,
    this.isAntiAlias = false,
    this.matchTextDirection = false,
    this.opacity,
    this.repeat = ImageRepeat.noRepeat,
    this.semanticLabel,
    this.width,
  });

  Widget frameBuilder(BuildContext c, Widget child, int? i, bool b) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: child,
    );
  }

  Widget loadingBuilder(BuildContext c, Widget child, ImageChunkEvent? i) {
    return Center(child: child);
  }

  Widget errorBuilder(BuildContext context, Object object, StackTrace? stack) {
    return Image(
      image: NetworkImage(src),
      frameBuilder: frameBuilder,
      loadingBuilder: loadingBuilder,
      errorBuilder: errorBuilder2,
      alignment: alignment,
      centerSlice: centerSlice,
      color: color,
      colorBlendMode: colorBlendMode,
      excludeFromSemantics: excludeFromSemantics,
      filterQuality: filterQuality,
      fit: fit,
      gaplessPlayback: gaplessPlayback,
      height: height,
      isAntiAlias: isAntiAlias,
      matchTextDirection: matchTextDirection,
      opacity: opacity,
      repeat: repeat,
      semanticLabel: semanticLabel,
      width: width,
    );
  }

  Widget errorBuilder2(BuildContext context, Object object, StackTrace? stack) {
    return Image(
      image: AssetImage(alt!),
      frameBuilder: frameBuilder,
      loadingBuilder: loadingBuilder,
      errorBuilder: errorBuilder3,
      alignment: alignment,
      centerSlice: centerSlice,
      color: color,
      colorBlendMode: colorBlendMode,
      excludeFromSemantics: excludeFromSemantics,
      filterQuality: filterQuality,
      fit: fit,
      gaplessPlayback: gaplessPlayback,
      height: height,
      isAntiAlias: isAntiAlias,
      matchTextDirection: matchTextDirection,
      opacity: opacity,
      repeat: repeat,
      semanticLabel: semanticLabel,
      width: width,
    );
  }

  Widget errorBuilder3(BuildContext context, Object object, StackTrace? stack) {
    return Image(
      image: AssetImage(alt!),
      frameBuilder: frameBuilder,
      loadingBuilder: loadingBuilder,
      errorBuilder: errorBuilder,
      alignment: alignment,
      centerSlice: centerSlice,
      color: color,
      colorBlendMode: colorBlendMode,
      excludeFromSemantics: excludeFromSemantics,
      filterQuality: filterQuality,
      fit: fit,
      gaplessPlayback: gaplessPlayback,
      height: height,
      isAntiAlias: isAntiAlias,
      matchTextDirection: matchTextDirection,
      opacity: opacity,
      repeat: repeat,
      semanticLabel: semanticLabel,
      width: width,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Image(
      image: AssetImage(src),
      frameBuilder: frameBuilder,
      loadingBuilder: loadingBuilder,
      errorBuilder: errorBuilder,
      alignment: alignment,
      centerSlice: centerSlice,
      color: color,
      colorBlendMode: colorBlendMode,
      excludeFromSemantics: excludeFromSemantics,
      filterQuality: filterQuality,
      fit: fit,
      gaplessPlayback: gaplessPlayback,
      height: height,
      isAntiAlias: isAntiAlias,
      matchTextDirection: matchTextDirection,
      opacity: opacity,
      repeat: repeat,
      semanticLabel: semanticLabel,
      width: width,
    );
  }
}
