import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/proyecto_model.dart';

mixin resume_helper {
  static countDocuments() async {
    final QuerySnapshot myDoc =
        await FirebaseFirestore.instance.collection('proyectos').get();
    return myDoc.docs.length; // Count of Documents in Collection
  }

  static getDocuments() async {
    final QuerySnapshot myDoc =
        await FirebaseFirestore.instance.collection('proyectos').get();
    return myDoc.docs
        .map((e) => ProyectoModel.fromSnapshot(e))
        .toList(); // Documents in Collection
  }

  static getLastProyec() async {
    final QuerySnapshot proyectoCollection = await FirebaseFirestore.instance
        .collection("proyectos")
        .orderBy('codiproyecto', descending: true)
        .get();
    return ProyectoModel.fromSnapshot(proyectoCollection.docs.first);
  }
}
