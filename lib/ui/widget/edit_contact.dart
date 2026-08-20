
import 'package:flutter/material.dart';

class EditContact extends StatefulWidget {
  const EditContact({super.key});

  @override
  State<EditContact> createState() => _EditContactState();
}

class _EditContactState extends State<EditContact> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: .all(20),
      child: Column(children: [
        SizedBox(height: 30,),
        CircleAvatar(
            radius: 50,
            backgroundColor: Colors.lightBlue.shade50,
            child: IconButton( 
              iconSize: 50,
              style:ButtonStyle(
              foregroundColor:WidgetStateProperty.all(Colors.blue.shade800) ,
            ), onPressed: (){}, icon: Icon(Icons.camera_alt_rounded)),
          ),
          ListTile(
            style: ListTileStyle(
              
            ),
            subtitle: Text("Name"),
            title: Text(""),
          ),
      ],),
    );
  }
}