import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';

import '../../../System/Settings/ProfileConstant.dart';
import '../../../System/Widgets/Buttons/IconButtonWidget.dart';

class RendersPage extends StatefulWidget {
  const RendersPage({Key? key}) : super(key: key);

  @override
  State<RendersPage> createState() => _RendersPageState();
}

class _RendersPageState extends State<RendersPage> {
  late UnityWidgetController _unityWidgetController;
  double _sliderValue = 0.0;
  bool movementX = true;
  bool movementY = false;
  bool wallsVisibility = false;
  int listModulsIndex = 0;
  int listPersonIndex = 0;

  final List<List<String>> _listModuls = [
    [
      "3 metros",
      "Módulo que cuenta con dos plantas, en el primero se tiene espacios para cocina, comedor, baño y lavandería, en la segunda planta se tiene espacios para dos dormitorios uno en frente del otro, perfecto para una convivencia tranquila. "
    ],
    [
      "4 metros",
      "Módulo que cuenta con una planta con espacios para cocina, comedor, sala, lavandería contiguo con el baño como ambientes comunes y dos dormitorios adjuntos."
    ],
    ["5 metros", "En desarrollo..."],
    [
      "6 metros",
      "Módulo que cuenta con una planta con espacios para para cocina, comedor, sala, lavandería, y baño frente a uno de los dos dormitorios adjuntos."
    ],
    ["7 metros", "En desarrollo..."]
  ];

  final List<String> _listPersons = [
    "",
    "Kid",
    "Adult",
    "Woman",
  ];

  void defaultValues() {
    _sliderValue = 0.0;
    movementX = true;
    movementY = false;
    wallsVisibility = false;
    listPersonIndex = 0;
  }

  @override
  void initState() {
    defaultValues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 350,
                child: Stack(
                  children: <Widget>[
                    UnityWidget(
                      onUnityCreated: onUnityCreated,
                      onUnityMessage: onUnityMessage,
                      fullscreen: false,
                    ),
                    Positioned(
                      bottom: 40,
                      right: 20,
                      child: Card(
                        elevation: 2,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                IconButtonWidget(
                                  icono: Icon(
                                    Icons.close,
                                    color:
                                        movementX ? Colors.green : Colors.black,
                                  ),
                                  onTap: () {
                                    setState(() {
                                      movementX = movementX ? false : true;
                                    });
                                    setMovementX(movementX.toString());
                                  },
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                IconButtonWidget(
                                  icono: Icon(
                                    Icons.currency_yuan,
                                    color:
                                        movementY ? Colors.green : Colors.black,
                                  ),
                                  onTap: () {
                                    setState(() {
                                      movementY = movementY ? false : true;
                                    });
                                    setMovementY(movementY.toString());
                                  },
                                ),
                              ],
                            ),
                            Container(),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 16,
                      right: 20,
                      child: Card(
                        elevation: 2,
                        child: Row(
                          children: [
                            IconButtonWidget(
                              icono: Icon(
                                wallsVisibility
                                    ? Icons.remove_red_eye
                                    : Icons.remove_red_eye_outlined,
                                color: wallsVisibility
                                    ? Colors.green
                                    : Colors.black,
                              ),
                              onTap: () {
                                wallsVisibility =
                                    wallsVisibility ? false : true;
                                setState(() {});
                                setWallsVisibility(wallsVisibility.toString());
                              },
                            ),
                            IconButtonWidget(
                              icono: Icon(
                                _listPersons[listPersonIndex] == ""
                                    ? Icons.person_off
                                    : _listPersons[listPersonIndex] == "Kid"
                                        ? Icons.smart_toy_rounded
                                        : _listPersons[listPersonIndex] ==
                                                "Adult"
                                            ? Icons.boy_rounded
                                            : Icons.woman,
                              ),
                              onTap: () {
                                if (listPersonIndex ==
                                    _listPersons.length - 1) {
                                  listPersonIndex = 0;
                                } else {
                                  listPersonIndex++;
                                }
                                setState(() {});
                                setPersonVisibility('');
                              },
                            ),
                            Container(
                              height: 25,
                              width: 25,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                elevation: 2,
                margin: const EdgeInsets.all(defaultPadding),
                child: Column(
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text("Velocidad de Rotación"),
                    ),
                    Slider(
                      onChanged: (value) {
                        setState(() {
                          _sliderValue = value;
                        });
                        setRotationSpeed(value.toStringAsFixed(3));
                      },
                      value: _sliderValue,
                      min: 0.000,
                      max: 0.010,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButtonWidget(
                      icono: const Icon(Icons.arrow_left),
                      onTap: () {
                        if (listModulsIndex != 0) {
                          listModulsIndex--;
                          previusModule();
                          defaultValues();
                          setState(() {});
                        }
                      },
                    ),
                    Text("Modulo de ${_listModuls[listModulsIndex][0]}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Theme.of(context).appBarTheme.backgroundColor,
                        )),
                    IconButtonWidget(
                      icono: const Icon(Icons.arrow_right),
                      onTap: () {
                        if (listModulsIndex != _listModuls.length - 1) {
                          listModulsIndex++;
                          nextModule();
                          defaultValues();
                          setState(() {});
                        }
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(defaultLargePadding),
                child: Text(_listModuls[listModulsIndex][1],
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                        color: Theme.of(context).appBarTheme.backgroundColor)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Communcation from Flutter to Unity
  void setRotationSpeed(String speed) {
    _unityWidgetController.postMessage(
      'Rotation',
      'SetRotationSpeed',
      speed,
    );
  }

  // Communcation from Flutter to Unity
  void setMovementX(String bool) {
    _unityWidgetController.postMessage(
      'Cube',
      'SetMovementX',
      bool,
    );
  }

  // Communcation from Flutter to Unity
  void setMovementY(String bool) {
    _unityWidgetController.postMessage(
      'Cube',
      'SetMovementY',
      bool,
    );
  }

  // Communcation from Flutter to Unity
  void setWallsVisibility(String bool) {
    _unityWidgetController.postMessage(
      'Cube',
      'SetWallsVisibility',
      bool,
    );
  }

  // Communcation from Flutter to Unity
  void setPersonVisibility(String bool) {
    _unityWidgetController.postMessage(
      'Cube',
      'SetPersonVisibility',
      bool,
    );
  }

  // Communication from Unity to Flutter
  void onUnityMessage(message) {
    print('Received message from unity: ${message.toString()}');
  }

  // Callback that connects the created controller to the unity controller
  void onUnityCreated(controller) {
    this._unityWidgetController = controller;
  }

  // Communication from Unity when new scene is loaded to Flutter
  void onUnitySceneLoaded(SceneLoaded sceneInfo) {
    print('Received scene loaded from unity: ${sceneInfo.name}');
    print(
        'Received scene loaded from unity buildIndex: ${sceneInfo.buildIndex}');
  }

  void nextModule() {
    _unityWidgetController.postMessage(
      'Cube',
      'NextModule',
      '',
    );
  }

  void previusModule() {
    _unityWidgetController.postMessage(
      'Cube',
      'PreviusModule',
      '',
    );
  }
}
