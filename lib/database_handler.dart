import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'model/User.dart';

class DatabaseHandler {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'magic5.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, time INTEGER NOT NULL, attempts INTEGER NOT NULL)",
        );
        await database.execute(
          "CREATE TABLE users2(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, time INTEGER NOT NULL, attempts INTEGER NOT NULL)",
        );
      },
      version: 1,
    );
  }

  Future<int> insertUser(List<User> users) async {
    int result = 0;
    final Database db = await initializeDB();
    for (var user in users) {
      result = await db.insert('users', user.toMap());
    }
    return result;
  }

  Future<int> insertSingleUser(User user) async {
    int result = 0;
    final Database db = await initializeDB();
    result = await db.insert('users', user.toMap());
    //db.rawInsert("INSERT INTO users(name, age, username, password) values ('?','?','?','?')");
    return result;
  }

  Future<List<User>> showTop10() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult =
        await db.rawQuery("select * from users ORDER BY time Asc Limit 10");
    return queryResult.map((e) => User.fromMap(e)).toList();
  }
}
