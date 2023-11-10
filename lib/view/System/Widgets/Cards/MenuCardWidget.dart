import 'package:flutter/material.dart';

import '../../Settings/ProfileConstant.dart';

class CardMenu extends StatelessWidget {
  const CardMenu({
    Key? key,
    required this.title,
    required this.desc,
    required this.icono,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final String desc;
  final Icon icono;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: BorderRadius.circular(defaultBorderRadius),
          boxShadow: defaultBoxShadow(Theme.of(context).shadowColor),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icono,
            const SizedBox(height: 1),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 1),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: defaultShortPadding),
              child: Text(
                desc,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.normal),
              ),
            )
          ],
        ),
      ),
    );
  }
}
