import 'package:contact_app/db/contact_database.dart';
import 'package:contact_app/model/contact.dart';
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
      const Center(child: Text('No contacts found.')),
      ]
      );
    }

    // 2. You now have a clean list of Contact objects!
    final List<Contact> contacts = snapshot.data!;

    return ListView.builder(
      itemCount: contacts.length,
      itemBuilder: (context, index) {
        final contact = contacts[index];
        return ListTile(
          // 3. Access properties directly using dot notation
          title: Text(contact.name),
          subtitle: Text(contact.phoneNumber),
        );
      },
    );
  },
),
    );
  }
}