import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_dev/controller/global_functions.dart';
import 'package:flutter_test_dev/controller/sign_in_controller.dart';
import 'package:flutter_test_dev/utils/globals.dart';
import 'package:flutter_test_dev/view/register/register_page.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<GlobalProviderController>(context);

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
        key: scaffoldKeyLogin,
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlutterLogo(
                        size: 120,
                      ),
                      SizedBox(
                        height: mediaQuery(context, 0.14),
                      ),
                      Row(
                        children: [
                          Text(
                            'Faça login em sua conta',
                            style: TextStyle(
                              color: Colors.white70,
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.bold,
                              fontSize: mediaQuery(context, 0.035),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: mediaQuery(context, 1),
                        margin: EdgeInsets.only(bottom: 5),
                        child: TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          focusNode: loginFocus,
                          validator: validateEmail,
                          autovalidate: true,
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).requestFocus(passwordFocus);
                          },
                          cursorColor: Colors.white,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            counterText: '',
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white70,
                              ),
                            ),
                            labelText: 'Email',
                            labelStyle: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: mediaQuery(context, 1),
                        margin: EdgeInsets.only(bottom: mediaQuery(context, 0.12)),
                        child: TextFormField(
                          controller: passwordController,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          focusNode: passwordFocus,
                          obscureText: boolButton,
                          cursorColor: Colors.white,
                          style: TextStyle(color: Colors.white),
                          autovalidate: true,
                          validator: validatePassword,
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).requestFocus(FocusNode());
                            onTapLogin(context);
                          },
                          decoration: InputDecoration(
                            counterText: '',
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.white,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                !boolButton
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.white,
                                size: 20,
                              ),
                              padding: EdgeInsets.all(0),
                              onPressed: () {
                                setState(() {
                                  boolButton = !boolButton;
                                });
                              },
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white70,
                              ),
                            ),
                            labelText: 'Senha',
                            labelStyle: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Gilroy',
                            ),
                          ),
                        ),
                      ),
                      StreamBuilder(
                        stream: streamIsLoadingLogin.stream,
                        builder: (context, AsyncSnapshot<dynamic> snapshot){
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return _loadingButton(false, controller);
                            case ConnectionState.active:
                              return _loadingButton(snapshot.data, controller);
                            default:
                              if (snapshot.hasError) {
                                return Container();
                              } else {
                                return Container();
                              }
                          }
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: mediaQuery(context, 0.05)),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Divider(
                                color: colorLight,
                                height: 15,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Container(
                                child: Text(
                                  "Não tem uma conta?",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontSize: mediaQuery(context, 0.04),
                                    color: colorLight,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: colorLight,
                                height: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                      _signUpButton(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
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
        border: Colors.white == null ? null : Border.all(color: colorBase),
      ),
      width: snapshot ? 50 : mediaQuery(context, 1),
      height: 50,
      alignment: Alignment.center,
      curve: Curves.fastOutSlowIn,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(snapshot ? 100 : 10)),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () async {
              onTapLogin(context);
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

  _signUpButton() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white24,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white24),
      ),
      width: mediaQuery(context, 1),
      height: 50,
      alignment: Alignment.center,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () async {
              Navigator.push(
                context,
                CupertinoPageRoute(builder: (context) => RegisterPage()),
              );
            },
            child: Center(
              child: Text(
                'INSCREVA-SE',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.bold,
                  fontSize: mediaQuery(context, 0.04),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
