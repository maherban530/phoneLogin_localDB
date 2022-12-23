import '../db/dbhelper.dart';

class Users {
  int id;
  String name;
  String phoneNumber;

  Users(this.id, this.name, this.phoneNumber);

  Users.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    phoneNumber = map['phoneNumber'];
  }

  Map<String, dynamic> toMap() {
    return {
      DatabaseHelper.columnId: id,
      DatabaseHelper.columnName: name,
      DatabaseHelper.columnphoneNumber: phoneNumber,
    };
  }
}
