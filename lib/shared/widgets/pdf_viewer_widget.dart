import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

class PDFViewer extends StatelessWidget {
  const PDFViewer({super.key, required this.url});
  final String url;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const PDF().cachedFromUrl(
          url,
          placeholder: (progress) {
            return const Center(child: CircularProgressIndicator());
          },
          errorWidget: (error) => Center(child: Text(error.toString())),
        ),
      ],
    );
  }
}
