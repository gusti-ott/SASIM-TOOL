import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Widget mcubeLogo() {
  final Uri mcubeUrl = Uri.parse('https://www.mcube-cluster.de/');

  Future<void> launchMcubeUrl() async {
    if (!await launchUrl(mcubeUrl)) {
      throw Exception('Could not launch $mcubeUrl');
    }
  }

  return Align(
    alignment: Alignment.topRight,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () async {
          launchMcubeUrl();
        },
        hoverColor: Colors.transparent,
        child: const Image(height: 64, image: AssetImage('assets/logos/mcube_logo.png')),
      ),
    ),
  );
}
