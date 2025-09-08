import 'package:url_launcher/url_launcher.dart' as launcher;

extension OpenUrlExtension on String {
  ///Open url with string
  Future<bool> openUrl() async {
    if (isNotEmpty) {
      final uri = Uri.parse(this);
      if (await launcher.canLaunchUrl(uri)) {
        return launcher.launchUrl(
          uri,
          // forceWebView: true
        );
      }
    }
    return false;
  }
}
