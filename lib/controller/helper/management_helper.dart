import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:insergemobileapplication/model/user_model.dart';

import '../../view/Pages/StartPages/HomePage.dart';
import '../../view/Pages/StartPages/StartPage.dart';
import '../../view/System/Settings/ProfileConstant.dart';

class UserManagement {
  Future<FirebaseApp> initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  static Future<User?> loginUsingPass(
      {required String userd,
      required String pass,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential =
          await auth.signInWithEmailAndPassword(email: userd, password: pass);
      user = userCredential.user;
      await updateUserSesion();
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {}
    }
    return user;
  }

  Widget handleAuth() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  "assets/icons/InsergeSVGM.svg",
                  color: Colors.blueAccent,
                ),
                const CircularProgressIndicator(),
              ],
            ),
          );
        }
        if (snapshot.hasData) {
          UserManagement.readUserProperties().then((value) {
            UsuarioGlobal = UserModel.fromSnapshot(value.docs[0]);
          });
          return StartHomePage(user: FirebaseAuth.instance.currentUser!);
        }
        return const StartPage();
      },
    );
  }

  static readUserProperties() {
    var user = FirebaseAuth.instance.currentUser;
    return FirebaseFirestore.instance
        .collection("/users")
        .where('uid', isEqualTo: user?.uid)
        .get();
  }

  static getUserName(String? uid) async {
    QuerySnapshot user = await FirebaseFirestore.instance
        .collection("/users")
        .where('uid', isEqualTo: uid)
        .get();
    return UserModel.fromSnapshot(user.docs[0]).nombre;
  }

  static updateUserData(String description, String name) async {
    try {
      var user = FirebaseAuth.instance.currentUser;
      QuerySnapshot asd = await FirebaseFirestore.instance
          .collection("/users")
          .where('uid', isEqualTo: user?.uid)
          .get();
      await asd.docs[0].reference
          .update({"descripcion": description, "nombre": name});
      return true;
    } catch (e) {
      return false;
    }
  }

  static updateUserSesion() async {
    try {
      var user = FirebaseAuth.instance.currentUser;
      QuerySnapshot asd = await FirebaseFirestore.instance
          .collection("/users")
          .where('uid', isEqualTo: user?.uid)
          .get();
      int numSesions = await asd.docs[0].get('sesiones');
      await asd.docs[0].reference.update({"sesiones": numSesions + 1});
      return true;
    } catch (e) {
      return false;
    }
  }

  static updateUserPhoto(String url) async {
    var user = FirebaseAuth.instance.currentUser;
    QuerySnapshot asd = await FirebaseFirestore.instance
        .collection("/users")
        .where('uid', isEqualTo: user?.uid)
        .get();
    await asd.docs[0].reference.update({"urlImage": url});
  }

  signOut(BuildContext context) {
    FirebaseAuth.instance.signOut();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Sesión cerrada"),
    ));
  }
}
