class User {
  
  final String id;
  final String email;
  final String name;
  final String number;
  final String role;

  User({this.id, this.email, this.name, this.number, this.role});

  User.fromData(Map<String, dynamic> data) 
    : id = data['UserID'],
      email = data['Email'],
      name = data['Name'],
      number = data['Number'],
      role = data['Role'];

  Map<String, dynamic> toJson() {
    return {
      'UserID' : id,
      'Email' : email,
      'Name' : name,
      'Number' : number,
      'Role' : role
    };
  }

}