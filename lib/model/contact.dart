

class Contact {
   final int? id;
   final String name;
   final String phoneNumber;
   final String email;
   final String address;

  Contact({this.id, required this.name,required this.phoneNumber, required this.email,required this.address});

  Map<String, dynamic> toMap(){
    return {
      "id": id,
      "name" : name,
      'phoneNumber': phoneNumber,
      "email" : email,
      "address" : address
    };
  }

  factory Contact.formMap(Map<String, dynamic> maps){
    return Contact(id: maps['id'],name: maps['name'],phoneNumber: maps['phoneNumber'], email: maps['email'], address: maps['address']);
  }
}