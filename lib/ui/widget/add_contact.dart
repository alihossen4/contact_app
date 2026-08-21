import 'package:contact_app/db/contact_database.dart';
import 'package:contact_app/model/contact.dart';
import 'package:flutter/material.dart';

class AddContact extends StatefulWidget {
  const AddContact({super.key});
  
  @override
  State<AddContact> createState() => _AddContactState();
  
  
}

class _AddContactState extends State<AddContact> {
  
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController numberController = TextEditingController();
    final TextEditingController addressController = TextEditingController();

  Future<void> addContact()async{
    DatabaseHelper.instance.insertContact(
      Contact(name:nameController.text, email: emailController.text, phoneNumber: numberController.text, address: addressController.text).toMap());
      nameController.clear();
      emailController.clear();
      numberController.clear();
      addressController.clear();
  }
  @override
    void dispose(){
      nameController.dispose();
      emailController.dispose();
      numberController.dispose();
      addressController.dispose();
      super.dispose();
    }
  // List<Contact> contacts = [];

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
          SizedBox(width: 10,),
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
            backgroundColor: Colors.lightBlue.shade50,
            child: IconButton( 
              iconSize: 50,
              style:ButtonStyle(
              foregroundColor:WidgetStateProperty.all(Colors.blue.shade800) ,
            ), onPressed: (){}, icon: Icon(Icons.camera_alt_rounded)),
          ),
          Column(
            children: [
              SizedBox(height: 35,),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  maintainHintSize: true,
                  focusColor: Colors.grey.shade200,
                  prefixIcon: Icon(Icons.person_outline),
                  hintText: "Name",
                  fillColor: Colors.green,
                  hintStyle: TextStyle(fontSize: 20, color: Colors.grey.shade500),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  )
                ),
              ),
              SizedBox(height: 15,),
              TextField(
                autofocus: false,
                controller: numberController,
                decoration: InputDecoration(
                  maintainHintSize: true,
                  focusColor: Colors.grey.shade200,
                  prefixIcon: Icon(Icons.phone),
                  hintText: "Phone Number",
                   hintStyle: TextStyle(fontSize: 20, color: Colors.grey.shade500),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  )
                ),
              ),
              SizedBox(height: 15,),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  maintainHintSize: true,
                  focusColor: Colors.grey.shade200,
                  prefixIcon: Icon(Icons.mail_outlined),
                  hintText: "Email",
                   hintStyle: TextStyle(fontSize: 20, color: Colors.grey.shade500),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  )
                ),
              ),
              SizedBox(height: 15,),
              TextField(
                controller: addressController,
                decoration: InputDecoration(
                  maintainHintSize: true,
                  focusColor: Colors.grey.shade200,
                  prefixIcon: Icon(Icons.location_on_outlined),
                  hintText: "Address",
                   hintStyle: TextStyle(fontSize: 20, color: Colors.grey.shade500),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  )
                ),
              ),
              SizedBox(height: 40,),
              SizedBox(
                width: double.infinity,
                child: FilledButton(onPressed: (){
                  addContact();
          
                } ,style: FilledButton.styleFrom(
                  backgroundColor: Colors.blue.shade700,
                  padding: .symmetric(horizontal:5,vertical: 15 ),
                  textStyle: TextStyle(fontSize: 24),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ), child: Text("Save Contact")),
              ),
              
            ],
          
          )
        ],),
      ),
    );
  }
}