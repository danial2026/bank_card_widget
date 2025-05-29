import 'package:url_launcher/url_launcher.dart';

/// Helper class for launching URLs
class UrlLauncherHelper {
  /// Launches a URL in the external browser
  static Future<void> launchUrlExternal(String url) async {
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  /// Package-specific URLs
  static const String pubDevUrl = 'https://pub.dev/packages/time_range_sheet_widget';
  static const String githubUrl = 'https://github.com/danial2026/time_range_sheet_widget';

  /// Launch pub.dev page
  static Future<void> launchPubDev() => launchUrlExternal(pubDevUrl);

  /// Launch GitHub repository
  static Future<void> launchGitHub() => launchUrlExternal(githubUrl);
}
