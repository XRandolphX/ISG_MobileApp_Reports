import 'package:flutter/material.dart';

import '../../Settings/ProfileConstant.dart';

class ImageBorders extends StatelessWidget {
  const ImageBorders({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.orangeAccent,
      ),
      padding: const EdgeInsets.all(defaultMiniPadding),
      child: Center(
        
        child: child,
      ),
    );
  }
}
