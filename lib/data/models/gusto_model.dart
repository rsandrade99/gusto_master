import 'package:hive/hive.dart';

part 'gusto_model.g.dart';

@HiveType(typeId: 0)
class GustoModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String nombre;

  @HiveField(2)
  final String tipo;

  @HiveField(3)
  final Map<String, dynamic> datosApi;

  GustoModel({
    required this.id,
    required this.nombre,
    required this.tipo,
    required this.datosApi,
  });
}
