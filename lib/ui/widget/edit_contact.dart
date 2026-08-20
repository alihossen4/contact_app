
import 'package:flutter/material.dart';

class EditContact extends StatefulWidget {
  const EditContact({super.key});

  @override
  State<EditContact> createState() => _EditContactState();
}

class _EditContactState extends State<EditContact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        // leading: IconBucontexttton(onPressed: (){}, icon: Icon(Icons.menu)),
        title: Text("Edit Contact"),
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
            SizedBox(height: 25,),
            ListTile(
              subtitle: Text("Name"),
              title: Text(""),
            ),
            SizedBox(height: 10,),
            ListTile(
              subtitle: Text("Name"),
              title: Text(""),
            ),
            SizedBox(height: 10,),
            ListTile(
              subtitle: Text("Name"),
              title: Text(""),
            ),
            SizedBox(height: 10,),
            ListTile(
              subtitle: Text("Name"),
              title: Text(""),
            ),
            
            SizedBox(height: 30,),
            SizedBox(
                  width: double.infinity,
                  child: FilledButton(onPressed: (){
            
                  } ,style: FilledButton.styleFrom(
                    backgroundColor: Colors.blue.shade700,
                    padding: .symmetric(horizontal:5,vertical: 15 ),
                    textStyle: TextStyle(fontSize: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ), child: Text("Save Contact")),
                ),
        ],),
      ),
    );
  }
}