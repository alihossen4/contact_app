import 'package:contact_app/ui/widget/appbar.dart';
import 'package:flutter/material.dart';

class AddContact extends StatefulWidget {
  const AddContact({super.key});

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        // leading: IconBucontexttton(onPressed: (){}, icon: Icon(Icons.menu)),
        title: Text("Add Contact"),
        actions: [

          IconButton(
            padding: .symmetric(vertical:5),
            iconSize: 30,
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Colors.blue.shade700),
              
            ),
            onPressed: (){},icon: Icon(Icons.check),),
          SizedBox(width: 10,)
          // IconButton(onPressed: (){},icon: Icon(Icons.more_vert),)

        ],
      ),
      body: Container(
        padding: .all(10),
        alignment: Alignment.topCenter,
        child: Column(children: [
          SizedBox(height: 50,),
          CircleAvatar(
            
            radius: 50,
            backgroundColor: Colors.grey.shade200,
            child: IconButton( 
              iconSize: 50,
              style:ButtonStyle(
              foregroundColor:WidgetStateProperty.all(Colors.indigo.shade400) ,
            ), onPressed: (){}, icon: Icon(Icons.camera_alt_rounded)),
          )
        ],),
      ),
    );
  }
}