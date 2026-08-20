

class AddContact {
  final int? id;
  final String name;
  final int phoneNumber;
  final String email;
  String? address;

  AddContact({this.id, required this.name,required this.phoneNumber, required this.email, this.address});

  Map<String, dynamic> toMap(){
    return {
      "id": id,
      "name" : name,
      'phoneNumber': phoneNumber,
      "email" : email,
      "address" : address
    };
  }

  factory AddContact.formMap(Map<String, dynamic> maps){
    return AddContact(id: maps['id'],name: maps['name'],phoneNumber: maps['phoneNumber'], email: maps['email'], address: maps['address']);
  }
}