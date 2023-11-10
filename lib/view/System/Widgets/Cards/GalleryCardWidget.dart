import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../../../../model/ImageGallery_model.dart';
import '../../Settings/ProfileConstant.dart';

class GalleryWidget extends StatefulWidget {
  final List<ModeloCardGallery> list;
  late int index;

  GalleryWidget({super.key, 
    required this.list,
    this.index = 0,
  });

  @override
  State<GalleryWidget> createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<GalleryWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          PhotoViewGallery.builder(
            pageController: PageController(initialPage: widget.index),
            itemCount: widget.list.length,
            builder: (context, index) {
              final urlImage = widget.list[index].src;
              return PhotoViewGalleryPageOptions(
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.contained * 4,
                imageProvider: AssetImage(urlImage),
              );
            },
            onPageChanged: (index) {
              setState(() {
                widget.index = index;
              });
            },
          ),
          Container(
            padding: const EdgeInsets.all(defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  widget.list[widget.index].desc != '' &&
                          widget.list[widget.index].desc != null
                      ? '${widget.list[widget.index].desc}'
                      : '',
                  style: const TextStyle(color: Colors.white),
                ),
                Text(
                  'Tipo de Archivo: ${widget.list[widget.index].type}',
                  style: const TextStyle(color: Colors.white),
                ),
                Text(
                  'Modulo: ${widget.list[widget.index].modulo}',
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
