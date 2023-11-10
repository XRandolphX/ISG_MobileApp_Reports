import 'package:flutter/material.dart';
import 'package:insergemobileapplication/view/Pages/ProyectPages/DetailProyectPage.dart';
import 'package:insergemobileapplication/view/Pages/ProyectPages/ResultProyectPage.dart';

import '../../../controller/helper/proyectos_helper.dart';
import '../../../model/proyecto_model.dart';
import '../../System/Settings/ProfileConstant.dart';

class ListProyectPage extends StatefulWidget {
  const ListProyectPage({super.key});

  @override
  State<ListProyectPage> createState() => _ListProyectPageState();
}

enum ViewType { grid, list }

class _ListProyectPageState extends State<ListProyectPage> {
  final formKey = GlobalKey<FormState>();
  late List<ProyectoModel> lista;

  ViewType _viewType = ViewType.grid;

  final TextEditingController _searchQuery = TextEditingController();
  List<ProyectoModel>? proyectoData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: defaultPadding,
                left: defaultPadding,
                right: defaultPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Proyectos",
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                      fontWeight: FontWeight.w500, color: Colors.indigo),
                ),
                const SizedBox(height: defaultPadding),
                const Text(
                  "Repositorio de proyectos Inserge",
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: defaultPadding),
                Form(
                  key: formKey,
                  child: TextFormField(
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "Ingresa una búsqueda";
                      } else {
                        return null;
                      }
                    },
                    controller: _searchQuery,
                    decoration: InputDecoration(
                        hintText: "Buscar proyectos...",
                        filled: true,
                        border: InputBorder.none,
                        enabledBorder: outlineInputBorder,
                        focusedBorder: outlineInputBorder,
                        prefixIcon: const Padding(
                          padding: EdgeInsets.all(12),
                          child: Icon(Icons.search),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ResultProyectPage(
                                            query: _searchQuery.text,
                                          )));
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(defaultBorderRadius))),
                          ),
                          icon: const Icon(Icons.filter_alt_outlined),
                        )),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Proyectos',
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    SizedBox(
                      child: IconButton(
                        icon: Icon(_viewType == ViewType.list
                            ? Icons.grid_on
                            : Icons.view_list),
                        onPressed: () {
                          changeList();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          StreamBuilder<List<ProyectoModel>>(
              stream: Proyecto_helper.read(),
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
                  // Acá cambiar
                  return Expanded(
                    child: (_viewType != ViewType.list)
                        ? ListView.separated(
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
                                decoration: defaultBoxDecoration(
                                    Theme.of(context).canvasColor,
                                    Theme.of(context).shadowColor),
                                padding:
                                    const EdgeInsets.all(defaultMiniPadding),
                                child: ListTile(
                                  title: Text(
                                    "${singleproyecto.address}",
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "[${singleproyecto.codProyecto}] ${singleproyecto.beneficiario}",
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
                          )
                        : GridView.builder(
                            padding: const EdgeInsets.all(defaultPadding),
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: proyectoData!.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12.0,
                              mainAxisSpacing: 12.0,
                              mainAxisExtent: 180,
                            ),
                            itemBuilder: (context, index) {
                              final listaM = proyectoData![index];
                              return InkResponse(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DetailProyectPage(listaM),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(defaultPadding),
                                  decoration: defaultBoxDecoration(
                                      Theme.of(context).cardColor,
                                      Theme.of(context).shadowColor),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${listaM.codProyecto}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1!
                                            .merge(
                                              const TextStyle(
                                                  fontWeight: FontWeight.w700),
                                            ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(
                                        height: 8.0,
                                      ),
                                      Text(
                                        "${listaM.beneficiario}",
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1!
                                            .merge(
                                              const TextStyle(
                                                  fontWeight: FontWeight.w700),
                                            ),
                                      ),
                                      const SizedBox(
                                        height: 8.0,
                                      ),
                                      Text(
                                        "${listaM.dni}",
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1!
                                            .merge(
                                              const TextStyle(
                                                  fontWeight: FontWeight.w700),
                                            ),
                                      ),
                                      const SizedBox(
                                        height: 8.0,
                                      ),
                                      Text(
                                        "${listaM.distrito}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .merge(const TextStyle(
                                                fontWeight: FontWeight.w700)),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }),
        ],
      ),
    );
  }

  void changeList() {
    if (_viewType == ViewType.list) {
      _viewType = ViewType.grid;
    } else {
      _viewType = ViewType.list;
    }
    setState(() {});
  }
}
