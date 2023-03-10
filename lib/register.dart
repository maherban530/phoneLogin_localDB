import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_bakers/Models/user_model.dart';

import 'db/dbhelper.dart';
import 'home.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final dbHelper = DatabaseHelper.instance;

  final TextEditingController firstNameController = new TextEditingController();
  final TextEditingController lastNameController = new TextEditingController();
  final TextEditingController phoneNumberController =
      new TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: _scaffoldKey,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                flex: 4,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                            height: 40,
                            width: 40,
                            margin: EdgeInsets.all(30),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Icon(Icons.arrow_back_ios_new)),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          "Get Started",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          "Please enter your mobile number to login or\ncreate an account",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      SizedBox(height: 40),
                      Row(
                        children: [
                          SizedBox(width: 20),
                          Expanded(child: buildFirstNameField()),
                          SizedBox(width: 16),
                          Expanded(child: buildLastNameField()),
                          SizedBox(width: 20),
                        ],
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: buildPhoneNumberField(),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                child: Container(
                  height: 40,
                  width: double.infinity,
                  margin: EdgeInsets.all(30),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.green.withOpacity(0.4),
                        spreadRadius: 1,
                        blurRadius: 9,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                        fontWeight: FontWeight.w500, color: Colors.white),
                  ),
                ),
                onTap: () async {
                  if (phoneNumberController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                        content: new Text('Please Enter Phone Number')));
                  } else {
                    if (_formKey.currentState!.validate()) {
                      _insert(firstNameController.text, lastNameController.text,
                          phoneNumberController.text.toString());
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField buildFirstNameField() {
    return TextFormField(
      controller: firstNameController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a First Name';
        }

        return null;
      },
      decoration: InputDecoration(
        hintText: "First Name",
        hintStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: (14)),
        filled: true,
        fillColor: Colors.grey.shade200,
        border: OutlineInputBorder(
          // borderSide: BorderSide.none,
          borderRadius: new BorderRadius.circular(6.0),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(6.0),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(6.0),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
      ),
    );
  }

  TextFormField buildLastNameField() {
    return TextFormField(
      controller: lastNameController,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a Last Name';
        }

        return null;
      },
      decoration: InputDecoration(
        hintText: "Last Name",
        hintStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: (14)),
        filled: true,
        fillColor: Colors.grey.shade200,
        border: OutlineInputBorder(
          borderRadius: new BorderRadius.circular(6.0),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(6.0),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(6.0),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
      ),
    );
  }

  IntlPhoneField buildPhoneNumberField() {
    return IntlPhoneField(
      decoration: InputDecoration(
        hintText: "Phone Number",
        hintStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: (14)),
        filled: true,
        fillColor: Colors.grey.shade200,
        border: OutlineInputBorder(
          borderRadius: new BorderRadius.circular(6.0),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(6.0),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(6.0),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      initialCountryCode: 'UG',
      dropdownIconPosition: IconPosition.trailing,
      disableLengthCheck: true,
      flagsButtonMargin: EdgeInsets.only(left: 10),
      validator: (value) {
        if (value!.number.isEmpty) {
          return 'Please enter a Phone Number';
        }
        return null;
      },
      onChanged: (phone) {
        phoneNumberController.text = phone.completeNumber;
        print(phone.completeNumber);
      },
    );
  }

  void _insert(name, lastname, String number) async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnName: name,
      DatabaseHelper.columnLastName: lastname,
      DatabaseHelper.columnphoneNumber: number
    };
    Users users = Users.fromMap(row);
    final id = await dbHelper.insert(users);

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setBool(
      "sessiondata",
      true,
    );

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Home()),
    );
    ScaffoldMessenger.of(context)
        .showSnackBar(new SnackBar(content: new Text('inserted row id: $id')));
  }
}
