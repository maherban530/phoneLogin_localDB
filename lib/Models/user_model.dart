import '../db/dbhelper.dart';

class Users {
  int? id;
  String? name;
  String? lastname;
  String? phoneNumber;

  Users(this.id, this.name, this.phoneNumber);

  Users.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    lastname = map['lastname'];
    phoneNumber = map['phoneNumber'];
  }

  Map<String, dynamic> toMap() {
    return {
      DatabaseHelper.columnId: id,
      DatabaseHelper.columnName: name,
      DatabaseHelper.columnLastName: lastname,
      DatabaseHelper.columnphoneNumber: phoneNumber,
    };
  }
}
