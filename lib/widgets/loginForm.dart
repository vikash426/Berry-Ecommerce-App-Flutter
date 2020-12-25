
import 'package:flutter/material.dart';
import 'package:berry/constants.dart';

class LoginForm extends StatefulWidget {
  final Function onEmailChanged,onPasswordChange,onCLick;

  LoginForm({@required this.onEmailChanged,@required this.onPasswordChange,@required this.onCLick});
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  


  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Image.asset('images/berryLogo.jpg', height: 200),
              ),
              SizedBox(height: 20.0),
              TextField(
                decoration: kTextFieldDecoration.copyWith(hintText: "Email"),
                onChanged: widget.onEmailChanged(),
              ),
              SizedBox(height: 12.0),
              TextField(
                obscureText: true,
                decoration: kTextFieldDecoration.copyWith(hintText: "Password"),
                onChanged: widget.onPasswordChange,
              ),
              SizedBox(height: 20.0),
              Builder(
                  builder: (context) => kButton(
                      txt: "Log In",
                      onPress: widget.onCLick())),
              
            ],
          ),
        );
  }
}