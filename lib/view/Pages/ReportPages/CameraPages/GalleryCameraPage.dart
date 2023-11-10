import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../model/proyecto_model.dart';
import '../../../../model/reportes_model.dart';
import '../../../System/Widgets/AppBar/DefaultsAppBar.dart';
import 'PhotoViewScream.dart';
import 'PhotosPrintPage.dart';

class GalleryCameraPage extends StatefulWidget {
  final ProyectoModel proyectoModel;
  final ReportesModel reporte;
  const GalleryCameraPage(this.proyectoModel,
      {super.key, required this.reporte});

  @override
  State<GalleryCameraPage> createState() =>
      _GalleryCameraPageState(nreporte: reporte);
}

class _GalleryCameraPageState extends State<GalleryCameraPage> {
  final ReportesModel nreporte;
  List<XFile> images = [XFile('')];
  _GalleryCameraPageState({required this.nreporte});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //UiAppbar
      appBar: DefaultsAppBar.defaultAppBar(context),
      body: SafeArea(
        child: SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: images.length,
            itemBuilder: (BuildContext context, int index) {
              File imageFile = File(images[index].path);
              if (images.length - 1 == index) {
                if (images.length < 6) {
                  return IconButton(
                    onPressed: () async {
                      String paths = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PhotosPrintPage()));
                      XFile pickedFile = XFile(paths);
                      images.insert(0, pickedFile);
                      setState(() {});
                    },
                    icon: const Icon(Icons.add),
                  );
                } else {
                  return const SizedBox();
                }
              } else {
                return Stack(children: [
                  Card(
                    child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PhotoViewScream(
                                        imageFile: imageFile,
                                      )));
                        },
                        child: Image.file(imageFile)),
                  ),
                  Positioned(
                      top: 1,
                      right: 1,
                      child: IconButton(
                          onPressed: () {
                            images.removeAt(index);
                            setState(() {});
                          },
                          icon: const Icon(Icons.close))),
                ]);
              }
            },
          ),
        ),
      ),
    );
  }
}
