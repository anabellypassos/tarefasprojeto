import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// Classe para gerenciar o banco de dados e suas operações
class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'tarefas.db');

    return await openDatabase(
      path,
      version: 2, // Atualiza a versão do banco de dados
      onCreate: _onCreate,
      onUpgrade: _onUpgrade, // Método para atualizar o banco de dados
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''    
      CREATE TABLE tarefas (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT,
        descricao TEXT,
        periodo TEXT,i
        concluida INTEGER DEFAULT 0 // Coluna para indicar se a tarefa está concluída (0 = não, 1 = sim)
      )
    ''');
  }

  // Função chamada para atualizar a estrutura do banco de dados
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('ALTER TABLE tarefas ADD COLUMN concluida INTEGER DEFAULT 0');
    }
  }

  Future<int> insertTask(Map<String, dynamic> tarefa) async {
    final db = await database;
    return await db.insert('tarefas', tarefa);
  }

  Future<List<Map<String, dynamic>>> getTasks() async {
    final db = await database;
    return await db.query('tarefas');
  }

  Future<void> deleteTask(int id) async {
    final db = await database;
    await db.delete(
      'tarefas',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Atualiza o estado de conclusão de uma tarefa
  Future<void> updateTaskStatus(int id, bool concluida) async {
    final db = await database;
    await db.update(
      'tarefas',
      {'concluida': concluida ? 1 : 0}, // Define 1 para concluída e 0 para não concluída
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
