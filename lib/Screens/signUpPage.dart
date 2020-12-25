import 'package:flutter/material.dart';
import 'package:berry/constants.dart';
import 'package:berry/Services/Database.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String name, email, password, number;
  var snackBar = SnackBar(content: Text('Fill all fields'));

  String a="waiting";
  String typedOTP;
  String otp = "000000";

  void sendOTP(String e) async {
    otp=await Database().sendOTP(e);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(elevation: 0.0),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(children: [
            Text(
              "SIGN UP",
              style: titleTextStyle,
            ),
            SizedBox(height: 12.0),
            TextField(
              decoration: kTextFieldDecoration.copyWith(hintText: "Name"),
              onChanged: (value) {
                name = value;
              },
            ),
            SizedBox(height: 12.0),
            TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: kTextFieldDecoration.copyWith(hintText: "Email"),
                onChanged: (value) {
                  email = value;
                }),
            SizedBox(height: 12.0),
            TextField(
                keyboardType: TextInputType.number,
                decoration:
                    kTextFieldDecoration.copyWith(hintText: "Phone Number"),
                onChanged: (value) {
                  number = value;
                }),
            SizedBox(height: 12.0),
            TextField(
                obscureText: true,
                decoration:
                    kTextFieldDecoration.copyWith(hintText: "Account Password"),
                onChanged: (value) {
                  password = value;
                }),
            SizedBox(height: 20.0),
            Builder(
              builder: (context) => RaisedButton(
                shape: kshape,
                color: Colors.blueAccent,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Register", style: buttonTextStyle),
                ),
                onPressed: () async {
                  if (name == null ||
                      password == null ||
                      email == null ||
                      number == null) {
                    Scaffold.of(context).showSnackBar(snackBar);
                  } else {
                    await showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        sendOTP(email);
                        return AlertDialog(

                        title:
                            Text("An Email has been sended to you with an OTP"),
                        content: TextField(
                            
                            decoration: kTextFieldDecoration,
                            onChanged: (value) {
                              typedOTP = value;
                            }),
                        actions: [
                          FlatButton(
                            onPressed: () async{
                              if(otp!=typedOTP)
                              a="Wrong otp try again";
                              else{
                                a=await Database().register(name,email,number,password);
                              }
                              Navigator.pop(context);
                            },
                            child: Text("Check"),
                          )
                        ],
                      );
                      }
                    );
                    
                    
                    Scaffold.of(context)
                        .showSnackBar(SnackBar(content: Text(a)));
                  }
                },
              ),
            ),
          ]),
        ));
  }
}
