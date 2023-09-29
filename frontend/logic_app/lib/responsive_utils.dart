import 'package:flutter/material.dart';
import 'dart:core';

class ResponsiveScreen extends StatelessWidget {
  final Widget portraitLayout;
  final Widget landscapeLayout;

  ResponsiveScreen({
    required this.portraitLayout,
    required this.landscapeLayout,
  });

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      return portraitLayout;
    } else {
      return landscapeLayout;
    }
  }
}

mixin ResponsiveMixin<T extends StatefulWidget> on State<T> {
  Widget buildPortraitLayout();
  Widget buildLandscapeLayout();

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      return buildPortraitLayout();
    } else {
      return buildLandscapeLayout();
    }
  }
}

abstract class BaseResponsiveScreen extends StatefulWidget {
  const BaseResponsiveScreen({Key? key}) : super(key: key);

  Widget buildPortraitLayout(BuildContext context);
  Widget buildLandscapeLayout(BuildContext context);
}

class _BaseResponsiveScreenState extends State<BaseResponsiveScreen> {
  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      return widget.buildPortraitLayout(context);
    } else {
      return widget.buildLandscapeLayout(context);
    }
  }
}
