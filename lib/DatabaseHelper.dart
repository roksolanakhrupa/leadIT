import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {

  static final _databaseName = "leadit_task.db";
  static final _databaseVersion = 1;

  static final tablePost = 'posts';
  static final tableComments = 'comments';

  static final columnTableId = '_id';
  static final columnTableUserId = 'userId';
  static final columnTableTitle = 'title';
  static final columnTableBody = 'body';


  static final columnCommentId = '_id';
  static final columnCommentPostId = 'postId';
  static final columnCommentName = 'name';
  static final columnCommentEmail = 'email';
  static final columnCommentBody = 'body';


  DatabaseHelper._private();
  static final DatabaseHelper instance = DatabaseHelper._private();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);

    print(path);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);


  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $tablePost (
            $columnTableId INTEGER PRIMARY KEY,
            $columnTableUserId INTEGER NOT NULL,
            $columnTableTitle TEXT NOT NULL,
            $columnTableBody TEXT NOT NULL
          )
          ''');

    await db.execute('''
          CREATE TABLE $tableComments (
            $columnCommentId INTEGER PRIMARY KEY,
            $columnCommentPostId INTEGER NOT NULL,
            $columnCommentName TEXT NOT NULL,
            $columnCommentEmail TEXT NOT NULL,
            $columnCommentBody TEXT NOT NULL
          )
          ''');

  }

  Future<int> insertPost(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(tablePost, row);
  }

  Future<int> insertComment(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(tableComments, row);
  }



  Future<List<Map<String, dynamic>>> queryAllPosts() async {
    Database db = await instance.database;
    return await db.query(tablePost);
  }

  Future<List<Map<String, dynamic>>> queryAllComments() async {
    Database db = await instance.database;
    return await db.query(tableComments);
  }


}