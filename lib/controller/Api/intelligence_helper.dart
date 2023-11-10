import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:insergemobileapplication/model/querybutton_model.dart';

import '../../model/proyecto_model.dart';

mixin Search_helper {
  static Future<Map<String, dynamic>> getData(url) async {
    final http.Response response = await http.get(Uri.parse(
        'https://interpretation-system-inserge.herokuapp.com/ApiQuestIA?Query=${url}'));
    final decoded = await json.decode(response.body) as Map<String, dynamic>;
    return decoded;
  }

  static Future<Stream<List<ProyectoModel>>> read(
      Map<String, dynamic> decoded) async {
    // Recogemos la colección
    CollectionReference<Map<String, dynamic>> fireCollection =
        FirebaseFirestore.instance.collection(decoded['Answer']['collection']);
    // Preguntamos si será consulta detallada
    if (decoded['Answer'].containsKey('campos')) {
      // Busca con campos
      // Busca si ocurrirá busqueda compuesta
      Query<Map<String, dynamic>> fireWhere =
          getQueryInsets(decoded, fireCollection);
      // Retorna el listado de documentos del query
      return fireWhere.snapshots().map((querySnapshot) => querySnapshot.docs
          .map((e) => ProyectoModel.fromSnapshot(e))
          .toList());
    } else {
      // Busca solo colecciones
      // Retorna el listado de documentos de la coleccion
      return fireCollection.snapshots().map((querySnapshot) => querySnapshot
          .docs
          .map((e) => ProyectoModel.fromSnapshot(e))
          .toList());
    }
  }

  static List<QueryButtonModel> readMap(Map<String, dynamic> decoded) {
    final String coleccion = decoded['Answer']['collection'];
    final String probabilidad = decoded['Intents'][0]['probabilidad'];
    final List<QueryButtonModel> listado = [];
    listado
        .add(QueryButtonModel(type: 'Colección', sing: '=', modulo: coleccion));
    listado.add(QueryButtonModel(
        type: 'Probabilidad', sing: '=', modulo: probabilidad));
    if (decoded['Answer'].containsKey('campos')) {
      decoded['Answer']['campos'].forEach((key, value) {
        listado.add(QueryButtonModel(
            type: key, sing: value['Operator'], modulo: value['Value']));
      });
    }
    return listado;
  }

  static Query<Map<String, dynamic>> getQueryInsets(
      Map<String, dynamic> decoded,
      CollectionReference<Map<String, dynamic>> fireCollection) {
    int count = 0;
    late Query<Map<String, dynamic>> fireWhere;
    decoded['Answer']['campos'].forEach((key, value) {
      if (count == 0) {
        if (value['Operator'] == '=') {
          fireWhere = fireCollection.where(key, isEqualTo: value['Value']);
        } else if (value['Operator'] == '>') {
          fireWhere = fireCollection.where(key, isGreaterThan: value['Value']);
        } else if (value['Operator'] == '<') {
          fireWhere = fireCollection.where(key, isLessThan: value['Value']);
        }
        count++;
      } else {
        if (value['Operator'] == '=') {
          fireWhere = fireWhere.where(key, isEqualTo: value['Value']);
        } else if (value['Operator'] == '>') {
          fireWhere = fireWhere.where(key, isGreaterThan: value['Value']);
        } else if (value['Operator'] == '<') {
          fireWhere = fireWhere.where(key, isLessThan: value['Value']);
        }
      }
    });
    return fireWhere;
  }
}
