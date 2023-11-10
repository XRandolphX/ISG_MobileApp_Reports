import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DefaultsAppBar extends AppBar {
  DefaultsAppBar({super.key});

  static AppBar defaultAppBar(
    BuildContext context,
  ) =>
      AppBar(
        elevation: 1,
        backgroundColor: Theme.of(context).canvasColor,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(
            "assets/icons/InsergeSVGM.svg",
            color: Colors.blueAccent,
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Piura, ${DateTime.now().year}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
      );

  static AppBar defaultAppBarTitle(
    String title,
    BuildContext context,
  ) =>
      AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(
            "assets/icons/InsergeSVGM.svg",
            color: Colors.blueAccent,
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
      );

  static AppBar defaultAppBarTitleChild(
    String title,
    List<Widget> buttons,
    BuildContext context,
  ) =>
      AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 1,
        actions: buttons,
        titleSpacing: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
      );
}
