import 'package:flutter/material.dart';

import '../../Settings/ProfileConstant.dart';

class ContentBorders extends StatelessWidget {
  const ContentBorders({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        boxShadow: defaultBoxShadow(Theme.of(context).shadowColor),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(defaultCirculeBorderRadius),
          topRight: Radius.circular(defaultCirculeBorderRadius),
        ),
      ),
      padding: const EdgeInsets.all(defaultPadding),
      margin: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(), child: child),
    );
  }
}
