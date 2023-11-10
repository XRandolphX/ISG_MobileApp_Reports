import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:insergemobileapplication/view/System/Settings/ProfileConstant.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(defaultShortPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('Inserge Movil - Copyright'),
            Icon(Icons.copyright)
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(defaultPadding),
                  decoration: const BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(90),
                        bottomRight: Radius.circular(90)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(defaultPadding),
                        child: SvgPicture.asset(
                          "assets/icons/InsergeSVGM.svg",
                          color: Colors.white,
                          height: 80,
                        ),
                      ),
                      const Padding(
                          padding: EdgeInsets.all(defaultPadding),
                          child: Icon(
                            Icons.join_inner_rounded,
                            color: Colors.white,
                          )),
                      Container(
                        width: 120,
                        padding: const EdgeInsets.all(defaultPadding),
                        child: Image.asset(
                            'assets/icons/logo-universidad-cesar-vallejo.png'),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(defaultLargePadding),
                  child: Text(
                    'Inserge - UCV',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ),
                const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: defaultLargePadding),
                  child: Text(
                    'Este aplicativo movil fue desarrollado como proyecto para los cursos de Patrones de diseño de realidad virtual, Programación de aplicativos moviles y Sistemas inteligentes del septimo ciclo de la Universidad Cesar Vallejo Sede Piura',
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Text(
                    'Tecnologias usadas',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: defaultLargePadding),
                  child: Text(
                    'La principal tecnologia para desarrollar este aplicativo fue Flutter, sin embargo, para distintas funciones referentes a herramientas como la busqueda interpretada, visualizador de modulos en 3D, etc. hemos usado: Unity, Python, Flask, Heroku, Firestore, TensorFlow, Revit, etc.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      padding: const EdgeInsets.all(defaultPadding),
                      child: Image.asset('assets/icons/logo-flutter.png'),
                    ),
                    Container(
                      width: 120,
                      padding: const EdgeInsets.all(defaultPadding),
                      child: Image.asset('assets/icons/logo-python.png'),
                    ),
                    Container(
                      width: 120,
                      padding: const EdgeInsets.all(defaultPadding),
                      child: Image.asset('assets/icons/logo-unity.png'),
                    ),
                  ],
                ),
                const SizedBox(height: defaultPadding),
                const Text('Piura - Perú'),
                const SizedBox(height: defaultShortPadding),
                const Text('2022'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
