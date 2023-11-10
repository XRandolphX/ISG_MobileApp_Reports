
import 'package:flutter/material.dart';

import '../../Settings/ProfileConstant.dart';

class DoubleIconWidget extends StatelessWidget {
  const DoubleIconWidget({
    Key? key,
    required this.title,
    required this.sign,
    required this.desc,
  }) : super(key: key);

  final String? title;
  final String? sign;
  final String? desc;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultShortPadding),
      margin: const EdgeInsets.symmetric(
          horizontal: defaultMiniPadding, vertical: defaultShortPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: BorderRadius.circular(defaultBorderRadius),
        boxShadow: [
          BoxShadow(
            color: (title == 'Probabilidad')
                ? double.parse(desc!) > 0.5
                    ? (double.parse(desc!) >= 0.75)
                        ? Colors.green.shade500
                        : Colors.green.shade100
                    : (double.parse(desc!) > 0.25)
                        ? Colors.red.shade700
                        : Colors.red.shade900
                : (title == 'Colección')
                    ? Colors.blue
                    : Colors.orange,
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(
              0,
              0,
            ), // changes position of shadow
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$title $sign ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text('$desc'),
        ],
      ),
    );
  }
}
