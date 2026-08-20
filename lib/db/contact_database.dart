import 'package:contact_app/model/contact.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
class ContactDatabase {
  static Database? db;

  static Future<Database> getDb() async{
    if(db!=null) return db!;
    
    db = await openDatabase(
      p.join(await getDatabasesPath(), 'contact.db'),
      onCreate: (Database _db, int version){
        return _db.execute('CREATE TABLE contact(id INTEGER PRIMARY KEY AUTOINCREMENT,name Text,phoneNumber INTEGER, email, Text, address Text)');
      },
      version: 1,
    );
    return db!;
  }

  static Future<List<Contact>?> insertContact(Contact contact) async{
    final db = await getDb();
    db.insert('contact', contact.toMap());
    
  }

  static Future<List<Contact>> getContact()async{
    final db = await getDb();
    final List<Map<String, dynamic>> maps = await db.query('contacts');

    return List.generate(maps.length, (i)=>Contact.formMap(maps[i]));
    
  }

}