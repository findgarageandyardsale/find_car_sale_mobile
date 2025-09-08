import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:findcarsale/shared/domain/circulat_indicator_widget.dart';
import 'package:findcarsale/shared/widgets/app_image.dart';

class FileImageBuilder extends StatelessWidget {
  const FileImageBuilder({
    super.key,
    required this.url,
    required this.clickUrl,
    this.fit = BoxFit.cover,
    this.height = 100,
    this.width = 100,
    this.title,
    this.shape,
  });
  final String url;
  final String clickUrl;
  final String? title;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final BoxShape? shape;
  @override
  Widget build(BuildContext context) {
    Widget mainContent = Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            shape == BoxShape.circle
                ? null
                : const BorderRadius.all(Radius.circular(12)),
        shape: shape ?? BoxShape.rectangle,
      ),
      child: CacheImageBuilder(
        fit: fit,
        clickUrl: clickUrl,
        url: url,
        height: height,
        width: width,
      ),
    );

    return mainContent;
  }
}

///Cache image builder for image preview section
class CacheImageBuilder extends StatelessWidget {
  const CacheImageBuilder({
    required this.url,
    required this.clickUrl,
    this.size = 42,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.errorWidget,
    this.height,
    this.width,
    this.shape = BoxShape.rectangle,
    this.floatingWidget,
    this.imageBuilder,
    super.key,
    this.fromCF = false,
  });

  final String url;
  final String clickUrl;
  final double? size;
  final BoxFit? fit;
  final double? height;
  final double? width;
  final Widget? placeholder;
  final Widget? errorWidget;
  final Widget? floatingWidget;
  final bool? fromCF;

  /// box shape of image widget if you want to change it to circle then apply [BoxShape.circle]
  final BoxShape shape;
  final Widget? imageBuilder;

  @override
  Widget build(BuildContext context) {
    String imageUrl = clickUrl.isEmpty ? url : clickUrl;
    return
    // Image.network(
    //   imageUrl,
    //   height: height ?? 50,
    //   width: width ?? 50,
    //   fit: fit,
    //   loadingBuilder: (BuildContext context, Widget child,
    //       ImageChunkEvent? loadingProgress) {
    //     if (loadingProgress == null) return child;
    //     return SizedBox(
    //       height: height ?? 50,
    //       width: width ?? 50,
    //       child: Center(
    //         child: CircularProgressIndicator(
    //           value: loadingProgress.expectedTotalBytes != null
    //               ? loadingProgress.cumulativeBytesLoaded /
    //                   loadingProgress.expectedTotalBytes!
    //               : null,
    //         ),
    //       ),
    //     );
    //   },
    //   errorBuilder:
    //       (BuildContext context, Object exception, StackTrace? stackTrace) {
    //     return errorWidget ?? AppImage(size: size);
    //   },
    // )
    CachedNetworkImage(
      imageUrl: imageUrl,
      height: height ?? 50,
      width: width ?? 50,
      fit: fit,
      placeholderFadeInDuration: const Duration(microseconds: 100),
      placeholder: (context, url) => const CircularIndicatorWidget(),
      errorWidget: (context, url, error) => errorWidget ?? AppImage(size: size),
    );
  }
}
