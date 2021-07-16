import 'package:flutter/material.dart';

class AuthenticationLogo extends StatelessWidget {
  final String title;

  const AuthenticationLogo({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 250,
        margin: EdgeInsets.only(top: 20),
        child: Column(
          children: <Widget>[
            Image(image: AssetImage('assets/app_icon.png')),
            SizedBox(
              height: 20,
            ),
            Text(this.title, style: TextStyle(fontSize: 30))
          ],
        ),
      ),
    );
  }
}
