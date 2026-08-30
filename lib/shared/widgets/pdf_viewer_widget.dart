import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class PDFViewer extends StatelessWidget {
  const PDFViewer({super.key, required this.url});
  final String url;

  @override
  Widget build(BuildContext context) {
    final viewerUrl =
        'https://docs.google.com/gview?embedded=true&url=${Uri.encodeComponent(url)}';
    return InAppWebView(
      initialUrlRequest: URLRequest(url: WebUri.uri(Uri.parse(viewerUrl))),
      initialSettings: InAppWebViewSettings(),
      onLoadStart: (_, __) {},
      onLoadStop: (_, __) {},
    );
  }
}
