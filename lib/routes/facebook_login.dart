import 'dart:async';

import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter/material.dart';

class FacebookLoginScreen extends StatefulWidget {
  @override
  _FacebookLoginScreenState createState() => _FacebookLoginScreenState();
}

class _FacebookLoginScreenState extends State<FacebookLoginScreen> {
  static final FacebookLogin facebookLogin = new FacebookLogin();
  static final List<String> facebookLoginPermissions = [
    'email',
    'user_friends',
    'user_link',
    'user_birthday',
    'user_photos'
  ];

  String _message = 'Log in/out by pressing the buttons below.';

  Future<Null> _login() async {
    final FacebookLoginResult result =
    await facebookLogin.logIn(facebookLoginPermissions);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = result.accessToken;
        _showMessage('''
         Logged in!
         
         Token: ${accessToken.token}
         User id: ${accessToken.userId}
         Expires: ${accessToken.expires}
         Permissions: ${accessToken.permissions}
         Declined permissions: ${accessToken.declinedPermissions}
         ''');
        break;
      case FacebookLoginStatus.cancelledByUser:
        _showMessage('Login cancelled by the user.');
        break;
      case FacebookLoginStatus.error:
        _showMessage('Something went wrong with the login process.\n'
            'Here\'s the error Facebook gave us: ${result.errorMessage}');
        break;
    }
  }

  Future<Null> _logOut() async {
    await facebookLogin.logOut();
    _showMessage('Logged out.');
  }

  void _showMessage(String message) {
    setState(() {
      _message = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(_message),
              RaisedButton(
                onPressed: _login,
                child: new Text('Log in'),
              ),
              RaisedButton(
                onPressed: _logOut,
                child: new Text('Logout'),
              ),
            ],
          ),
        )
      )
    );
  }
}
