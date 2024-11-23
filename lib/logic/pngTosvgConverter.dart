import 'package:url_launcher_web/url_launcher_web.dart';
import 'dart:html' as html;

launchUrlToSite() async {
  final String url =
      "https://youtube.com/clip/Ugkx-Xg1mcb6EsE2pVA3vsxkZ9GWq6uc1Jtx?si=WD9HTRCjG1BGi1v2";
  html.window.open(url, "Theos message to you");
}
