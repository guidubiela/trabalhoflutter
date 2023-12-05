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
    return await openDatabase(path, version: 3, onCreate: (db, version) async {
      await db.execute(
        '''CREATE TABLE carrinho(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nome TEXT,
            preco REAL,
            qtd INTEGER
          );''',
      );
    }, onUpgrade: ((db, oldVersion, newVersion) async {
      if (oldVersion == 1 && newVersion == 2) {
        await db.execute(
          '''CREATE TABLE compras(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              nome TEXT,
              preco REAL,
              qtd INTEGER
            );''',
        );
      }

      if (oldVersion == 2 && newVersion == 3) {
        await db.execute(
          ''' ALTER TABLE compras
              ADD COLUMN total REAL;'''
        );
      }
    }));
  }

  // Carrinho
  Future<void> insertProduct(String nome, double preco, int qtd) async {
    final db = await database;
    await db.insert('carrinho', {'nome': nome, 'preco': preco, 'qtd': qtd});
  }

  Future<List<Map<String, dynamic>>> getAllProducts() async {
    final db = await database;
    return db.query('carrinho', orderBy: 'id');
  }

  Future<void> updateProduct(int id, int qtd) async {
    final db = await database;
    final data = {'qtd': qtd};
    await db.update('carrinho', data, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> deleteProduct(int id) async {
    final db = await database;
    try {
      await db.delete('carrinho', where: 'id = ?', whereArgs: [id]);
    } catch (e) {}
  }

  // Compras
  Future<void> insertPurchases(
      String nome, double preco, int qtd, double total) async {
    final db = await database;
    await db.insert(
        'compras', {'nome': nome, 'preco': preco, 'qtd': qtd, 'total': total});
  }

  Future<List<Map<String, dynamic>>> getAllPurchases() async {
    final db = await database;
    return db.query('compras', orderBy: 'id');
  }
}
