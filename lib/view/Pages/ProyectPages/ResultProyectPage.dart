import 'package:flutter/material.dart';
import 'package:insergemobileapplication/view/System/Settings/ProfileConstant.dart';
import 'package:insergemobileapplication/view/System/Widgets/Buttons/DoubleIconWidget.dart';

import '../../../controller/Api/intelligence_helper.dart';
import '../../../model/proyecto_model.dart';
import '../../../model/querybutton_model.dart';
import '../../System/Widgets/AppBar/DefaultsAppBar.dart';
import 'DetailProyectPage.dart';

class ResultProyectPage extends StatefulWidget {
  const ResultProyectPage({super.key, required this.query});
  final String query;

  @override
  State<ResultProyectPage> createState() => _ResultProyectPageState();
}

class _ResultProyectPageState extends State<ResultProyectPage> {
  String res = '';
  List<ProyectoModel>? proyectoData;
  List<QueryButtonModel> buttonsData = [];
  Stream<List<ProyectoModel>> listaDeProyects = const Stream.empty();

  @override
  void initState() {
    super.initState();
    _chargeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          DefaultsAppBar.defaultAppBarTitle('Resultado de búsqueda', context),
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Término buscado: ${widget.query}',
              ),
              const SizedBox(
                height: defaultPadding,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Text(
                    'Resultado de búsqueda:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: buttonsData.length,
                  itemBuilder: (context, index) {
                    return DoubleIconWidget(
                      desc: buttonsData[index].modulo,
                      sign: buttonsData[index].sing,
                      title: buttonsData[index].type,
                    );
                  },
                ),
              ),
              StreamBuilder<List<ProyectoModel>>(
                  stream: listaDeProyects,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Ocurrio el siguiente error al listar: '${snapshot.error}'",
                            style: const TextStyle(color: Colors.red),
                          ),
                        ],
                      ));
                    }
                    if (snapshot.hasData) {
                      proyectoData = snapshot.data;
                      if (proyectoData!.isEmpty) {
                        return const Text(
                            'No se encontraron proyectos que cumplan con estos requisitos.');
                      }

                      // Acá cambiar
                      return Expanded(
                          child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(
                            horizontal: defaultPadding,
                            vertical: defaultShortPadding),
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: defaultPadding,
                          );
                        },
                        shrinkWrap: true,
                        itemCount: proyectoData!.length,
                        itemBuilder: (context, index) {
                          final singleproyecto = proyectoData![index];
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: defaultShortPadding),
                            decoration: defaultBoxDecoration(
                                Theme.of(context).cardColor,
                                Theme.of(context).shadowColor),
                            child: ListTile(
                              title: Text(
                                "[${singleproyecto.codProyecto}] ${singleproyecto.beneficiario}",
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Dirección: ${singleproyecto.address}",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text(
                                    "DNI: ${singleproyecto.dni} | Telefono: ${singleproyecto.telefono}",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )
                                ],
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DetailProyectPage(singleproyecto),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ));
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
            ]),
      )),
    );
  }

  void _chargeData() async {
    Map<String, dynamic> decoded = await Search_helper.getData(widget.query);
    if (!decoded.containsKey('Error')) {
      // En caso de error no retorna nada
      listaDeProyects = await Search_helper.read(decoded);
      buttonsData = Search_helper.readMap(decoded);
    }
    setState(() {});
  }
}
