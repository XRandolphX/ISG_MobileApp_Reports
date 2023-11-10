import 'package:flutter/material.dart';
import 'package:insergemobileapplication/view/System/Widgets/AppBar/DefaultsAppBar.dart';

import '../../../controller/helper/reportes_helper.dart';
import '../../../model/proyecto_model.dart';
import '../../../model/reportes_model.dart';
import '../../System/Settings/ProfileConstant.dart';
import 'DetailReportPage.dart';

class ListReportPage extends StatefulWidget {
  final ProyectoModel proyectoModel;

  const ListReportPage(this.proyectoModel, {super.key});

  @override
  State<ListReportPage> createState() => _ListReportPageState();
}

class _ListReportPageState extends State<ListReportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          DefaultsAppBar.defaultAppBarTitle('Historial de reportes', context),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: StreamBuilder<List<ReportesModel>>(
              stream: Reportes_helper.read(widget.proyectoModel.id.toString()),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.toString()),
                  );
                }
                if (snapshot.hasData) {
                  final reportesData = snapshot.data;
                  return ListView.separated(
                    separatorBuilder: (context, index) {
                      return const Divider(
                        height: 3,
                        indent: 73,
                        endIndent: 15,
                        color: Colors.orange,
                        thickness: 1,
                      );
                    },
                    shrinkWrap: true,
                    itemCount: reportesData!.length,
                    itemBuilder: (context, index) {
                      final singlereportes = reportesData[index];
                      return ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Image.network(
                            singlereportes.url!.elementAt(0),
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          "Fecha: " +
                              "${singlereportes.fecharegistro?.day}/${singlereportes.fecharegistro?.month}/${singlereportes.fecharegistro?.year}",
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        subtitle: Text(
                            "Hora: ${singlereportes.fecharegistro?.hour}:${singlereportes.fecharegistro?.minute}"),
                        trailing: const Icon(Icons.arrow_forward_rounded,
                            color: Colors.orange),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DetailReportPage(singlereportes)));
                        },
                      );
                    },
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }),
        ),
      ),
    );
  }
}
