import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/proyecto_model.dart';

mixin Proyecto_helper {
  static Stream<List<ProyectoModel>> read() {
    final proyectoCollection = FirebaseFirestore.instance
        .collection("proyectos")
        .limit(10)
        .orderBy('codiproyecto', descending: false);
    return proyectoCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => ProyectoModel.fromSnapshot(e)).toList());
  }
}
