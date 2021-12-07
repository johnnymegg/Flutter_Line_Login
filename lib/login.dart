import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_line_sdk/flutter_line_sdk.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_login_test/profile.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            primary: const Color(0xFF00B900),
          ),
          onPressed: () {
            signIn();
          },
          icon: const FaIcon(FontAwesomeIcons.line),
          label: const Text('Login with Line'),
        ),
      ),
    );
  }

  signIn() async {
    try {
      LoginResult _result =
          await LineSDK.instance.login(scopes: ["profile", "openid"]);
      AccessTokenVerifyResult _verify =
          await LineSDK.instance.verifyAccessToken();
      if (_verify.channelId == "1656632301") {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => Profile(
              result: _result,
              verify: _verify,
            ),
          ),
          (route) => false,
        );
      }
    } on PlatformException catch (e) {
      print(e.message);
    }
  }
}
