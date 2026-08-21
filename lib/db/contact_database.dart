import 'dart:io';
import 'package:contact_app/model/contact.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

// class ContactDatabase {
//   static Database? myDb;

//   static Future<Database> getDb() async{
//     if(myDb!=null) return myDb!;
    
//     myDb = await openDatabase(
//       p.join(await getDatabasesPath(), 'app_contacts.db'),
//       onCreate: (Database db,int version){
//         return db.execute('CREATE TABLE contact_table(id INTEGER PRIMARY KEY AUTOINCREMENT,name Text,phoneNumber INTEGER, email, Text, address Text)');
//       },
//       version: 1,
//     );
//     return myDb!;
//   }

//   static Future<void> insertContact(Contact contact) async{
//     final db = await getDb();
//     db.insert('contact', contact.toMap());
    
//   }

//   static Future<List<Contact>> getContact()async{
//     final db = await getDb();
//     final List<Map<String, dynamic>> maps = await db.query('contact');

//     return List.generate(maps.length, (i)=>Contact.formMap(maps[i]));
    
//   }

// }

// class ContactDatabase {
//   ContactDatabase._();
//   final ContactDatabase getInstance = ContactDatabase._();
//   final String contactTable = 'mycontact';
//   final int? ID;
//   final String? NAME;
//   final String? PHONENUMBER;
//   final String? EMAIL;
//   final String? ADDRESS;

//   static Database? myDb;
//   Future<Database> getDb() async {
//     myDb = myDb?? await openDb();
//     return myDb!;
//   }
//   static Future<Database> openDb() async{
//     Directory appDir = await getApplicationDocumentsDirectory();
//     String dbPath = p.join(appDir.path,'mycontactdb.db' );
//     return await openDatabase(dbPath,onCreate: (db, version){
//       db.execute('CREATE TABLE $contactTable($ID INTEGER PRIMARY KEY AUTOINCREMENT, $NAME Text,$PHONENUMBER INTEGER, $EMAIL, Text, $ADDRESS Text)');
//     },
//       version: 1,
//     );
//   }

//   // Future<void> addContact({required String name, required String phoneNumber, required String email, required String address})async{
//   //   var db = await getDb();
//   //   int rowEffected = await db.execute(contactTable,{
//   //     NAME= name,
//   //     PHONENUMBER = phoneNumber,
//   //     EMAIL = email,
//   //     ADDRESS = address
//   //   });
//   // }

//   static Future<void> insertContact(Contact contact) async{
//       dynamic db = await getDb();
//       db.insert(contactTable, contact.toMap());
//    }
// }

class DatabaseHelper {
  // Singleton pattern setup
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  // Get the active database connection
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('app_contacts.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = p.join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE contact_list (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        phoneNumber TEXT,
        email TEXT,
        address TEXT
      )
    ''');
  }

  // --- DATABASE OPERATIONS ---

  // Insert a contact
  Future<int> insertContact(Map<String, dynamic> row) async {
    final db = await instance.database;
    return await db.insert('contact_list', row);
  }

  // Fetch all contacts from any file
  Future<List<Contact>> getContact() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('contact_list');
    return List.generate(maps.length, (i){
      return Contact.fromMap(maps[i]);
    });
  }
}