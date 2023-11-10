import 'package:flutter/material.dart';

import '../../../../controller/static/ListGalery.dart';
import '../../../../model/ImageGallery_model.dart';
import '../../../System/Settings/ProfileConstant.dart';
import '../../../System/Widgets/Cards/ImageCardWidget.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({Key? key}) : super(key: key);

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  int _currentSelection = 0;
  int _currentSelection2 = 0;

  String module = '';
  String type = '';

  List<ModeloCardGallery> _listGallery = List.of(modeloCardGallery);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.all(defaultPadding),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _customRadioButton("3M", 1),
                    _customRadioButton("3.5M", 2),
                    _customRadioButton("4M", 3),
                    _customRadioButton("5M", 4),
                    _customRadioButton("6M", 5),
                    _customRadioButton("7M", 6),
                  ],
                ),
                const SizedBox(height: defaultShortPadding),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _customRadioButton2("Fotografias", 1),
                    _customRadioButton2("Renders", 2),
                    _customRadioButton2("Planos", 3),
                  ],
                ),
                GridView.count(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  mainAxisSpacing: defaultPadding,
                  primary: false,
                  crossAxisSpacing: defaultPadding,
                  children: List.generate(
                    _listGallery.length,
                    growable: true,
                    (index) {
                      return ImageCardWidget(
                        context: context,
                        index: index,
                        image: _listGallery[index].src,
                        title: _listGallery[index].desc != '' &&
                                _listGallery[index].desc != null
                            ? '${_listGallery[index].desc}'
                            : '${_listGallery[index].type} de ${_listGallery[index].modulo}',
                        list: _listGallery,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void modifyList() {
    _listGallery = List.empty(growable: true);
    if (_currentSelection == 0 && _currentSelection2 == 0) {
      for (var element in modeloCardGallery) {
        _listGallery.add(element);
      }
    } else {
      if (_currentSelection != 0 && _currentSelection2 == 0) {
        for (var element in modeloCardGallery) {
          if (module == element.modulo) {
            _listGallery.add(element);
          }
        }
      } else if (_currentSelection == 0 && _currentSelection2 != 0) {
        for (var element in modeloCardGallery) {
          if (type == element.type) {
            _listGallery.add(element);
          }
        }
      } else if (_currentSelection != 0 && _currentSelection2 != 0) {
        for (var element in modeloCardGallery) {
          if (module == element.modulo && type == element.type) {
            _listGallery.add(element);
          }
        }
      }
    }
  }

  Widget _customRadioButton(String title, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (index == _currentSelection) {
            _currentSelection = 0;
          } else {
            _currentSelection = index;
            module = title;
          }

          modifyList();
        });
      },
      child: Container(
        padding: const EdgeInsets.all(defaultPadding),
        decoration: defaultBoxDecoration(
            Theme.of(context).canvasColor, Theme.of(context).shadowColor),
        child: Text(
          title,
          style: TextStyle(
              color: (_currentSelection == index)
                  ? Colors.blueAccent
                  : Theme.of(context).appBarTheme.backgroundColor,
              fontWeight: (_currentSelection == index)
                  ? FontWeight.bold
                  : FontWeight.normal),
        ),
      ),
    );
  }

  Widget _customRadioButton2(String title, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (index == _currentSelection2) {
            _currentSelection2 = 0;
          } else {
            _currentSelection2 = index;
            type = title;
          }
          modifyList();
        });
      },
      child: Container(
        padding: const EdgeInsets.all(defaultPadding),
        decoration: defaultBoxDecoration(
            Theme.of(context).canvasColor, Theme.of(context).shadowColor),
        child: Text(
          title,
          style: TextStyle(
              color: (_currentSelection2 == index)
                  ? Colors.blueAccent
                  : Theme.of(context).appBarTheme.backgroundColor,
              fontWeight: (_currentSelection2 == index)
                  ? FontWeight.bold
                  : FontWeight.normal),
        ),
      ),
    );
  }
}
