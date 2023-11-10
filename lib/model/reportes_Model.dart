import 'package:cloud_firestore/cloud_firestore.dart';

class ReportesModel {
  final String? ide;
  late final int? estado;
  late final DateTime? fecharegistro;
  final bool? preguntaone;
  final bool? preguntatwo;
  final bool? preguntathree;
  final String? observacion;
  final String? userUID;
  late List<dynamic>? url;

  ReportesModel({
    this.ide,
    this.estado,
    this.fecharegistro,
    this.preguntaone,
    this.preguntatwo,
    this.preguntathree,
    this.observacion,
    this.url,
    this.userUID,
  });

  factory ReportesModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return ReportesModel(
      ide: snap.reference.id,
      estado: snapshot["estado"],
      fecharegistro: (snapshot["fecharegistro"] as Timestamp).toDate(),
      preguntaone: snapshot["preguntaone"],
      preguntatwo: snapshot["preguntatwo"],
      preguntathree: snapshot["preguntathree"],
      observacion: snapshot["observacion"],
      url: snapshot["url"],
      userUID: snapshot["userUID"],
    );
  }

  Map<String, dynamic> toJson() => {
        "estado": estado,
        "fecharegistro": fecharegistro,
        "preguntaone": preguntaone,
        "preguntatwo": preguntatwo,
        "preguntathree": preguntathree,
        "observacion": observacion,
        "url": url,
        "userUID": userUID,
      };

  String getPreguntaTwo() {
    switch (preguntatwo) {
      case true:
        return "Si se encontraba el maestro a cargo.";
      case false:
        return "No se encontraba el maestro a cargo.";
      default:
        return "Error al seleccionar.";
    }
  }

  String getEstado() {
    switch (estado) {
      case 1:
        return "Entrega de Materiales.";
      case 2:
        return "Ubicación y limpieza de terreno.";
      case 3:
        return "Trazo y excavación de zanjas para cimiento.";
      case 4:
        return "Armado de columnas.";
      case 5:
        return "Vaciado de cimientos.";
      case 6:
        return "Armado y vaciado de sobrecimiento.";
      case 7:
        return "Asentado de ladrillos.";
      case 8:
        return "Vaciado de Columna.";
      case 9:
        return "Acero de techo y encofrado.";
      default:
        return "Error al seleccionar.";
    }
  }

  String getHour() {
    return "${fecharegistro?.hour}:${fecharegistro?.minute}";
  }

  String getDate() {
    return "${fecharegistro?.day}/${fecharegistro?.month}/${fecharegistro?.year}";
  }

  String getPreguntaOne() {
    switch (preguntaone) {
      case true:
        return "Si se encontraba el Beneficiario.";
      case false:
        return "No se encontraba el beneficiario.";
      default:
        return "Error al seleccionar.";
    }
  }

  String getPreguntaThree() {
    switch (preguntathree) {
      case true:
        return "Si se encontraban los obreros trabajando.";
      case false:
        return "No se encontraban los obreros trabajando.";
      default:
        return "Error al seleccionar.";
    }
  }

  String getDataToCopy(String otherInfo) {
    return """
Estado: ${getEstado()}
Observación: $observacion
Fecha: ${getDate()}
Hora: ${getHour()}
${getPreguntaOne()}
${getPreguntaTwo()}
${getPreguntaThree()}
$otherInfo""";
  }
}
