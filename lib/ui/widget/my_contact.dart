import 'package:contact_app/db/contact_database.dart';
import 'package:contact_app/model/contact.dart';
import 'package:contact_app/ui/widget/edit_contact.dart';
import 'package:flutter/material.dart';

class MyContact extends StatefulWidget {
  const MyContact({super.key});

  @override
  State<MyContact> createState() => _MyContactState();
}

class _MyContactState extends State<MyContact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.blue,
      //   foregroundColor: Colors.white,
      //   // leading: IconBucontexttton(onPressed: (){}, icon: Icon(Icons.menu)),
      //   title: Text("My Contacts"),
      //   actions: [

      //     IconButton(
      //       padding: .symmetric(vertical:5),
      //       iconSize: 30,
      //       style: ButtonStyle(
      //         backgroundColor: WidgetStateProperty.all(Colors.blue.shade700),
              
      //       ),
      //       onPressed: (){},icon: Icon(Icons.check),),
      //     SizedBox(width: 10,)
      //     // IconButton(onPressed: (){},icon: Icon(Icons.more_vert),)

      //   ],
      // ),
      body: FutureBuilder<List<Contact>>(
  future: DatabaseHelper.instance.getContact(), 
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    }
    
    if (!snapshot.hasData || snapshot.data!.isEmpty) {
      return Column(children:[
      Container(
            padding: .symmetric(horizontal: 45),
            margin: .only(top: 80),
            child: Image.asset("assets/images/contact_home.png"),
          ),
          SizedBox(height: 10,),
      const Center(child: Text('No contacts found.',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),)),
      ]
      );
    }

    // 2. You now have a clean list of Contact objects!
    final List<Contact> contacts = snapshot.data!;

    return Expanded(
      child: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
           if (contacts.isEmpty || index >= contacts.length) {
            return const SizedBox.shrink(); 
          }
          final contact = contacts[index];
          return ListTile(
            leading: CircleAvatar(
              radius: 30,
              child: Text(contact.name[0]),
            ),
            // 3. Access properties directly using dot notation
            title: Text(contact.name,style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
            subtitle: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(contact.email),
                Text(contact.phoneNumber),
              ],

            ),
            trailing: IconButton(onPressed: (){
              Navigator.push(context,MaterialPageRoute(builder: (context)=> EditContact()));
            },icon: Icon(Icons.arrow_right)),
          );
        },
      ),
    );
  },
),
    );
  }
}