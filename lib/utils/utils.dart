import 'package:url_launcher/url_launcher_string.dart';

Future<void> launchUrl(String url) async {

  if (!await launchUrlString(url , mode: LaunchMode.externalApplication)) {
    throw 'Could not launch $url';
  }
}