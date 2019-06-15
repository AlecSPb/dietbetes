import 'package:dietbetes/view/login/login_controller.dart';
import 'package:flutter/material.dart';

import 'package:dietbetes/util/validator.dart';

import 'package:dietbetes/wigdet/loading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with ValidationMixin{
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _formLogin = GlobalKey<FormState>();
  LoginCtrl loginCtrl;
  final pwdFocus = FocusNode();

  @override
  void initState() {
    loginCtrl = LoginCtrl();
    loginCtrl.checkLogin(context);
    super.initState();
  }

  @override
  void dispose() {
    loginCtrl?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final logo = Center(
      child: Text('SELAMAT DATANG', style: TextStyle(fontSize: 24.0)),
    );
    
    Widget emailField(LoginCtrl loginCtrl) {
      return StreamBuilder(
        stream: loginCtrl.email,
        builder: (ctx, snapshoot) {
          return TextFormField(
            validator: validateEmail,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (v) => FocusScope.of(context).requestFocus(pwdFocus),
            onSaved: loginCtrl.updateEmail,
            // autofocus: true,
            decoration: InputDecoration(
              labelText: 'Email Anda',
              contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0)
            ),
          );
        },
      );
    }

    Widget passwordField(LoginCtrl loginCtrl) {
      return StreamBuilder(
        stream: loginCtrl.password,
        builder: (ctx, snapshoot) {
          return TextFormField(
            validator: validatePassword,
            focusNode: pwdFocus,
            onSaved: loginCtrl.updatePassword,
            textInputAction: TextInputAction.done,
            autofocus: false,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Masukan Kata Sandi',
              contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0)
            ),
          );
        },
      );
    }

    Widget buttons() {
      return Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: Container(
              height: 50.0,
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                border: Border(
                  top: BorderSide(width: 5.0),
                  right: BorderSide(width: 2.5),
                  left: BorderSide(width: 5.0)
                ),
              ),
              child: Center(child: Text('MASUK', style: TextStyle(fontSize: 18.0, color: Colors.black))),
            )
          ),
          Expanded(
            child: InkWell(
              onTap: () => Navigator.of(context).pushNamed('/register'),
              child: Container(
                height: 50.0,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(width: 5.0),
                    right: BorderSide(width: 5.0),
                    left: BorderSide(width: 2.5)
                  ),
                ),
                child: Center(child: Text('DAFTAR', style: TextStyle(fontSize: 18.0, color: Colors.black))),
              ),
            ),
          ),
        ],
      );
    }
    
    return 
    Scaffold(
      appBar: AppBar(
        title: Text('Dietbetes'),
      ),
      key: scaffoldKey,
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: true,
      body: Stack(
        children: <Widget>[
          Center(
            child: ListView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.only(left: 24.0, right: 24.0),
              children: <Widget>[
                logo,
                SizedBox(height: 48.0),
                Form(
                  key: _formLogin,
                  child: Column(
                    children: <Widget>[ 
                      buttons(),
                      Container(
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 5.0
                          )
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            SizedBox(height: 8.0),
                            Center(child: Text('Masukan Email dan Kata Sandi')),
                            SizedBox(height: 8.0),
                            emailField(loginCtrl),
                            SizedBox(height: 8.0),
                            passwordField(loginCtrl),
                            SizedBox(height: 8.0),
                            StreamBuilder(
                              // stream: loginCtrl.submitValid,
                              builder: (ctx, snapshoot) => RaisedButton(
                              onPressed: () => loginCtrl.isLoading != true ? loginCtrl.doLogin(this._formLogin) : null,
                              color: Colors.green,
                              child: Container(
                                child: Center(child: Text("Login", style: TextStyle(color: Colors.white))),
                              ),
                            ),
                            ),
                            RaisedButton(
                              onPressed: () => loginCtrl.handleSignIn(_formLogin),
                              color: Colors.red,
                              child: Container(
                                child: Row(
                                  children: <Widget>[
                                    Expanded(flex: 1, child: Icon(FontAwesomeIcons.googlePlusG, color: Colors.white)),
                                    Expanded(flex: 7,child: Center(child: Text("Sign In with Google", style: TextStyle(color: Colors.white))))
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ]
                  ),
                )
              ],
            ),
          ),
          StreamBuilder(
            initialData: false,
            stream: loginCtrl.isLoading,
            builder: (BuildContext ctx, AsyncSnapshot<bool> snapshot){
              return Loading(snapshot.data);
            }
          ),
        ]
      )
    );
  }
}