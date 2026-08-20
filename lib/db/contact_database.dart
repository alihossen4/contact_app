import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
class ContactDatabase {
  static Database? db;

  static Future<Database> getDb() async{
    if(db!=null) return db!;

    db = openDatabase(
      p.join(getDatabasesPath(), 'contact.db'),
      onCreate: (_db.version){
        return _db.execute('CREATE TABLE contact(id INTEGER,name STRING,)')
      }
    );
  }

}