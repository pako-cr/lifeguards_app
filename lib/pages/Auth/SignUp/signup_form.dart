import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helpers/show_alert.dart';
import '../../../services/auth_service.dart';
import '../../../services/socket_service.dart';
import '../../../widgets/custom_auth_input.dart';
import '../../../widgets/custom_button.dart';
import '../Splash/splash_page.dart';

class SignUpForm extends StatefulWidget {
  @override
  _FormState createState() => _FormState();
}

class _FormState extends State<SignUpForm> {
  final nicknameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  bool _validForm = false;

  void validForm() {
    setState(() {
      this._validForm = this.nicknameTextController.text.isNotEmpty &&
          this.emailTextController.text.isNotEmpty &&
          this.passwordTextController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: true);
    final socketService = Provider.of<SocketService>(context);

    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: <Widget>[
          CustomAuthInput(
            icon: Icons.email_outlined,
            placeholder: 'Email',
            textController: emailTextController,
            keyboardType: TextInputType.emailAddress,
            onChanged: (_) => this.validForm(),
          ),
          CustomAuthInput(
            icon: Icons.lock_outline,
            placeholder: 'Password',
            textController: passwordTextController,
            keyboardType: TextInputType.visiblePassword,
            isPassword: true,
            onChanged: (_) => this.validForm(),
          ),
          CustomButton(
            title: 'Sign Up',
            onPressed: (authService.authInProgress) // || !this._validForm)
                ? () => null
                : () async {
                    FocusScope.of(context).unfocus();

                    final signUpResponse = await authService.signUp(
                        emailTextController.text.trim(),
                        passwordTextController.text.trim());

                    if (signUpResponse['result']) {
                      socketService.connect();
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                            pageBuilder: (_, __, ___) => SplashPage(),
                            transitionDuration: Duration(milliseconds: 0)),
                      );
                    } else {
                      showAlert(context, 'Alert', signUpResponse['msg']);
                    }
                  },
            enabled: (authService.authInProgress || !this._validForm),
          ),
        ],
      ),
    );
  }
}
