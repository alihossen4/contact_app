import 'package:contact_app/ui/widget/add_contact.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        leading: IconButton(onPressed: (){}, icon: Icon(Icons.menu)),
        title: Text("My Contacts"),
        actions: [
          IconButton(onPressed: (){},icon: Icon(Icons.search),),
          IconButton(onPressed: (){},icon: Icon(Icons.more_vert),)

        ],
      ),
      body: Column(
        children: [
          Container(
            padding: .symmetric(horizontal: 45),
            margin: .only(top: 80),
            child: Image.asset("assets/images/contact_home.png"),
          ),
          SizedBox(height: 10,),
          Text("No Contacts yet", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),)
        ],
      ),
      floatingActionButton:  IconButton(
        padding: .all(5),
        iconSize: 45,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.indigo.shade500),
          foregroundColor: WidgetStateProperty.all(Colors.white),
          shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)))
        ),
        hoverColor: Colors.blue,
        autofocus: false,
        onPressed: (){
          Navigator.push(context, 
            MaterialPageRoute( builder: (context)=> const AddContact())
          );
        }, icon: Icon(Icons.add)),
        
      // body: ,
    );
  }
}