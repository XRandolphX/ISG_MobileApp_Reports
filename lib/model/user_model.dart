import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? uid;
  final String? descripcion;
  final String? role;
  final int? sesiones;
  final String? cargo;
  final String? area;
  final String? nombre;
  final String? urlImage;

  UserModel(
      {this.descripcion,
      this.sesiones,
      this.cargo,
      this.area,
      this.uid,
      this.role,
      this.nombre,
      this.urlImage});

  factory UserModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
        uid: snapshot["uid"],
        descripcion: snapshot["descripcion"],
        role: snapshot["role"],
        sesiones: snapshot["sesiones"],
        cargo: snapshot["cargo"],
        nombre: snapshot["nombre"],
        urlImage: snapshot["urlImage"],
        area: snapshot["area"]);
  }
}
