import 'package:flutter/material.dart';
import 'package:lifeguards_app/pages/Auth/SignIn/signin_page.dart';
import 'package:lifeguards_app/pages/Home/Home/home_page.dart';
import 'package:lifeguards_app/services/auth_service.dart';
import 'package:lifeguards_app/services/socket_service.dart';
import 'package:provider/provider.dart';

import '../../../global/environment.dart';
import '../../../widgets/auth_logo.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: checkLoginState(context),
        builder: (context, snapshot) {
          return Scaffold(
            backgroundColor: Environment.backgroundColor,
            body: SafeArea(
              child: Container(
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    AuthenticationLogo(title: 'Guardavidas'),
                    Spacer(),
                    CircularProgressIndicator(
                      strokeWidth: 2,
                      backgroundColor: Environment.enabledColor,
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    ),
                    Spacer(),
                  ],
                )),
              ),
            ),
          );
        });
  }

  Future checkLoginState(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final socketService = Provider.of<SocketService>(context);
    final authenticated = await authService.isLogedIn();

    print('🟡 Authenticated: $authenticated');

    // authService.deleteToken();

    if (authenticated) {
      socketService.connect();
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (_, __, ___) => HomePage(),
              transitionDuration: Duration(milliseconds: 0)));
    } else {
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (_, __, ___) => SignInPage(),
              transitionDuration: Duration(milliseconds: 0)));
    }
  }
}
