import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:insergemobileapplication/controller/static/LaunchAppsUrl.dart';
import 'package:insergemobileapplication/view/System/Widgets/AppBar/DefaultsAppBar.dart';
import 'package:insergemobileapplication/view/System/Widgets/Buttons/IconButtonRoundWidget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../model/proyecto_model.dart';
import '../../System/Settings/ProfileConstant.dart';
import '../../System/Widgets/Buttons/ShortButtonRoundWidget.dart';
import '../../System/Widgets/Content/ContentBordersWidget.dart';
import '../../System/Widgets/Content/RowDescriptionWidget.dart';
import '../ReportPages/ListReportPage.dart';
import '../ReportPages/NewReportPage.dart';

class DetailProyectPage extends StatefulWidget {
  final ProyectoModel proyectoModel;

  const DetailProyectPage(this.proyectoModel, {super.key});

  @override
  State<DetailProyectPage> createState() => _DetailProyectPageState();
}

class _DetailProyectPageState extends State<DetailProyectPage> {
  List<String> imagenesURLs = [];

  @override
  void initState() {
    super.initState();
    _chargeData();
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Barra
      appBar: DefaultsAppBar.defaultAppBarTitleChild(
          'Proyecto ${widget.proyectoModel.codProyecto}', [], context),
      body: Column(
        children: [
          Expanded(
            child: imagenesURLs.isNotEmpty
                ? CarouselSlider(
                    items: generateImages(),
                    options: CarouselOptions(
                      enlargeCenterPage: true,
                      aspectRatio: 1,
                      autoPlay: true,
                      scrollPhysics: const BouncingScrollPhysics(),
                      enableInfiniteScroll: false,
                      pauseAutoPlayInFiniteScroll: true,
                      viewportFraction: 1,
                    ),
                  )
                : const SizedBox(
                    height: 100,
                    child: Center(
                      child: Text(
                          'Aún no hay fotografias en los reportes para mostrar'),
                    ),
                  ),
          ),

          //Imagen

          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultShortPadding),
            child: Text(
              "Dirección: ${widget.proyectoModel.address}",
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          //DETALLES DEL PROYECTO
          Expanded(
            child: ContentBorders(
              child: Column(
                children: [
                  RowDescription(
                      title: 'Beneficiario:',
                      desc: "${widget.proyectoModel.beneficiario}"),
                  RowDescription(
                      title: 'DNI:', desc: "${widget.proyectoModel.dni}"),
                  RowDescription(
                      title: 'Teléfono:',
                      desc: "${widget.proyectoModel.telefono}"),
                  RowDescription(
                      title: 'Módulo:', desc: "${widget.proyectoModel.modulo}"),
                  RowDescription(
                      title: 'Coordenadas:',
                      desc: "${widget.proyectoModel.coordenadas}"),
                  RowDescription(
                      title: 'Ubigeo:',
                      desc:
                          "${widget.proyectoModel.departamento} - ${widget.proyectoModel.provincia} - ${widget.proyectoModel.distrito}"),
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Botón Llamadas
                        (widget.proyectoModel.telefono != '' &&
                                widget.proyectoModel.telefono != null)
                            ? IconButtonRound(
                                icon: Icons.call,
                                onTap: () => LaunchAppsURL.launchCall(
                                    widget.proyectoModel.telefono),
                              )
                            : const SizedBox(),
                        // Botón Google Maps
                        (widget.proyectoModel.coordenadas != '' &&
                                widget.proyectoModel.coordenadas != null)
                            ? IconButtonRound(
                                icon: Icons.local_taxi_outlined,
                                onTap: () => LaunchAppsURL.launchMap(
                                    '${widget.proyectoModel.coordenadas}'),
                              )
                            : const SizedBox(),
                        // Botón Nuevo de Reportes
                        ShortButtonRound(
                            title: 'Nuevo Reporte',
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          NewReportPage(widget.proyectoModel)));
                            }),
                        //Botón Historial de Reportes
                        ShortButtonRound(
                            title: 'Historial de reporte',
                            onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ListReportPage(widget.proyectoModel)),
                                )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _chargeData() {
    Future<ListResult> archivo = FirebaseStorage.instance
        .ref('/reportes')
        .child(widget.proyectoModel.dni.toString())
        .listAll();
    archivo.then((value) {
      value.items.forEach((element) async {
        imagenesURLs.add(await downloadFile(element));
        setState(() {});
      });
    });
  }

  Future<String> downloadFile(Reference ref) async {
    final String url = await ref.getDownloadURL();
    return url;
  }

  List<Widget> generateImages() {
    return imagenesURLs
        .map((element) => ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.network(
                element,
                fit: BoxFit.cover,
              ),
            ))
        .toList();
  }
}
