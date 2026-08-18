import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key, required this.title, this.icon , required this.leading});
  final dynamic leading;
  final dynamic icon;
  final String title;
  @override
  Widget build(BuildContext context) {
    return AppBar(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          leading: IconButton(onPressed: (){}, icon: Icon(Icons.menu)),
          title: Text(title),
          actions: [
            IconButton(onPressed: (){},icon: Icon(Icons.search),),
            IconButton(onPressed: (){},icon: Icon(Icons.more_vert),)

          ],
    );
  }
}