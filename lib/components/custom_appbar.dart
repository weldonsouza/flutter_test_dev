import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_dev/main.dart';
import 'package:flutter_test_dev/utils/globals.dart';
import 'package:flutter_test_dev/view/login/sign_in.dart';

// ignore: must_be_immutable
class CustomAppBar extends StatefulWidget {
  String title;

  CustomAppBar(this.title);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(widget.title),
      centerTitle: true,
      backgroundColor: colorDark,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.logout),
          onPressed: () async {
            final FirebaseUser user = await auth.currentUser();

            if (user == null) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('Ninguém se inscreveu.'),
                ),
              );
              return;
            }

            await auth.signOut();

            final String uid = user.email;

            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('$uid saiu com sucesso.'),
              ),
            );

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SignIn()),
            );
          },
        ),
      ],
    );
  }
}
