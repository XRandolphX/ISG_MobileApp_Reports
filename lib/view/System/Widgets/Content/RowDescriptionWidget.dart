import 'package:flutter/material.dart';

import '../../Settings/ProfileConstant.dart';

class RowDescription extends StatelessWidget {
  RowDescription({
    super.key,
    this.title,
    required this.desc,
  });

  String? title;
  final String? desc;

  @override
  Widget build(BuildContext context) {
    if (desc != '' && desc != 'null' && desc != null) {
      if (title == null) {
        return Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  desc!,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
            const SizedBox(height: defaultPadding),
          ],
        );
      } else {
        return Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title!,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Flexible(
                  child: Text(
                    desc!,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        overflow: TextOverflow.ellipsis),
                  ),
                ),
              ],
            ),
            const SizedBox(height: defaultPadding),
          ],
        );
      }
    } else {
      return const SizedBox();
    }
  }
}
