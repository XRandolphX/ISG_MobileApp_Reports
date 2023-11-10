import 'package:flutter/material.dart';

import '../../Settings/ProfileConstant.dart';

class IconButtonRound extends StatelessWidget {
  const IconButtonRound({
    Key? key,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: defaultMiniPadding),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).focusColor,
            padding: const EdgeInsets.symmetric(
                vertical: defaultMiniPadding, horizontal: defaultPadding),
            elevation: 0,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(50)))),
        onPressed: onTap,
        child: Icon(
          icon,
        ),
      ),
    );
  }
}
