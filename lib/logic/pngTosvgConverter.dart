import 'package:url_launcher/url_launcher.dart';

launchUrlToSite() async {
  final Uri url = Uri.parse(
      "https://youtube.com/clip/Ugkx-Xg1mcb6EsE2pVA3vsxkZ9GWq6uc1Jtx?si=WD9HTRCjG1BGi1v2");
  await launchUrl(url);
}
