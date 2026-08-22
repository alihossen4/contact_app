import 'package:contact_app/db/contact_database.dart';
import 'package:contact_app/model/contact.dart';
import 'package:flutter/material.dart';

class EditContact extends StatefulWidget {
  const EditContact({super.key});

  @override
  State<EditContact> createState() => _EditContactState();
}

class _EditContactState extends State<EditContact> {

  @override
  void initState(){
    refreshContact();
    super.initState();
  }

  List<Contact> contacts = [];

  Future<void> refreshContact()async{
    final data = await DatabaseHelper.instance.getContact();
    setState((){
      contacts = data;
    
    });
  }
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
              title: Text("Name",style: TextStyle(fontSize: 14),),
              subtitle: Text(contacts[0].name,style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 20) ),
            ),
            SizedBox(height: 10,),
            ListTile(
              title: Text("Phone Number",style: TextStyle(fontSize: 14), ),
              subtitle: Text(contacts[0].phoneNumber,style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 20),),
            ),
            SizedBox(height: 10,),
            ListTile(
              title: Text("Email",style: TextStyle(fontSize: 14),),
              subtitle: Text(contacts[0].email ,style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 20)),
            ),
            SizedBox(height: 10,),
            ListTile(
              title: Text("Adress",style: TextStyle(fontSize: 14),),
              subtitle: Text(contacts[0].address ,style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 20)),
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