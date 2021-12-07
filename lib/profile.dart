import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_line_sdk/flutter_line_sdk.dart';
import 'package:line_login_test/login.dart';

class Profile extends StatefulWidget {
  const Profile({
    Key? key,
    required this.result,
    required this.verify,
  }) : super(key: key);

  final LoginResult result;
  final AccessTokenVerifyResult verify;

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    print(widget.result.accessToken.value);
    return Scaffold(
      body: Center(
        child: ListView(children: [
          Column(
            children: [
              Container(
                  padding: const EdgeInsets.all(15.0),
                  child: const Text('Login Success!!')),
              Container(
                padding: const EdgeInsets.all(15.0),
                child: CircleAvatar(
                  radius: 60.0,
                  backgroundImage: NetworkImage(
                    widget.result.userProfile!.pictureUrl.toString(),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15.0),
                child: Text('ID: ${widget.result.userProfile!.userId}'),
              ),
              Container(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                    'Display Name: ${widget.result.userProfile!.displayName}'),
              ),
              Container(
                padding: const EdgeInsets.all(15.0),
                child:
                    Text('Status: ${widget.result.userProfile!.statusMessage}'),
              ),
              Container(
                padding: const EdgeInsets.all(15.0),
                child:
                    Text('Access tokens: ${widget.result.accessToken.value}'),
              ),
              Container(
                padding: const EdgeInsets.all(15.0),
                child: Text('ID tokens: ${widget.result.accessToken.idToken}'),
              ),
              Container(
                padding: const EdgeInsets.all(15.0),
                child: Text('Verify result: ${widget.verify.data}'),
              ),
              Container(
                padding: const EdgeInsets.all(15.0),
                child: ElevatedButton.icon(
                  onPressed: () {
                    signOut();
                  },
                  icon: const Icon(Icons.logout),
                  label: const Text('Logout'),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }

  signOut() async {
    try {
      await LineSDK.instance.logout();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const Login(),
        ),
        (route) => false,
      );
    } on PlatformException catch (e) {
      print(e.message);
    }
  }
}
