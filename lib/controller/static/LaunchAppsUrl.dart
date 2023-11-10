import 'package:url_launcher/url_launcher.dart';

class LaunchAppsURL {
  static Future<Function(void p1)?> launchEmail(
      {String? Correo, String? sujeto, String? cuerpo}) async {
    String url = 'mailto:$Correo?subject=$sujeto&body=$cuerpo';
    try {
      await launch(url);
    } catch (e) {
      print('Ocurrio un error: $e');
    }
  }

  static Future<Function(void p1)?> launchCall(String? phone) async {
    String url = 'tel:$phone';
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  static Future<Function(void p1)?> launchMap(String? coordenates) async {
    String url = 'https://www.google.com/maps/search/?api=1&query=$coordenates';
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}
