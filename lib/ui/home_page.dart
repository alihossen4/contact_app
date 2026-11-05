import 'package:contact_app/ui/widget/add_contact.dart';
import 'package:contact_app/ui/widget/my_contact.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Future<void> _openAddContact() async {
    final contactAdded = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (context) => const AddContact()),
    );

    if (contactAdded == true && mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F8FC),
        foregroundColor: const Color(0xFF20243A),
        elevation: 0,
        scrolledUnderElevation: 0,
        // leading: IconButton(onPressed: (){}, icon: Icon(Icons.menu)),
        title: const Text(
          "Contacts",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(onPressed: (){},icon: const Icon(Icons.more_vert),)
        ],
      ),

      drawer: Drawer(
        child: ListView(
            
            children: [
               DrawerHeader(
                
                padding: .all(20),
                decoration: BoxDecoration(color: Colors.blue), child: Container(
                  height: 500,
                  child: Column(
                    
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    
                    children: [
                    Icon(size:45,color:Colors.white, Icons.groups_3_outlined),
                    SizedBox(height: 10,),
                    Text("My Contacts",style: TextStyle(color: Colors.white,fontSize: 24),),
                    SizedBox(height: 5,),
                    Text("Manage your friends easily",style: TextStyle(color: Colors.white,fontSize: 15)),
                  ],),
                )),
              ListTile(
                leading: IconButton(
                  onPressed:(){ Navigator.push(context, MaterialPageRoute(builder: (context)=>  HomePage()));},
                  icon: Icon(Icons.contact_page_outlined)),
                title: Text("My Contacts"),
              ),
              ListTile(
                leading: Icon(Icons.star),
                title: Text("Favorits"),
              ),
              ListTile(
                
                leading: IconButton(onPressed: (){
                  _openAddContact();
                }, icon: Icon(Icons.star_half_rounded)),
                title: Text("Add Contact"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Divider(color: Colors.grey.shade300,
                thickness: 1,
                ),
              ),
              ListTile(
                leading: Icon(Icons.facebook),
                title: Text("About app"),
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text("Settings"),
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text("Logout"),
              ),
            ],
          ),
      ),
      body: MyContact(),

      // body: Column(
      //   children: [

          
      //     SizedBox(height: 10,),
      //      Text("No Contacts yet", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),),
      //     //  Expanded(
      //     //    child: ListView.builder(itemCount:contacts.length, itemBuilder: (context,index){
      //     //     return ListTile(
      //     //       leading: Text(contacts[index].name),
      //     //       title: Text(contacts[index].phoneNumber),
      //     //     );
      //     //              }),
      //     //  ),          
      //   ],
      // ),
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
        onPressed: _openAddContact, icon: Icon(Icons.add)),
        
      // body: ,
    );
  }
}