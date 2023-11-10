import 'package:flutter/material.dart';

class IconButtonWidget extends StatelessWidget {
  IconButtonWidget({
    Key? key,
    this.icono,
    required this.onTap,
  }) : super(key: key);

  Icon? icono;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).cardColor,
      child: InkWell(
        
          onTap: onTap,
          child: Center(
            child: icono,
          )),
    );
  }
}
