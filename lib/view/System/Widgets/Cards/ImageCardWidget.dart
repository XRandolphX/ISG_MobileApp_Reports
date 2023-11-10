import 'package:flutter/material.dart';

import '../../../../model/ImageGallery_model.dart';
import '../../Settings/ProfileConstant.dart';
import 'GalleryCardWidget.dart';

class ImageCardWidget extends StatelessWidget {
  const ImageCardWidget({
    Key? key,
    required this.title,
    required this.index,
    required this.image,
    required this.list,
    required this.context,
  }) : super(key: key);

  final String title;
  final int index;
  final String image;
  final BuildContext context;
  final List<ModeloCardGallery> list;

  @override
  Widget build(BuildContext aea) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GalleryWidget(
              list: list,
              index: index,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius:
              const BorderRadius.all(Radius.circular(defaultBorderRadius)),
          boxShadow: defaultBoxShadow(Theme.of(context).shadowColor),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(defaultBorderRadius),
              child: Image.asset(image),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(
                title,
                overflow: TextOverflow.clip,
                style: TextStyle(
                    color: Theme.of(context).appBarTheme.backgroundColor),
                softWrap: false,
              ),
            ),
            const SizedBox(
              height: 1,
            )
          ],
        ),
      ),
    );
  }
}
