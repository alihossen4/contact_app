import 'package:contact_app/ui/home_page.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:sqflite_common_ffi/sqflite_ffi.dart'; 

void main() {
   WidgetsFlutterBinding.ensureInitialized();

  // ২. অ্যাপ লিনাক্স বা ডেক্সটপে চললে FFI ডাটাবেজ ফ্যাক্টরি সেট করুন [✉]
  if (Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
    sqfliteFfiInit(); // FFI ইঞ্জিন চালু করুন [✉]
    databaseFactory = databaseFactoryFfi; // গ্লোবাল ফ্যাক্টরি অ্যাসাইন করুন [✉]
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
