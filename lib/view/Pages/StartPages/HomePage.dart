import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:insergemobileapplication/controller/helper/management_helper.dart';

import '../../System/Widgets/AppBar/DefaultsAppBar.dart';
import '../MainPages/EntityChatPage.dart';
import '../MainPages/MyReportsPage.dart';
import '../MainPages/ResumePage.dart';


class StartHomePage extends StatefulWidget {
  final User user;
  const StartHomePage({super.key, required this.user});

  @override
  State<StartHomePage> createState() => _StartHomePageState(usuario: user);
}

class _StartHomePageState extends State<StartHomePage> {
  final User usuario;
  _StartHomePageState({required this.usuario});

  int _selectedIndex = 1;
  final PageController _pageController = PageController(
    initialPage: 1,
    keepPage: true,
  );

  final _pageList = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.paypal_rounded),
      label: 'Proyectos',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      label: 'Inicio',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Person',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.black,
        systemStatusBarContrastEnforced: true));
    return WillPopScope(
      onWillPop: () {
        _onWillPopScope(context);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: DefaultsAppBar.defaultAppBar(context),
        body: PageView(
          physics: const BouncingScrollPhysics(),
          controller: _pageController,
          onPageChanged: ((value) {
            setState(() {
              _selectedIndex = value;
            });
          }),
          children: [
            const MyReportsPage(),
            const ResumePage(),
            EntityChatPage(user: usuario),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Theme.of(context).canvasColor,
          elevation: 1,
          items: _pageList,
          currentIndex: _selectedIndex,
          onTap: (index) {
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeIn,
            );
          },
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Theme.of(context).unselectedWidgetColor,
          type: BottomNavigationBarType.shifting,
        ),
      ),
    );
  }

  void _onWillPopScope(BuildContext context) async {
    if (_selectedIndex == 1) {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Salir"),
            content: const Text("¿Seguro que quieres cerrar sesión?"),
            actions: [
              TextButton(
                onPressed: () {
                  UserManagement().signOut(context);
                  Navigator.of(context).pop();
                },
                child: const Text("Sí"),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text("No"),
              )
            ],
          );
        },
      );
    } else {
      _pageController.animateToPage(
        1,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeIn,
      );
    }
  }
}
