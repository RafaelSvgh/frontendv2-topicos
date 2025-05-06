import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Database? _db;

  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await initDB();
    return _db!;
  }

  static Future<Database> initDB() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'leyes.db');

    final exists = await databaseExists(path);

    if (!exists) {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      final data = await rootBundle.load('assets/leyes.db');
      final bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(path).writeAsBytes(bytes, flush: true);
    }
    //print(path);
    return openDatabase(path, version: 1);
  }


  static Future<List<Map<String, dynamic>>> getArticulosAleatorios(
      int cantidad) async {
    final db = await database;
    return db.rawQuery('''
      SELECT d.nombre AS documento,
            d.fecha AS fecha,
             a.articulo_nro AS articuloNumero,
             a.articulo_titulo AS articuloNombre,
             a.contenido AS fragmento,
             a.capitulo AS capituloNumero,
             a.capitulo_nombre AS capituloNombre,
             a.titulo AS tituloNumero,
             a.titulo_nombre AS tituloNombre
      FROM articulos a
      JOIN documentos d ON a.id_documento = d.id
      ORDER BY RANDOM()
      LIMIT ?
    ''', [cantidad]);
  }

  static Future<List<Map<String, dynamic>>> buscarArticulos(
      String query) async {
    final db = await database;
    return db.rawQuery('''
      SELECT d.nombre AS documento,
            d.fecha AS fecha,
             a.articulo_nro AS articuloNumero,
             a.articulo_titulo AS articuloNombre,
             a.contenido AS fragmento,
             a.capitulo AS capituloNumero,
             a.capitulo_nombre AS capituloNombre,
             a.titulo AS tituloNumero,
             a.titulo_nombre AS tituloNombre
      FROM articulos a
      JOIN documentos d ON a.id_documento = d.id
      WHERE LOWER(a.contenido) LIKE ?
    ''', ['%${query.toLowerCase()}%']);
  }



}
