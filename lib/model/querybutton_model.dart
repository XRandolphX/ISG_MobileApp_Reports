class QueryButtonModel {
  final String type, modulo,sing;

  QueryButtonModel({
    required this.sing,
    required this.type,
    required this.modulo,
  });

  @override
  String toString() {
    // TODO: implement toString
    return '$type $sing $modulo';
  }
}
