import 'package:flutter/material.dart';

import '../../../global/environment.dart';
import '../../../widgets/auth_labels.dart';
import '../../../widgets/auth_logo.dart';
import '../SignIn/signin_page.dart';
import 'signup_form.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

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
                AuthenticationLogo(title: 'Register'),
                SignUpForm(),
                Spacer(),
                AuthenticationLabels(
                    title: 'Already have an account?',
                    subtitle: 'Sign in!',
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (_, __, ___) => SignInPage(),
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
