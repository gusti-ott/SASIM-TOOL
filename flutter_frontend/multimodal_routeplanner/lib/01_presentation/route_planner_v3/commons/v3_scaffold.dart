import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class V3Scaffold extends StatelessWidget {
  const V3Scaffold(
      {super.key,
      this.scaffoldKey,
      this.appBar,
      this.drawer,
      this.floatingActionButton,
      this.floatingActionButtonLocation,
      this.backgroundColor,
      required this.body});

  final GlobalKey<ScaffoldState>? scaffoldKey;
  final AppBar? appBar;
  final Drawer? drawer;
  final FloatingActionButton? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Color? backgroundColor;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    bool isDesktop = kIsWeb || Platform.isWindows || Platform.isLinux || Platform.isMacOS;

    return InteractiveViewer(
      scaleEnabled: !isDesktop,
      child: SelectionArea(
        child: Scaffold(
          key: scaffoldKey,
          appBar: appBar,
          drawer: drawer,
          floatingActionButton: floatingActionButton,
          floatingActionButtonLocation: floatingActionButtonLocation,
          backgroundColor: backgroundColor,
          body: body,
        ),
      ),
    );
  }
}
