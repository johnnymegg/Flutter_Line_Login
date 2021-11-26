import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_line_sdk/flutter_line_sdk.dart';
import 'package:line_login_test/login.dart';

class Profile extends StatefulWidget {
  const Profile({
    Key? key,
    required this.result,
  }) : super(key: key);

  final LoginResult result;

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                padding: const EdgeInsets.all(15.0),
                child: const Text('Login Success!!')),
            Container(
              padding: const EdgeInsets.all(15.0),
              child: CircleAvatar(
                radius: 40.0,
                backgroundImage: NetworkImage(
                  widget.result.userProfile!.pictureUrlLarge.toString(),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(15.0),
              child: Text('ID: ${widget.result.userProfile!.userId}'),
            ),
            Container(
              padding: const EdgeInsets.all(15.0),
              child:
                  Text('Username: ${widget.result.userProfile!.displayName}'),
            ),
            Container(
              padding: const EdgeInsets.all(15.0),
              child: Text('Token: ${widget.result.accessToken.data}'),
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
