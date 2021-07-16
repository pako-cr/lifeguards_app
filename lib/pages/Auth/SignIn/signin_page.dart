import 'package:flutter/material.dart';

import '../../../global/environment.dart';
import '../../../widgets/auth_labels.dart';
import '../../../widgets/auth_logo.dart';
import '../SignUp/signup_page.dart';
import 'signin_form.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Environment.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                AuthenticationLogo(title: 'Sign In'),
                SignInForm(),
                Spacer(),
                AuthenticationLabels(
                    title: '''Don't have an account?''',
                    subtitle: 'Create an account now!',
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (_, __, ___) => SignUpPage(),
                            transitionDuration: Duration(milliseconds: 0),
                          ));
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
