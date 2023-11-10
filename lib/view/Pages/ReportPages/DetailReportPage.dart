import 'package:carousel_slider/carousel_slider.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:insergemobileapplication/controller/helper/management_helper.dart';
import 'package:insergemobileapplication/view/System/Widgets/AppBar/DefaultsAppBar.dart';
import 'package:insergemobileapplication/view/System/Widgets/Content/ContentBordersWidget.dart';
import 'package:insergemobileapplication/view/System/Widgets/Content/RowDescriptionWidget.dart';

import '../../../model/reportes_model.dart';
import '../../System/Settings/ProfileConstant.dart';

class DetailReportPage extends StatefulWidget {
  final ReportesModel reporteModel;

  const DetailReportPage(this.reporteModel, {super.key});

  @override
  State<DetailReportPage> createState() => _DetailReportPageState();
}

class _DetailReportPageState extends State<DetailReportPage> {
  late String _observacionString;
  late String _fechaString;
  late String _horaString;
  String _userName = "";

  List<Widget> generateImages() {
    return widget.reporteModel.url!
        .map((element) => ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.network(
                element,
                fit: BoxFit.cover,
              ),
            ))
        .toList();
  }

  @override
  void initState() {
    _chargeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultsAppBar.defaultAppBarTitleChild(
          'Detalle del reporte "${widget.reporteModel.getDate()}"',
          [
            IconButton(
                icon: const Icon(Icons.content_copy),
                onPressed: () async {
                  await FlutterClipboard.copy(widget.reporteModel
                      .getDataToCopy('Registrado por: $_userName'));
                  ScaffoldMessenger.of(this.context)
                      .showSnackBar(const SnackBar(
                    content: Text("Copiado correctamente"),
                  ));
                }),
          ],
          context),
      body: Column(
        children: [
          //Card con Imagen
          const SizedBox(height: defaultPadding),
          Expanded(
            child: CarouselSlider(
              items: generateImages(),
              options: CarouselOptions(
                enlargeCenterPage: true,
                aspectRatio: 1,
                enableInfiniteScroll: false,
                autoPlay: true,
                scrollPhysics: const BouncingScrollPhysics(),
                viewportFraction: 1,
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          //Card Detalle
          Expanded(
            child: ContentBorders(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: defaultShortPadding,
                ),
                RowDescription(title: 'Estado:', desc: _estado()),
                RowDescription(title: 'Fecha:', desc: _fechaString),
                RowDescription(title: 'Hora:', desc: _horaString),
                RowDescription(desc: _preguntaone()),
                RowDescription(desc: _preguntatwo()),
                RowDescription(desc: _preguntathree()),
                RowDescription(title: 'Usuario:', desc: _userName),
                const Text(
                  'Observación:',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Text(_observacionString,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      )),
                ),
              ],
            )),
          ),
        ],
      ),
    );
  }

  _chargeData() {
    _observacionString = "${widget.reporteModel.observacion}";
    _fechaString = widget.reporteModel.getDate();
    _horaString = widget.reporteModel.getHour();
    UserManagement.getUserName(widget.reporteModel.userUID).then((value) {
      setState(() {
        if (value != null) {
          _userName = value;
        }
      });
    });
  }

  _estado() {
    return widget.reporteModel.getEstado();
  }

  _preguntaone() {
    return widget.reporteModel.getPreguntaOne();
  }

  _preguntatwo() {
    return widget.reporteModel.getPreguntaTwo();
  }

  _preguntathree() {
    return widget.reporteModel.getPreguntaThree();
  }
}
