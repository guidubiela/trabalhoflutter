import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final path = join(await getDatabasesPath(), 'padoca.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          '''CREATE TABLE carrinho(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nome TEXT,
            preco REAL,
            qtd INTEGER
          );''',
        );
      },
    );
  }

  Future<void> insertProduct(String nome, double preco, int qtd) async {
    final db = await database;
    await db.insert('carrinho', {'nome': nome, 'preco': preco, 'qtd': qtd});
  }

  Future<List<Map<String, dynamic>>> getAllProducts() async {
    final db = await database;
    return db.query('carrinho', orderBy: 'id');
    
  }

  Future<void> updateProduct(int id, String nome, double preco, int qtd) async {
    final db = await database;
    final data = {'nome': nome, 'preco': preco, 'qtd': qtd};
    await db.update(
      'carrinho',
      data,
      where: 'id = ?',
      whereArgs: [id]
    );
  }

  Future<void> deleteProduct(int id) async {
    final db = await database;
    try {
      await db.delete('carrinho', where: 'id = ?', whereArgs: [id]);
    }
    catch (e)  {}
  }
}
