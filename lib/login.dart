import 'dart:math';

import 'package:flutter/material.dart';
// import 'package:flutter_session/flutter_session.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_bakers/Models/user_model.dart';
import 'package:test_bakers/register.dart';

import 'db/dbhelper.dart';
import 'home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final dbHelper = DatabaseHelper.instance;
  List<Users> users = [];

  final TextEditingController phoneNumberController =
      new TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _queryAll();
    super.initState();
  }

  void _queryAll() async {
    final allRows = await dbHelper.queryAllRows();
    users.clear();
    allRows.forEach((row) => users.add(Users.fromMap(row)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Expanded(
            //   // flex: 3,
            //   child:
            SizedBox(height: 50),
            Container(
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
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                "Get Started",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: buildPhoneNumberField(),
            ),
            SizedBox(height: 14),
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
                  "Continue",
                  style: TextStyle(
                      fontWeight: FontWeight.w500, color: Colors.white),
                ),
              ),
              onTap: () async {
                if (phoneNumberController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                      content: new Text('Please Enter Phone Number')));
                } else {
                  var contain = users.where((element) =>
                      element.phoneNumber == phoneNumberController.text);
                  if (contain.isNotEmpty) {
                    // var sessions = FlutterSession();
                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.setBool(
                      "sessiondata",
                      true,
                    );
                    // await sessions.set(
                    //   "sessiondata",
                    //   Random().nextInt(100000).toString(),
                    // );

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                        new SnackBar(content: new Text("Login Successfull")));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                        content: new Text("Don't Register PhoneNumber")));
                  }
                }
              },
            ),
            // ),
            // Expanded(
            //   flex: 1,
            //   child:
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Text(
                //   "Don't have an account?",
                //   style: TextStyle(fontSize: (15)),
                // ),
                SizedBox(
                    width: 66, child: Divider(color: Colors.grey.shade700)),
                Text(
                  "OR",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: (15),
                  ),
                ),
                SizedBox(width: 66, child: Divider(color: Colors.grey)),
              ],
            ),
            // ),
            // Expanded(
            //   flex: 2,
            //   child:
            Center(
              child: InkWell(
                child: Container(
                  height: 40,
                  width: double.infinity,
                  margin: EdgeInsets.all(30),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Text(
                    "Sign up",
                    style: TextStyle(
                        fontWeight: FontWeight.w500, color: Colors.green),
                  ),
                ),
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Register()),
                  );
                },
              ),
            ),
            // ),
          ],
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
      initialCountryCode: 'UG',
      dropdownIconPosition: IconPosition.trailing,
      // dropdownIcon: Icon(Icons.),
      disableLengthCheck: true,
      flagsButtonMargin: EdgeInsets.only(left: 10),
      validator: (value) {
        if (value!.number.isEmpty) {
          return 'Please enter a Phone Number';
        }
        return null;
      },
      // controller: phoneNumberController,
      onChanged: (phone) {
        phoneNumberController.text = phone.completeNumber;
        print(phone.completeNumber);
      },
    );
  }
}
