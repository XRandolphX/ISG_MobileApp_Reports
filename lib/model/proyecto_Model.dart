
import 'package:cloud_firestore/cloud_firestore.dart';

class ProyectoModel {
  final String? codProyecto;
  final String? beneficiario;
  final String? dni;
  final String? address;
  final String? modulo;
  final String? telefono;
  final String? coordenadas;
  final String? departamento;
  final String? provincia;
  final String? distrito;
  final String? image;
  final String? id;

  ProyectoModel(
      {this.id,
      this.codProyecto,
      this.beneficiario,
      this.dni,
      this.address,
      this.modulo,
      this.telefono,
      this.coordenadas,
      this.departamento,
      this.provincia,
      this.distrito,
      this.image});

  factory ProyectoModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return ProyectoModel(
      id: snap.reference.id,
      codProyecto: snapshot["codiproyecto"],
      beneficiario: snapshot["beneficiario"],
      dni: snapshot["dni"],
      address: snapshot["direccion"],
      modulo: snapshot["modulo"],
      telefono: snapshot["telefono"],
      coordenadas: snapshot["coordenadas"],
      departamento: snapshot["departamento"],
      provincia: snapshot["provincia"],
      distrito: snapshot["distrito"],
      image: '',
    );
  }

  Map<String, dynamic> toJson() => {
        "codiproyecto": codProyecto,
        "beneficiario": beneficiario,
        "dni": dni,
        "direccion": address,
        "modulo": modulo,
        "telefono": telefono,
        "coordenadas": coordenadas,
        "departamento": departamento,
        "provincia": provincia,
        "distrito": distrito,
      };

  @override
  String toString() {
    if (codProyecto != null) {
      return 'codigo: $codProyecto';
    }
    return 'Without Data';
  }
}
