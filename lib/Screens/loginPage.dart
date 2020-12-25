import 'package:berry/Services/Database.dart';
import 'package:berry/constants.dart';
import 'package:flutter/material.dart';
import 'package:berry/Screens/signUpPage.dart';
import 'package:berry/Screens/mainPage.dart';
import 'package:berry/Screens/adminLogin.dart';

class LoginIn extends StatefulWidget {
  @override
  _LoginInState createState() => _LoginInState();
}

class _LoginInState extends State<LoginIn> {
  String email, password;
  var snackBar = SnackBar(content: Text('Fill all fields'));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
                          child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
        
        Image.asset('images/berryLogo.jpg', height: 200),
        SizedBox(height: 20.0),
        TextField(
          decoration: kTextFieldDecoration.copyWith(hintText: "Email"),
          onChanged: (value) {
              email = value;
          },
        ),
        SizedBox(height: 12.0),
        TextField(
          obscureText: true,
          decoration: kTextFieldDecoration.copyWith(hintText: "Password"),
          onChanged: (value) {
              password = value;
          },
        ),
        SizedBox(height: 20.0),
        Builder(
              builder: (context) => kButton(
                txt: "Log In",
                onPress: () async {
                  FocusScope.of(context).unfocus();
                  if (email == null || password == null) {
        Scaffold.of(context).showSnackBar(snackBar);
                  } else {
        String a = await Database().loginIN(email, password);
        snackBar = SnackBar(content: Text(a));
        Scaffold.of(context).showSnackBar(snackBar);
        if (a == "1") {
          currentCustomer =
                await Database().getCustomer(email);
          Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        MainPage(currentCustomer)));
        }
                  }
                })),
        SizedBox(height: 12.0),
        GestureDetector(
          onTap: () {
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignUpPage()));
          },
          child: Text("Don't have a account SignUp",
              style: TextStyle(color: Colors.blue)),
        ),
        FlatButton(
          onPressed: () {
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => AdminLogIn()));
          },
          child: Text("Admin"),
        ),
                  ],
                ),
            ),
          ));
  }
}
