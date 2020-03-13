import 'package:flutter/material.dart';
import 'package:hello_fluter/services/auth.dart';
import 'package:hello_fluter/shared/loading.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;

  String _email = "";
  String _password = "";
  String _error = "";


  @override
  Widget build(BuildContext context) {
    return _loading ? Loading() : Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Color.fromRGBO(215, 2, 101, 1),
            elevation: 0,
            title: Text("Sign up to Spark")),
        body: Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
            child: Container(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "Email", 
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        labelText: "Email",
                      ),
                      validator: (value) => value.isEmpty ? "Enter an email" : null,
                      onChanged: (value) { 
                        setState(() {
                        _email = value;
                      });
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      validator: (value) => value.length < 6 ? "Enter a password 6+ chars longb " : null,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        labelText: ("Password"),
                      ),
                      obscureText: true,
                      onChanged: (value) { setState(() {
                        _password = value;
                      });},
                    ),
                    SizedBox(height: 20),
                    RaisedButton(
                      child: Text(
                        'Register',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      shape: StadiumBorder(),
                      color: Color.fromRGBO(215, 2, 101, 1),
                      padding: EdgeInsets.only(
                          left: 25, right: 25, top: 10, bottom: 10),
                      elevation: 5.0,
                      onPressed: () async  {
                        if (_formKey.currentState.validate()){
                          setState(() => _loading = true);
                          dynamic result = await _auth.registerWithEmailAndPassword(_email, _password);
                          if (result == null) {
                            setState(() {
                              _error = "Please supply valid email";
                              _loading = false;  
                            });
                          }
                        }
                      },
                    ),
                    SizedBox(height: 20),
                    RaisedButton(
                      child: Text(
                        'Sign in',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      shape: StadiumBorder(),
                      color: Color.fromRGBO(215, 2, 101, 1),
                      padding: EdgeInsets.only(
                          left: 25, right: 25, top: 10, bottom: 10),
                      elevation: 5.0,
                      onPressed: () async  {
                        widget.toggleView();
                      },
                    ),
                    SizedBox(height: 20),
                    Text(_error,
                    style: TextStyle(color: Colors.red, fontSize: 16),)
                  ],
                ),
              ),
            )));
  }
}