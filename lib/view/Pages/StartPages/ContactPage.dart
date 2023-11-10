import 'package:flutter/material.dart';
import 'package:insergemobileapplication/controller/static/LaunchAppsUrl.dart';
import 'package:insergemobileapplication/view/System/Settings/ProfileConstant.dart';
import 'package:insergemobileapplication/view/System/Widgets/Buttons/IconButtonRoundWidget.dart';
import 'package:insergemobileapplication/view/System/Widgets/Buttons/ShortButtonRoundWidget.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 120,
                      padding: const EdgeInsets.all(defaultPadding),
                      child: Image.asset('assets/icons/logo-inserge.png'),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Text(
                    'Información de contacto',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(defaultLargePadding),
                  child: Text(
                    'La empresa Ingenieria y Servicios Generales Piura S.A.C. pone a dispocición estos canales de servicio para el contacto con sus principales representantes',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: defaultLargePadding,
                      vertical: defaultShortPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Telefono',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(),
                      Text(
                        '+51 923 206 089',
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: defaultLargePadding,
                      vertical: defaultShortPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Correo',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(),
                      Text(
                        'Insergepiurasac@gmail.com',
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButtonRound(
                      icon: Icons.call,
                      onTap: () => LaunchAppsURL.launchCall('+51 923206089'),
                    ),
                    IconButtonRound(
                      icon: Icons.mail,
                      onTap: () => LaunchAppsURL.launchEmail(
                        Correo: 'Insergepiurasac@gmail.com',
                        cuerpo:
                            '¡Hola, es un gusto ponerme en contacto con ustedes!',
                        sujeto:
                            'Es mi primera vez en el aplicativo inserge, busco contactarme con alguien',
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
