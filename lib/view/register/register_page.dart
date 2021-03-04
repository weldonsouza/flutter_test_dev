import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_dev/controller/global_functions.dart';
import 'package:flutter_test_dev/main.dart';
import 'package:flutter_test_dev/utils/globals.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _success;
  String _userEmail;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.blueGrey[50],
            Colors.blueGrey,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        /*appBar: AppBar(
          title: Text('widget.title'),
          actions: <Widget>[
            Builder(
              builder: (BuildContext context) {
                return FlatButton(
                  child: Text('Sign out'),
                  textColor: Theme.of(context).buttonColor,
                  onPressed: () async {

                    final FirebaseUser user = await auth.currentUser();

                    if (user == null) {
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text('No one has signed in.'),
                        ),
                      );
                      return;
                    }
                    await auth.signOut();

                    final String uid = user.email;

                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text(uid + ' has successfully signed out.'),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),*/
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: <Widget>[
                FlutterLogo(
                  size: 100,
                ),
                _registerEmailSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _registerEmailSection(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextFormField(
          controller: _emailController,
          decoration: InputDecoration(labelText: 'Email'),
          validator: (String value) {
            if (value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
        ),
        TextFormField(
          controller: _passwordController,
          decoration: InputDecoration(labelText: 'Password'),
          validator: (String value) {
            if (value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          alignment: Alignment.center,
          child: RaisedButton(
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                _register();
              }
            },
            child: Text('Submit'),
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: Text(_success == null
              ? ''
              : (_success
              ? 'Successfully registered ' + _userEmail
              : 'Registration failed')),
        )
      ],
    );
  }

  _register() async {
    final FirebaseUser user = (await auth.createUserWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    )).user;
    if (user != null) {
      setState(() {
        _success = true;
        _userEmail = user.email;
      });
    } else {
      setState(() {
        _success = true;
      });
    }
  }

  _loadingButton(snapshot, controller) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 1500),
      decoration: BoxDecoration(
        color: colorBase,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.circular(snapshot ? 100 : 10),
        border: Colors.white == null
            ? null
            : Border.all(
          color: colorBase,
        ),
      ),
      width: snapshot ? 50 : mediaQuery(context, 1),
      height: 50,
      alignment: Alignment.center,
      //curve: Curves.bounceOut,
      curve: Curves.fastOutSlowIn,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(snapshot ? 100 : 10)),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () async {
              //streamIsLoadingLogin.sink.add(true);
              //onTapLogin(context, controllerOffline);
            },
            child: Center(
              child: AnimatedCrossFade(
                duration: Duration(milliseconds: 500),
                firstChild: Text(
                  'ENTRAR',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold,
                    fontSize: mediaQuery(context, 0.04),
                  ),
                ),
                secondChild: Container(
                  margin: EdgeInsets.all(8),
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.white,
                      ),
                    ),
                  ),
                ),
                crossFadeState: snapshot
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
