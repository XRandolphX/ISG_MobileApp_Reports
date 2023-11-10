import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:insergemobileapplication/controller/helper/management_helper.dart';
import 'package:insergemobileapplication/view/System/Settings/ProfileConstant.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((value) => runApp(const MyApp()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Inserge Application Demo',
      themeMode: ThemeMode.system,
      darkTheme: ThemesConstants.darkTheme,
      theme: ThemesConstants.lightTheme,
      home: FutureBuilder(
          builder: (context, snapshot) {
            if (ConnectionState.done == snapshot.connectionState) {
              return UserManagement().handleAuth();
            } else {
              return SafeArea(
                child: Center(
                  child: SvgPicture.asset(
                    "assets/icons/InsergeSVGM.svg",
                    color: Colors.blueAccent,
                  ),
                ),
              );
            }
          },
          future: UserManagement().initializeFirebase()),
    );
  }
}
