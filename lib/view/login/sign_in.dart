import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_dev/components/animated_button.dart';
import 'package:flutter_test_dev/components/custom_button.dart';
import 'package:flutter_test_dev/controller/global_functions.dart';
import 'package:flutter_test_dev/controller/network_test_connectivity.dart';
import 'package:flutter_test_dev/controller/sign_in_controller.dart';
import 'package:flutter_test_dev/utils/globals.dart';
import 'package:flutter_test_dev/view/register/register_page.dart';

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
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: Colors.transparent,
            key: scaffoldKeyLogin,
            body: SafeArea(
              top: true,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Center(
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKeyLogin,
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
                              controller: emailControllerLogin,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              focusNode: loginFocusLogin,
                              validator: validateEmail,
                              autovalidate: true,
                              onFieldSubmitted: (value) {
                                FocusScope.of(context).requestFocus(passwordFocusLogin);
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
                              controller: passwordControllerLogin,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.done,
                              focusNode: passwordFocusLogin,
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
                                  return AnimatedButton('ENTRAR', false);
                                case ConnectionState.active:
                                  return AnimatedButton('ENTRAR', snapshot.data);
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
                          CustomButton('INSCREVA-SE', RegisterPage()),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          //Barra de informando se tem internet
          NetworkTestConnectivity(),
        ],
      ),
    );
  }
}
